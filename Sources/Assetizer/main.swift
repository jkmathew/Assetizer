import Foundation
import Commander

command(
    Option("input", default: "Input image file."),
    Option("size", default: CGSize.zero, description: "Size of 1x image.")
) { input, size in
    let writer = try AssetWriter(imagePath: input, size: size)
    try writer.createAssets()
    }.run()

