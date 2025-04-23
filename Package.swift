// swift-tools-version: 5.9
import PackageDescription

let version = "4.11.0"
let checksum = "4b1e76f3d1ce19369ff7e151d1c564926b4d23b5515c62fc65517dfd395c3929"

let package = Package(
    name: "OpenCV",
    platforms: [
        .macOS(.v10_13), .iOS(.v12), .macCatalyst(.v13), .visionOS(.v1)
    ],
    products: [
        .library(
            name: "OpenCV",
            targets: ["opencv2", "opencv2-dependencies"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "opencv2",
            url: "https://github.com/yeatse/opencv-spm/releases/download/\(version)/opencv2.xcframework.zip",
            checksum: checksum
        ),
        .target(
            name: "opencv2-dependencies",
            dependencies: ["opencv2"],
            sources: [], // Important to declare it's a wrapper with no sources
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreImage"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreVideo", .when(platforms: [.iOS, .visionOS])),
                .linkedFramework("Accelerate", .when(platforms: [.iOS, .macOS, .visionOS])),
                .linkedFramework("OpenCL", .when(platforms: [.macOS])),
                .linkedLibrary("c++")
            ],
            swiftSettings: [
                .unsafeFlags(["-suppress-warnings"])
            ]
        )
    ]
)
