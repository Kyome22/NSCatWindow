// swift-tools-version: 6.0

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "NSCatWindow",
    platforms: [
        .macOS("13.0"),
    ],
    products: [
        .library(
            name: "NSCatWindow",
            targets: ["NSCatWindow"]
        ),
    ],
    targets: [
        .target(
            name: "NSCatWindow",
            swiftSettings: swiftSettings
        ),
    ]
)
