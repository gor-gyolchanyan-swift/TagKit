// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "TagKit",
    products: [
        .library(
            name: "TagKit",
            targets: ["TagKit"]
        ),
    ],
    targets: [
        .target(
            name: "TagKit"
        )
    ]
)
