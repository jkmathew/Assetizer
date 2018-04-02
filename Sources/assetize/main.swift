import Assetizer
import Commander
import Foundation

command(
  Argument<String>("input", description: "Input image file."),
//  Option("input", default: "", flag: "i", description: "Input image file."),
  Option("size", default: CGSize.zero, flag: "s", description: "Size of 1x image."),
  Option("output", default: "", flag: "o", description: "Output path."),
  Option("device", default: DeviceIdiom.universal, flag: "d", description: "Target device family.")
) { input, size, outputPath, device in

  var assetBasePath: String?
  if !outputPath.isEmpty {
    assetBasePath = outputPath
  } else if let path = UserDefaults.standard.persistentDomain(forName: "me.jkmathew.assetizer")?["outputPath"] as? String,
    !path.isEmpty {
    assetBasePath = path
  }
  let writer = try AssetWriter(input: input, size: size, output: assetBasePath, device: device)
  try writer.createAssets()
}.run()
