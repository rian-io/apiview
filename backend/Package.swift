// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Backend",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        // 🗄 An ORM for SQL and NoSQL databases.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.9.0"),
        // 🪶 Fluent driver for SQLite.
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.6.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        // 📄 YAMS - Yet Another YAML parser for Swift, used for configuration files
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0"),
        // 🔒 JWT implementation to controll user session
        .package(url: "https://github.com/vapor/jwt.git", from: "5.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "Backend",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Yams", package: "Yams"),
                .product(name: "JWT", package: "jwt"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "BackendTests",
            dependencies: [
                .target(name: "Backend"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)

var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("ExistentialAny")
    ]
}
