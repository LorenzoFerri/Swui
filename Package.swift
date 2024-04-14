// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let GUILinkerSettings: [LinkerSetting] = [
    .unsafeFlags(["-Xlinker", "/SUBSYSTEM:WINDOWS"], .when(configuration: .release)),
    // Update the entry point to point to the generated swift function, this lets us keep the same main method
    // for debug/release
    .unsafeFlags(["-Xlinker", "/ENTRY:mainCRTStartup"], .when(configuration: .release)),
]

let package = Package(
    name: "Swui",
    products: [
        .library(name: "Swui", targets: ["Swui"]),
        .executable(name: "Example", targets: ["Example"]),
    ],
    dependencies: [
        .package(url: "https://github.com/thebrowsercompany/swift-windowsappsdk", branch: "main"),
        .package(url: "https://github.com/thebrowsercompany/swift-windowsfoundation", branch: "main"),
        .package(url: "https://github.com/ducaale/swift-winui", branch: "navigationview-bindings"),
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0")
    ],
    targets: [
        .target(
            name: "Swui",
            dependencies: [
                .product(name: "WinUI", package: "swift-winui"),
                .product(name: "WinAppSDK", package: "swift-windowsappsdk"),
                .product(name: "WindowsFoundation", package: "swift-windowsfoundation"),
                "SwuiMacros",
            ],
            linkerSettings: GUILinkerSettings
        ),
        .macro(
            name: "SwuiMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .executableTarget(
            name: "Example",
            dependencies: ["Swui"],
            path: "Example/"
        ),
    ]
)
