# Assetizer

Assetizer creates `imageset` from single image for using in iOS or macOS projects.

### Usage

#### From Source
Clone/Download this repo
```
cd /path/to/repo
swift build
./.build/x86_64-apple-macosx10.10/debug/Assetizer --input image.png --size 30x30
```
This will create `image.imageset`, which can be directly copied to your `images.xcassets`.

#### Within another SPM project

Add following line to your `Package.swift` file.
```
dependencies: [
...,
.package(url: "https://github.com/jkmathew/Assetizer.git", .upToNextMajor(from: "0.1.0"))
]
```
Then import package `Assetizer` . No you can use `AssetWriter` class like.
```
let writer = try AssetWriter(imagePath: "/path/to/input.png", size: CGSize(width: 30, height: 30))// you can pass CGSize.zero to take size from input.png
try writer.createAssets()
```

### TODO
- [x] Distribute as a package to use in SPM projects.
- [ ] Accept different device idioms.
- [ ] Create app icons.
- [ ] Specify o/p path.
- [ ] Ditribute through home brew.
- [ ] Support for linux.

### Author
Johnykutty - johnykutty.mathew@gmail.com
