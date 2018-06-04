//
//  AssetizerTests.swift
//  Assetizer
//
//  Created by Johnykutty Mathew on 03/06/18.
//

@testable import Assetizer
import XCTest

class AssetizerTests: XCTestCase {
  let output = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("AssetizerTestOutput")
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
    do {
      try FileManager.default.removeItem(at: outputPath)
    } catch let error {
      XCTFail("\(error)")
    }
  }

  func testAssetCreation() {

    let filemanager = FileManager.default
    let currentPath = URL(fileURLWithPath: #file).deletingLastPathComponent()

    let input = currentPath.appendingPathComponent("SampleImages/swift_icon@3x.png")

    print("currentPath \(input)")
    print("output \(output)")
    do {
      let writer = try AssetWriter(input: input,
                                   size: CGSize(width: 30, height: 30),
                                   output: output,
                                   device: DeviceIdiom.universal)

      try writer.createAssets()
    } catch let error {
      XCTFail("\(error)")
    }
  }
}
