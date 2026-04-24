import ProjectDescription

let project = Project(
    name: "ArsenalApp",
    targets: [
        .target(
            name: "ArsenalApp",
            destinations: .iOS,
            product: .app,
            bundleId: "com.arsenal.app",
            infoPlist: .default,
            sources: ["Targets/ArsenalApp/**"],
            resources: []
        )
    ]
)
