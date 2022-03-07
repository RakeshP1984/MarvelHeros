// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library( name: "Network", targets: ["Network"])
    ],
    dependencies: [ .package(name: "Domain", path: "../Domain") ],
    targets: [
        .target( name: "Network", dependencies: ["Domain"]),
        .testTarget( name: "NetworkTests", dependencies: ["Network", "Domain"])
    ]
)
