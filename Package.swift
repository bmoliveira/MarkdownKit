// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarkdownKit",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "MarkdownKit",
            targets: ["MarkdownKit"]
        ),
        .library(
            name: "MarkdownKit-Dynamic",
            type: .dynamic,
            targets: ["MarkdownKit"]
        )
    ],
    targets: [
        .target(
            name: "MarkdownKit",
            path: "MarkdownKit/Sources"
        ),
        .testTarget(
            name: "MarkdownKitTests",
            dependencies: ["MarkdownKit"],
            path: "MarkdownKit/Tests"
        )
    ]
)
