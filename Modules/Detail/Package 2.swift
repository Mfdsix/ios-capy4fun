// Package.swift (root if you’re using SwiftPM to build the app)
dependencies: [
    .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0"),
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
        ]
    )
]
