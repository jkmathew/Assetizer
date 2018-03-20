//
//  Error.swift
//  AssetizerPackageDescription
//
//  Created by Johnykutty on 3/19/18.
//

import Foundation
public enum Error : Swift.Error, CustomStringConvertible {
    case invalid(argument: String)
    case noImage(path: String)
    case error(reason: String)

    public var description:String {
        switch self {
        case .invalid(let argument):
            return "Value for `\(argument)` in invalid"
        case .noImage(let path):
            return "Image not found at `\(path)`"
        case .error(let reason):
            return "\(reason)"
        }
    }
}
