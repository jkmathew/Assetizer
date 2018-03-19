//
//  AssetGenerator.swift
//  AssetizerPackageDescription
//
//  Created by Johnykutty on 3/19/18.
//

import Foundation
import AppKit

func createAsset(with imagePath: String, size: CGSize) throws {
    
    guard let image = NSImage(contentsOf: URL(fileURLWithPath: imagePath)) else {
        throw Error.invalid(argument: "image")
    }
    
}
