# Assetizer

Adding images to iOS/macOS project is not straight forward. You should add `1x` and/or ` 2x`  and/or ` 3x`  based on the screen size/ device. Your designer may give you the required  `1x`, ` 2x`, ` 3x` files. But what to do if they provide only one size or you downloading it from [here](https://materialdesignicons.com). You should resize it with preview and rename, then add to assetcatalog. If you are continuosly adding/ changing images (especially during initial development stage), doing all these repeated tasks may become boring. `Assetizer` will help you to do this tasks with a single line command.

## Installation

### From Source
```shell
$ git clone https://github.com/jkmathew/Assetizer.git
$ cd Assetizer
$ make
```

### With [Mint](https://github.com/yonaskolb/mint)
```shell
$ mint install jkmathew/Assetizer assetize
```

### With SPM

Add following line to your `Package.swift` file.
```
dependencies: [
...,
.package(url: "https://github.com/jkmathew/Assetizer.git", .upToNextMajor(from: "0.1.0"))
]
```
## Usage
### From terminal
```shell
$ assetize image.png --size 30x30
```
This will create `image.imageset`, which can  be directly used with your `images.xcassets`.

Additionaly you can pass following options
`--output`  - Output path, where you want to create the imageset.
  If you are working on a project continuously, you can set default output directory by entering,
```shell
$ defaults write me.jkmathew.assetizer outputPath /path/to/images.xcassets
```
  if `--output` option not passed and no default directory set, will create imageset in the input directory.
  
  `--device` - Target device family.  Accepted values - [`universal`, `iphone`, `ipad`, `watch`, `tv`, `mac`]

### Swift code
Import package `Assetizer` . Now you can use `AssetWriter` class like.
```
let writer = try AssetWriter(imagePath: "/path/to/input.png", size: CGSize(width: 30, height: 30))// you can pass CGSize.zero to take size from input.png
try writer.createAssets()
```

### TODO
- [x] Distribute as a package to use in SPM projects.
- [x] Accept different device idioms.
- [ ] Create app icons.
- [x] Specify o/p path.
- [ ] Ditribute through home brew.
- [ ] Support for linux.

### Author
Johnykutty - johnykutty.mathew@gmail.com
