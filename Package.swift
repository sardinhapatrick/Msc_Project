// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Msc_Project",
    products: [
      .executable(name: "Msc_Project", targets: ["Msc_Project"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/sardinhapatrick/Rendery.git", .branch("impRendery")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "Msc_Project", dependencies: ["Rendery"]),

        .testTarget(name: "Msc_ProjectTests", dependencies: ["Msc_Project"]),
    ]
)
