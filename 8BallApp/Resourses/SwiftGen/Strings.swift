// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Cancel
  internal static let alertCancel = L10n.tr("Localizable", "alert-cancel")
  /// Create
  internal static let alertOk = L10n.tr("Localizable", "alert-ok")
  /// Create new answer
  internal static let alertTitle = L10n.tr("Localizable", "alert-title")
  /// Change question
  internal static let buttonText = L10n.tr("Localizable", "button-text")
  /// Change your mind
  internal static let changeYourMind = L10n.tr("Localizable", "change-your-mind")
  /// clock
  internal static let clock = L10n.tr("Localizable", "clock")
  /// 🔮
  internal static let emoji = L10n.tr("Localizable", "emoji")
  /// from API
  internal static let fromAPI = L10n.tr("Localizable", "from-API")
  /// History
  internal static let history = L10n.tr("Localizable", "history")
  /// Just do it!
  internal static let justDoIt = L10n.tr("Localizable", "just-do-it")
  /// Main
  internal static let main = L10n.tr("Localizable", "main")
  /// Ask a question and shake the phone
  internal static let ruleTitle = L10n.tr("Localizable", "rule-title")
  /// settings
  internal static let segueIdentifier = L10n.tr("Localizable", "segue-identifier")
  /// Please choose which answer will be used
  internal static let settingsHeader = L10n.tr("Localizable", "settings-header")
  /// star.circle.fill
  internal static let starCircleFill = L10n.tr("Localizable", "star-circle-fill")
  /// answerArray
  internal static let userDefaultsKey = L10n.tr("Localizable", "user-defaults-key")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
