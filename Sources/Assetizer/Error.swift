//
//  Error.swift
//  AssetizerPackageDescription
//
//  Created by Johnykutty on 3/19/18.
//

import Foundation
public enum Error : Swift.Error, CustomStringConvertible {
    case invalid(argument: String)

    public var description:String {
        switch self {
        case .invalid(let argument):
            return "Value for `\(argument)` in invalid"
        }
    }
}
