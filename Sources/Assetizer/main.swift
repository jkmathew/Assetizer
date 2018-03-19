import Foundation
import Commander

command(
    Option("input", default: "Input image file"),
    Option("size", default: CGSize.zero, description: "Size of 1x image")
) { input, size in
    print("input \(input) size \(size)")
    try createAsset(with: input, size: size)
    }.run()

