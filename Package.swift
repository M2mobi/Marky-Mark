// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Marky-Mark",
    platforms: [
        .iOS("8.0"),
    ],
    products: [
        .library(
            name: "markymark",
            targets: ["markymark"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "markymark",
            dependencies: [],
            path: "markymark"),
//        .target(
//            name: "markymark_Example",
//            dependencies: [],
//            path: "Example"),
//        .testTarget(
//            name: "markymark_Tests",
//            dependencies: [],
//            path: "Example"),
    ],
    swiftLanguageVersions: [.v4_2]
)
