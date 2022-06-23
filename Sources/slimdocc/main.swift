import CommandLineKit
import ColorizeSwift
import FileProvider

// MARK: Setup available flags
let cli = CommandLineKit.CommandLine()
let dirPath = StringOption(shortFlag: "d", longFlag: "directory", required: true, helpMessage: "Path to the directory that has been transformed for static hosting and needs slimming")

cli.addOptions(dirPath)

do {
  try cli.parse()
} catch {
  cli.printUsage(error)
}

// MARK: Check if directory exists
var isDir: ObjCBool = true
if !FileManager.default.fileExists(atPath: dirPath.value!, isDirectory: &isDir) {
    print("Directory \(dirPath.value!) does not exist, please provide a valid path for static documentation directory".backgroundColor(.red).foregroundColor(.white))
    exit(0)
}

// MARK: Traverse all directories and look for matches, delete if matching
let enumerator = FileManager.default.enumerator(atPath: dirPath.value!)
while let element = enumerator?.nextObject() as? String {
    let url = URL(string: element)!.deletingPathExtension().lastPathComponent
    let pattern = "-[a-zA-Z0-9]{4,5}$"
    let range = NSMakeRange(0, url.count)
    let regex = try NSRegularExpression(pattern: pattern)
    let match = regex.stringByReplacingMatches(in: url, range: range, withTemplate: "")
    
    if fileDeletionList.contains(match) {
        do {
            try FileManager.default.removeItem(atPath: "\(dirPath.value!)/\(element)")
            print("Deleted \(element)")
        } catch {
            print("Unable to delete \(element)".backgroundColor(.red), ", reason: \(error)".backgroundColor(.red))
        }
    }
}
