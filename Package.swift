// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CloudData",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "CloudData",
            targets: ["CloudData"]),
    ],
    targets: [
        .target(
            name: "CloudData"),
        .testTarget(
            name: "CloudDataTests",
            dependencies: ["CloudData"]),
    ]
)
