// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum AppPopupView {
    /// You have to select a color!
    internal static let colorErrorMessage = L10n.tr("Localizable", "appPopupView.colorErrorMessage", fallback: "You have to select a color!")
    /// Cool!
    internal static let cool = L10n.tr("Localizable", "appPopupView.cool", fallback: "Cool!")
    /// Error
    internal static let error = L10n.tr("Localizable", "appPopupView.error", fallback: "Error")
    /// You have to enter a name!
    internal static let nameErrorMessage = L10n.tr("Localizable", "appPopupView.nameErrorMessage", fallback: "You have to enter a name!")
    /// OK
    internal static let ok = L10n.tr("Localizable", "appPopupView.ok", fallback: "OK")
    /// You have to enter 4 characters for your pin!
    internal static let pinErrorMessage = L10n.tr("Localizable", "appPopupView.pinErrorMessage", fallback: "You have to enter 4 characters for your pin!")
    /// Success 🎉
    internal static let success = L10n.tr("Localizable", "appPopupView.success", fallback: "Success 🎉")
    /// You have successfully returned the bike.
    internal static let successfullyReturned = L10n.tr("Localizable", "appPopupView.successfullyReturned", fallback: "You have successfully returned the bike.")
    /// Your trip is completed! 🎉
    internal static let tripIsComplete = L10n.tr("Localizable", "appPopupView.tripIsComplete", fallback: "Your trip is completed! 🎉")
    /// You have successfully register your bike! Check it on the map. 🌍
    internal static let youHaveRegister = L10n.tr("Localizable", "appPopupView.youHaveRegister", fallback: "You have successfully register your bike! Check it on the map. 🌍")
  }
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
  internal enum MyBike {
    /// Looks like you do not have a rented bike.
    internal static let dontHaveRentalBike = L10n.tr("Localizable", "myBike.dontHaveRentalBike", fallback: "Looks like you do not have a rented bike.")
    /// PIN
    internal static let pin = L10n.tr("Localizable", "myBike.pin", fallback: "PIN")
    /// Rent now!
    internal static let rentOneNow = L10n.tr("Localizable", "myBike.rentOneNow", fallback: "Rent now!")
    /// Return Bike
    internal static let returnBike = L10n.tr("Localizable", "myBike.returnBike", fallback: "Return Bike")
    /// Your Rented Bike Info
    internal static let yourBikesInfo = L10n.tr("Localizable", "myBike.yourBikesInfo", fallback: "Your Rented Bike Info")
  }
  internal enum Register {
    /// 
    internal static let empty = L10n.tr("Localizable", "register.empty", fallback: "")
    /// Bike location will be set as your current location.
    internal static let locationInfo = L10n.tr("Localizable", "register.locationInfo", fallback: "Bike location will be set as your current location.")
    /// OK
    internal static let ok = L10n.tr("Localizable", "register.ok", fallback: "OK")
    /// Register
    internal static let register = L10n.tr("Localizable", "register.register", fallback: "Register")
    internal enum Placeholder {
      /// Color
      internal static let color = L10n.tr("Localizable", "register.placeholder.color", fallback: "Color")
      /// Name
      internal static let name = L10n.tr("Localizable", "register.placeholder.name", fallback: "Name")
      /// Pin
      internal static let pin = L10n.tr("Localizable", "register.placeholder.pin", fallback: "Pin")
    }
  }
  internal enum RentBikeView {
    /// Bike Owner
    internal static let bikeOwner = L10n.tr("Localizable", "rentBikeView.bikeOwner", fallback: "Bike Owner")
    /// Color
    internal static let color = L10n.tr("Localizable", "rentBikeView.color", fallback: "Color")
    /// I Got It!
    internal static let iGotIt = L10n.tr("Localizable", "rentBikeView.iGotIt", fallback: "I Got It!")
    /// Rent!
    internal static let rent = L10n.tr("Localizable", "rentBikeView.rent", fallback: "Rent!")
    /// Use this pin to
    /// unlock your bike. 🔓
    internal static let useThisPin = L10n.tr("Localizable", "rentBikeView.useThisPin", fallback: "Use this pin to\nunlock your bike. 🔓")
  }
  internal enum TabBarItems {
    /// Map
    internal static let map = L10n.tr("Localizable", "tabBarItems.map", fallback: "Map")
    /// My Bike
    internal static let myBike = L10n.tr("Localizable", "tabBarItems.myBike", fallback: "My Bike")
    /// Register Bike
    internal static let registerBike = L10n.tr("Localizable", "tabBarItems.registerBike", fallback: "Register Bike")
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
