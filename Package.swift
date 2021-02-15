// swift-tools-version:5.1
import PackageDescription

let package = Package(
	name: "MarkdownKit",
	platforms: [.macOS(.v10_13), .iOS(.v10), .tvOS(.v13)],
	products: [
		.library(
			name: "MarkdownKit",
			targets: ["MarkdownKit"]
		)
	],
	dependencies: [],
	targets: [
		.target(
			name: "MarkdownKit",
			dependencies: []),
	],
	path: "Sources",
	cxxLanguageStandard: .cxx14
)
