//
//  AssetWriter.swift
//  AssetizerPackageDescription
//
//  Created by Johnykutty on 3/19/18.
//

import AppKit
import Foundation

extension CGSize {
  func scaled(to factor: CGFloat) -> CGSize {
    return CGSize(width: width * factor, height: height * factor)
  }
}

open class AssetWriter {
  let imageURL: URL
  let assetURL: URL
  let image: NSImage
  let imageName: String
  let size: CGSize
  let device: DeviceIdiom

  public init(input: URLConvertible,
              size: CGSize = .zero,
              output: URLConvertible? = nil,
              device: DeviceIdiom = .universal) throws {

    let imageURL = input.asURL()
    guard let image = NSImage(contentsOf: imageURL) else { throw Error.noImage(path: imageURL.lastPathComponent) }

    self.image = image
    imageName = imageURL.lastPathComponent.replacingOccurrences(of: ".\(imageURL.pathExtension)", with: "")
    self.imageURL = imageURL

    self.size = size.equalTo(CGSize.zero) ? image.size : size
    self.device = device

    let assetBase: URL
    if let output = output {
      assetBase = output.asURL()
    } else {
      assetBase = imageURL.deletingLastPathComponent()
    }
    assetURL = assetBase.appendingPathComponent("\(imageName).imageset")
  }

  open func createAssets() throws {
    let scales = device.scales

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
    } else {
      newImage = resize(image: image, size: scaledSize)
    }
    guard let tiff = newImage.tiffRepresentation, let tiffData = NSBitmapImageRep(data: tiff) else {
      throw Error.error(reason: "Failed to get tiffRepresentation")
    }
    guard let data = tiffData.representation(using: .png, properties: [:]) else {
      throw Error.error(reason: "Failed to get png Representation")
    }
    let scaleString = "\(String(format: "%.0f", scale))x"
    let filename = "\(imageName)@\(scaleString).png"
    let fileURL = assetURL.appendingPathComponent(filename)
    try data.write(to: fileURL)

    let imageJson = [
      "idiom": device.rawValue,
      "filename": filename,
      "scale": scaleString,
    ]
    return imageJson
  }

  func writeAssetContents(_ contents: [[String: String]], assetURL: URL) throws {
    let json: [String: Any] = [
      "images": contents,
      "info": ["version": 1, "author": "xcode"],
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
