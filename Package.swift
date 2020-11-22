// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "EasyDependency",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .macOS(.v10_10)
    ],
    products: [
        .library(name: "EasyDependency", targets: ["EasyDependency"])
    ],
    targets: [
		.target(
			name: "EasyDependency",
			path: "EasyDependency/Classes",
			exclude: ["Example/*", "EasyDependency.podspec"],
			publicHeadersPath: ".")
    ]
)
