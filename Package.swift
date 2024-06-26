// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

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
    ],
    dependencies: [
        .package(url: "https://github.com/thebrowsercompany/swift-windowsappsdk", branch: "main"),
        .package(url: "https://github.com/thebrowsercompany/swift-windowsfoundation", branch: "main"),
        .package(url: "https://github.com/ducaale/swift-winui", branch: "navigationview-bindings"),
        // .package(url: "https://github.com/apple/swift-syntax", from: "510.0.0"),
        // .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.1"),
    ],
    targets: [
        .target(
            name: "Swui",
            dependencies: [
                .product(name: "WinUI", package: "swift-winui"),
                .product(name: "WinAppSDK", package: "swift-windowsappsdk"),
                .product(name: "WindowsFoundation", package: "swift-windowsfoundation"),
                // .target(name: "SwuiMacros"),
            ],
            linkerSettings: GUILinkerSettings
        ),
        // .macro(
        //     name: "SwuiMacros",
        //     dependencies: [
        //         .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        //         .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        //     ]
        // ),
        .executableTarget(
            name: "Example",
            dependencies: ["Swui"],
            path: "Example/",
            resources: [.process("Resources")]
            // plugins: [.plugin(name: "StaticResourceGeneratorPlugin")]
        ),
        // .executableTarget(
        //     name: "StaticResourceGenerator",
        //     dependencies: [
        //         .product(name: "ArgumentParser", package: "swift-argument-parser"),
        //         .product(name: "SwiftSyntax", package: "swift-syntax"),
        //         .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
        //     ]
        // ),
        // .plugin(
        //     name: "StaticResourceGeneratorPlugin",
        //     capability: .buildTool,
        //     dependencies: [.target(name: "StaticResourceGenerator")]
        // ),
    ]
)
