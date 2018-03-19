//
//  CGFloatArgument.swift
//  AssetizerPackageDescription
//
//  Created by Johnykutty on 3/19/18.
//

import Commander
import Foundation

extension CGSize : ArgumentConvertible {
    public var description: String {
        return "{width: \(width), height: \(height)}"
    }
    
    public init(parser: ArgumentParser) throws {
        if let values = parser.shift()?.lowercased() {
            let components = values.components(separatedBy: "x")
            if components.count == 2,
                let width = Double(components[0]),
                let height = Double(components[1]){
                self = CGSize(width: width, height: height)
            } else {
                throw Error.invalid(argument: "size")
            }
        } else {
            throw ArgumentError.missingValue(argument: nil)
        }
    }
}
