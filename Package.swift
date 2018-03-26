// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Assetizer",
  products: [
    .library(name: "Assetizer", targets: ["Assetizer"]),
    .executable(name: "Run", targets: ["Run"]),
    ],
  dependencies: [
    .package(url: "https://github.com/kylef/Commander.git", .upToNextMajor(from: "0.8.0")),
    ],
  targets: [
    .target(name: "Assetizer", dependencies: []),
    .target(name: "Run", dependencies: ["Assetizer", "Commander"]),
    ]
)
