// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "CompSci",
  platforms: [.macOS(.v15)],
  dependencies: [
    .package(url: "https://github.com/maclong9/web-ui.git", from: "1.0.0"),
    .package(
      url: "https://github.com/maclong9/portfolio.git",
      branch: "main"
    ),
  ],
  targets: [
    .executableTarget(
      name: "Application",
      dependencies: [
        .product(name: "WebUI", package: "web-ui"),
        .product(name: "WebUIMarkdown", package: "web-ui"),
        .product(name: "Shared", package: "Portfolio"),
      ],
      path: "Sources"
    )
  ]
)
