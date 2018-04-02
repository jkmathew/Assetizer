//
//  DeviceIdiom.swift
//  Assetizer
//
//  Created by Johnykutty Mathew on 29/03/18.
//

import Foundation

public enum DeviceIdiom: String {
  case universal
  case iphone
  case ipad
  case watch
  case tv
  case mac

  var scales: [CGFloat] {
    switch self {
    case .universal, .iphone:
      return [1, 2, 3]
    case .watch:
      return [2]
    default:
      return [1, 2]
    }
  }
}
