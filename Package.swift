// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-rfc-3987",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "RFC 3987",
            targets: ["RFC 3987"]
        )
    ],
    targets: [
        .target(
            name: "RFC 3987"
        ),
        .testTarget(
            name: "RFC 3987 Tests",
            dependencies: ["RFC 3987"]
        )
    ]
)

for target in package.targets {
    target.swiftSettings?.append(
        contentsOf: [
            .enableUpcomingFeature("MemberImportVisibility")
        ]
    )
}
