import ProjectDescription

#if compiler(<6.4)
#error("Modality requires Swift 6.4 or later.")
#endif

public extension Settings {
  /// Set the shared language, platform and diagnostic options.
  static func modalitySettings(
    base: ProjectDescription.SettingsDictionary = [:],
    debug: ProjectDescription.SettingsDictionary = [:],
    release: ProjectDescription.SettingsDictionary = [:],
    xcconfig: Path? = nil,
    excluding excludedSettings: Set<String> = []
  ) -> Settings {
    Settings.settings(
      base: ([
        "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
        "MACOSX_DEPLOYMENT_TARGET": "13.0",
        "XROS_DEPLOYMENT_TARGET": "1.0",
        "SWIFT_STRICT_CONCURRENCY": "complete",
        "SWIFT_VERSION": "6.0",
        "SWIFT_TREAT_WARNINGS_AS_ERRORS": "YES",
        "GCC_TREAT_WARNINGS_AS_ERRORS": "YES",
        "OTHER_LDFLAGS": ["-ObjC", "-lc++"],
        "ENABLE_PREVIEWS": "YES",
        "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": "YES",
        "ENABLE_MODULE_VERIFIER": "YES",
        "STRING_CATALOG_GENERATE_SYMBOLS": "YES",
      ] as SettingsDictionary).merging(base, uniquingKeysWith: { _, value in value })
        .filter { !excludedSettings.contains($0.key) },
      configurations: [
        .debug(
          name: "Debug",
          settings: ([
            "BUNDLE_DISPLAY_NAME": "${CFBundleDisplayName} Debug",
            "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
            "SWIFT_COMPILATION_MODE": "singlefile",
            "ENABLE_TESTABILITY": "YES",
            "BUILD_LIBRARY_FOR_DISTRIBUTION": "NO",
            "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "$(inherited) DEBUG"
          ] as SettingsDictionary).merging(debug, uniquingKeysWith: { _, value in value }),
          xcconfig: xcconfig
        ),
        .release(
          name: "Release",
          settings: ([
            "BUNDLE_DISPLAY_NAME": "${CFBundleDisplayName}",
            "SWIFT_OPTIMIZATION_LEVEL": "-O",
            "SWIFT_COMPILATION_MODE": "wholemodule",
            "ENABLE_TESTABILITY": "NO"
          ] as SettingsDictionary).merging(release, uniquingKeysWith: { _, value in value }),
          xcconfig: xcconfig
        )
      ],
      defaultSettings: .recommended(excluding: excludedSettings)
    )
  }
}
