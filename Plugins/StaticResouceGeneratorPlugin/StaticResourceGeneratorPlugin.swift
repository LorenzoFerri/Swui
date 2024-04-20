import PackagePlugin
import WinSDK

@main
struct StaticResourceGeneratorPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        let target = target.sourceModule!
        let resources = target.sourceFiles.filter { file in
            file.path.string.contains("Resources/")
        }
        let outputPath = context.pluginWorkDirectory.appending("_Resources.swift").fixedForWindows
        return [
            .buildCommand(
                displayName: "Generating static resources",
                executable: try! context.tool(named: "StaticResourceGenerator").path,
                arguments: ["--input-files"] + resources.map(\.path.string) + ["--output", outputPath],
                // outputFilesDirectory: outputPath
                inputFiles: resources.map(\.path),
                outputFiles: [outputPath]
            )
        ]
    }
}

typealias DWORD = UInt32
typealias LPCWSTR = UnsafePointer<UTF16.CodeUnit>?
typealias LPWSTR = UnsafeMutablePointer<UTF16.CodeUnit>?

extension String {
  /// Applies `converter` to the UTF-16 representation and returns the
  /// result, where converter has the signature and general semantics
  /// of Windows'
  /// [`GetFullPathNameW`](https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfullpathnamew).
  func utf16Converted(
    by converter: (LPCWSTR, DWORD, LPWSTR, UnsafeMutablePointer<LPWSTR>?) -> DWORD
  ) -> String {
    return self.withCString(encodedAs: UTF16.self) { pwszPath in
      let resultLengthPlusTerminator = converter(pwszPath, 0, nil, nil)
      return withUnsafeTemporaryAllocation(
        of: UTF16.CodeUnit.self, capacity: Int(resultLengthPlusTerminator)
      ) {
        _ = converter(pwszPath, DWORD($0.count), $0.baseAddress, nil)
        return String(decoding: $0.dropLast(), as: UTF16.self)
      }
    }
  }
}

extension Path {
  /// `self` with its internal representation repaired for Windows systems.
  var fixedForWindows: Path {
    #if os(Windows)
    return Self(string.utf16Converted(by: GetFullPathNameW))
    #else
    return self
    #endif
  }

}