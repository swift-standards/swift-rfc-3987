// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-rfc-3987",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "RFC 3987",
            targets: ["RFC 3987"]
        ),
        .library(
            name: "RFC 3987 Foundation",
            targets: ["RFC 3987 Foundation"]
        ),
    ],
    dependencies: [
        .package(path: "../../swift-primitives/swift-binary-primitives"),
        .package(path: "../../swift-foundations/swift-ascii")
    ],
    targets: [
        .target(
            name: "RFC 3987",
            dependencies: [
                .product(name: "Binary Primitives", package: "swift-binary-primitives"),
                .product(name: "ASCII", package: "swift-ascii")
            ]
            // Core module - uses INCITS_4_1986 for ASCII validation, no Foundation
        ),
        .target(
            name: "RFC 3987 Foundation",
            dependencies: ["RFC 3987"]
            // Foundation extensions - depends on core
        ),
        .testTarget(
            name: "RFC 3987".tests,
            dependencies: [
                "RFC 3987",
                "RFC 3987 Foundation"
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { self + " Tests" }
    var foundation: Self { self + " Foundation" }
}

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let existing = target.swiftSettings ?? []
    target.swiftSettings = existing + [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility")
    ]
}
