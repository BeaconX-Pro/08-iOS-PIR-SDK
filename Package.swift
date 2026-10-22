// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "MKBeaconPirSensor",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "MKBeaconPirSensor",
            targets: ["MKBeaconPirSensor"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/MOKO-iOS-Base-Library/MKBaseBleModule.git", from: "1.1.6"),
        .package(url: "https://github.com/MOKO-iOS-Base-Library/MKBaseModuleLibrary.git", from: "2.2.15"),
        .package(url: "https://github.com/MOKO-iOS-Base-Library/MKCustomUIModule.git", from: "2.1.14"),
        .package(url: "https://github.com/MOKO-iOS-Base-Library/MKBeaconXCustomUI.git", from: "1.0.14"),
    ],
    targets: [
        .target(
            name: "MKBeaconPirSensor",
            dependencies: [
                "MKBaseBleModule",
                "MKBaseModuleLibrary",
                "MKCustomUIModule",
                "MKBeaconXCustomUI",
            ],
            path: "MKBeaconPirSensor",
            exclude: [
                "Classes/Functions/UpdatePage",  // NordicDFU 4.16.0 无 SPM
            ],
            sources: ["Classes"],
            resources: [.process("Assets")],
            publicHeadersPath: "Classes/PublicHeaders",
            cSettings: [
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/ConnectManager"),
                .headerSearchPath("Classes/CTMediator"),
                .headerSearchPath("Classes/SDK"),
                .headerSearchPath("Classes/Target"),
                .headerSearchPath("Classes/Functions/AboutPage/Controller"),
                .headerSearchPath("Classes/Functions/AdvertisementPage/Controller"),
                .headerSearchPath("Classes/Functions/AdvertisementPage/Model"),
                .headerSearchPath("Classes/Functions/AdvertisementPage/View"),
                .headerSearchPath("Classes/Functions/DeviceInfoPage/Controller"),
                .headerSearchPath("Classes/Functions/DeviceInfoPage/Model"),
                .headerSearchPath("Classes/Functions/PirHallSensorPage/Controller"),
                .headerSearchPath("Classes/Functions/PirHallSensorPage/Model"),
                .headerSearchPath("Classes/Functions/PirHallSensorPage/View"),
                .headerSearchPath("Classes/Functions/ScanPage/Controller"),
                .headerSearchPath("Classes/Functions/ScanPage/Model"),
                .headerSearchPath("Classes/Functions/ScanPage/View"),
                .headerSearchPath("Classes/Functions/SettingPage/Controller"),
                .headerSearchPath("Classes/Functions/SettingPage/Model"),
                .headerSearchPath("Classes/Functions/TabBarPage/Controller"),
                .headerSearchPath("Classes/Functions/UpdatePage/Controller"),
                .headerSearchPath("Classes/Vendor/CTMediator"),
                .headerSearchPath("Classes/Vendor/HHTransition"),
                .headerSearchPath("Classes/Vendor/MLInputDodger"),
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("CoreBluetooth"),
            ]
        )
    ]
)
