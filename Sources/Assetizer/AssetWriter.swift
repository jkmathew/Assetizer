//
//  AssetWriter.swift
//  AssetizerPackageDescription
//
//  Created by Johnykutty on 3/19/18.
//

import Foundation
import AppKit

extension CGSize {
    func scaled(to factor: CGFloat) -> CGSize {
        return CGSize(width: width * factor, height: height * factor)
    }
}

class AssetWriter {
    let imageURL: URL
    let assetURL: URL
    let image: NSImage
    let imageName: String
    let size: CGSize
    
    init(imagePath: String, size: CGSize) throws {
        let imageURL = URL(fileURLWithPath: imagePath)
        guard let image = NSImage(contentsOf: imageURL) else { throw Error.noImage(path: imagePath) }
        
        self.imageName = imageURL.lastPathComponent.replacingOccurrences(of: ".\(imageURL.pathExtension)", with: "")
        self.image = image
        self.imageURL = imageURL
        self.size = size.equalTo(CGSize.zero) ? image.size : size
        
        let assetFolder = "\(imagePath.split(separator: "/").dropLast().joined(separator: "/"))/\(imageName).imageset"
        self.assetURL = URL(fileURLWithPath: assetFolder)

    }
    
    func createAssets() throws {
        let scales: [CGFloat] = [1, 2, 3]
        
        try FileManager.default.createDirectory(at: assetURL, withIntermediateDirectories: true, attributes: nil)
        
        var images: [[String: String]] = []
        
        for scale in scales {
            let imageJson = try processImage(scale: scale)
            images.append(imageJson)
        }
        try writeAssetContents(images, assetURL: assetURL)
    }
    
    func processImage(scale: CGFloat) throws -> [String: String] {
        let scaledSize = size.scaled(to: scale)
        let newImage: NSImage
        if scaledSize.equalTo(image.size) {
            newImage = image
            print("\(scaledSize) not resizing")
        } else {
            newImage = resize(image: image, size: scaledSize)
            print("\(scaledSize)  resizing")
        }
        guard let tiff = newImage.tiffRepresentation, let tiffData = NSBitmapImageRep(data: tiff) else {
            throw Error.error(reason: "Failed to get tiffRepresentation")
        }
        guard let data = tiffData.representation(using: .png, properties: [:])else {
            throw Error.error(reason: "Failed to get png Representation")
        }
        let scaleString = "\(String(format: "%.0f", scale))x"
        let filename = "\(imageName)@\(scaleString).png"
        let fileURL = assetURL.appendingPathComponent(filename)
        try data.write(to: fileURL)
        
        let imageJson = ["idiom" : "universal",
                         "filename" : filename,
                         "scale" : scaleString]
        return imageJson
    }
    
    func writeAssetContents(_ contents: [[String: String]], assetURL: URL) throws {
        let json: [String: Any] = [
            "images" : contents,
            "info" : [ "version" : 1, "author" : "xcode"]
        ]
        let jsondata = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        try jsondata.write(to: assetURL.appendingPathComponent("Contents.json"))
    }
    
    func resize(image: NSImage, size: CGSize) -> NSImage {
        let newImage = NSImage(size: size)
        let sourceRect = CGRect(origin: CGPoint.zero, size: image.size)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        newImage.lockFocus()
        image.draw(in: rect, from: sourceRect, operation: .sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = size
        return NSImage(data: newImage.tiffRepresentation!)!
    }
}
