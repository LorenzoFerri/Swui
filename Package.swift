// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let GUILinkerSettings: [LinkerSetting] = [
    .unsafeFlags(["-Xlinker", "/SUBSYSTEM:WINDOWS"], .when(configuration: .release)),
    // Update the entry point to point to the generated swift function, this lets us keep the same main method
    // for debug/release
    .unsafeFlags(["-Xlinker", "/ENTRY:mainCRTStartup"], .when(configuration: .release)),
]

let package = Package(
    name: "swift-declarative-winui",
    dependencies: [
        .package(url: "https://github.com/thebrowsercompany/swift-windowsappsdk", branch: "main"),
        .package(url: "https://github.com/thebrowsercompany/swift-windowsfoundation", branch: "main"),
        .package(url: "https://github.com/ducaale/swift-winui", branch: "navigationview-bindings"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "swift-declarative-winui",
            dependencies: [
                .product(name: "WinUI", package: "swift-winui"),
                .product(name: "WinAppSDK", package: "swift-windowsappsdk"),
                .product(name: "WindowsFoundation", package: "swift-windowsfoundation"),
            ],
            // swiftSettings: [
            //     .unsafeFlags(["-parse-as-library"]),
            // ]
            linkerSettings: GUILinkerSettings
        ),
    ]
)
