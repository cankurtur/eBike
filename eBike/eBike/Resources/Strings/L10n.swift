// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum General {
    /// Localizable.strings
    ///   eBike
    /// 
    ///   Created by Can Kurtur on 21.04.2023.
    internal static let areYouOffline = L10n.tr("Localizable", "general.areYouOffline", fallback: "Are you offline?")
    /// Check internet connection and try again
    internal static let checkInternetConnection = L10n.tr("Localizable", "general.checkInternetConnection", fallback: "Check internet connection and try again")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok", fallback: "OK")
    /// Try again
    internal static let tryAgain = L10n.tr("Localizable", "general.TryAgain", fallback: "Try again")
  }
  internal enum Map {
    internal enum Annotation {
      /// 🚲
      internal static let glyphText = L10n.tr("Localizable", "map.annotation.glyphText", fallback: "🚲")
    }
  }
  internal enum TabBarItems {
    /// Map
    internal static let map = L10n.tr("Localizable", "tabBarItems.map", fallback: "Map")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
