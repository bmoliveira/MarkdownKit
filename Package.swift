// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarkdownKit",
    products: [
        .library(
            name: "MarkdownKit",
            targets: ["MarkdownKit"]),
    ],
    targets: [
        .target(
            name: "MarkdownKit",
            dependencies: [])
    ]
)
