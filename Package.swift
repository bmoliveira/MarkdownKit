// swift-tools-version:5.1
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
            targets: ["MarkdownKit-UIKit"]
        ),
        .library(
            name: "MarkdownKit-AppKit",
            targets: ["MarkdownKit-AppKit"]
        ),
    ],
    targets: [
        .target(
            name: "MarkdownKit-UIKit",
            dependencies: ["MarkdownKit-Common"],
            path: "MarkdownKit/Sources",
            sources: ["Common", "UIKit"]
        ),
        .target(
            name: "MarkdownKit-AppKit",
            dependencies: ["MarkdownKit-Common"],
            path: "MarkdownKit/Sources",
            sources: ["Common", "AppKit"]
        ),
    ]
)
