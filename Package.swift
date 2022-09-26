// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSyntaxHighlighter",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SwiftSyntaxHighlighter",
            type: .dynamic,
            targets: ["SwiftSyntaxHighlighter"]),
        .executable(name: "swift-highlight",
                    targets: ["swift-highlight"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Highlighter",
                dependencies: [],
                linkerSettings: [
                    .linkedLibrary("SwiftParser"),
                    .linkedLibrary("SwiftSyntax"),
                ]),
        .target(name: "Pygments",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Pygments"),
        .target(name: "Xcode",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Xcode"),
        .target(
            name: "swift-highlight",
            dependencies: [
                "SwiftSyntaxHighlighter",
            ],
            linkerSettings: [
                .linkedLibrary("ArgumentParser"),
            ]),
        .target(
            name: "SwiftSyntaxHighlighter",
            dependencies: ["Highlighter", "Xcode", "Pygments"],
            linkerSettings: [
                .linkedLibrary("ArgumentParser"),
            ]),
        .testTarget(
            name: "SwiftSyntaxHighlighterTests",
            dependencies: ["SwiftSyntaxHighlighter"]),
    ]
)
