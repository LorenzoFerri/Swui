import ArgumentParser
import SwiftSyntaxBuilder
import SwiftSyntax
import Foundation 
@main
struct StaticResourceGenerator: ParsableCommand {
    @Option(name: .shortAndLong, parsing: .upToNextOption, completion: .file())
    var inputFiles: [String]

    @Option(name: .shortAndLong, completion: .file(extensions: ["swift"]))
    var output: String

    func run() throws {
        let files = inputFiles.map { $0.toFileNameAndExtension() }
        let source = SourceFileSyntax {
            "import Swui"
            "import Foundation"
            try! ExtensionDeclSyntax("extension Resource") {
                for file in files {
                    """
                    static var \(raw: file.0): Resource {
                        Resource(path: Bundle.module.path(forResource: "\(raw: file.0)", ofType: "\(raw: file.1)")!)  
                    }
                    """
                }
            }
        }
        let fileContent = source.formatted().description.data(using: .utf8)!
        // try? FileManager.default.removeItem(atPath: output)
        // FileManager.default.createFile(atPath: output, contents: fileContent)
        try fileContent.write(to: URL(fileURLWithPath: output))
    }
}

extension String {
    func toFileNameAndExtension() -> (String, String) {
        let components = self.components(separatedBy: "/")
        let fileName = components.last!
        let parts = fileName.components(separatedBy: ".")
        return (parts[0], parts[1])
    }
}


// extension Resource {
//     static var swift_svg: Resource {
//         Resource(path: Bundle.module.path(forResource: "swift", ofType: "svg")!)   
//     }
// }
