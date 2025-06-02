// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "Shared",
            path: "Shared.xcframework"
        )
    ]
)

