//
//  URLConvertible.swift
//  Assetizer
//
//  Created by Johnykutty Mathew on 29/03/18.
//

import Foundation

public protocol URLConvertible {
    func asURL() -> URL
}

extension URL: URLConvertible {
  public func asURL() -> URL {
    return self
  }
}

extension String: URLConvertible {
  public func asURL() -> URL {
    return URL(fileURLWithPath: self)
  }
}
