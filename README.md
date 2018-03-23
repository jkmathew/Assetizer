# Assetizer

Assetizer creates `imageset` from single image for using in iOS or macOS projects.

### Usage
Clone/Download this repo
```
cd /path/to/repo
swift build
./.build/x86_64-apple-macosx10.10/debug/Assetizer --input image.png --size 30x30
```
This will create `image.imageset`, which can be directly copied to your `images.xcassets`.

### TODO
- [ ] Accept different device idioms.
- [ ] Create app icons.
- [ ] Distribute as a package to use in SPM projects.
- [ ] Ditribute through home brew.
- [ ] Support for linux.

### Author
Johnykutty - johnykutty.mathew@gmail.com
