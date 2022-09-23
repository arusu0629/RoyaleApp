// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Presentation",
            targets: ["Presentation"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Analytics", path: "../Analytics"),
        .package(name: "Domain", path: "../Domain"),
        .package(url: "https://github.com/danielgindi/Charts", from: "4.1.0"),
        .package(url: "https://github.com/marcosgriselli/SwipeableTabBarController", from: "3.4.2"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.3.2"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", from: "9.11.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Presentation",
            dependencies: [
                .product(name: "Analytics", package: "Analytics"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Charts", package: "Charts"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "SwipeableTabBarController", package: "SwipeableTabBarController"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")
            ]),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"])
    ]
)
