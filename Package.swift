// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TreeSitterJjTemplate",
    products: [
        .library(name: "TreeSitterJjTemplate", targets: ["TreeSitterJjTemplate"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterJjTemplate",
            dependencies: [],
            path: ".",
            sources: [
                "src/parser.c",
                // NOTE: if your language has an external scanner, add it here.
            ],
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterJjTemplateTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterJjTemplate",
            ],
            path: "bindings/swift/TreeSitterJjTemplateTests"
        )
    ],
    cLanguageStandard: .c11
)
