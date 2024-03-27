// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NSCatWindow",
    platforms: [
        .macOS("13.0")
    ],
    products: [
        .library(
            name: "NSCatWindow",
            targets: ["NSCatWindow"]
        )
    ],
    targets: [
        .target(name: "NSCatWindow")
    ]
)
