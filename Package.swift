// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "slimdocc",
    dependencies: [
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/IngmarStein/CommandLineKit", .upToNextMajor(from: "2.3.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "slimdocc",
            dependencies: [
                .product(name: "ColorizeSwift", package: "ColorizeSwift"),
                .product(name: "CommandLineKit", package: "CommandLineKit"),
            ]),
        .testTarget(
            name: "slimdoccTests",
            dependencies: ["slimdocc"]),
    ]
)
