// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// A class for managing the application's themes.
///
/// This class provides methods to generate a light and a dark theme for the
/// application, both based on a single primary color. This approach ensures
/// a consistent look and feel across different theme modes.
class AppTheme {
  /// The primary color used to generate the color schemes for both themes.
  final Color? primaryColor;

  /// Creates an instance of `AppTheme`.
  ///
  /// The [primaryColor] is a required parameter that serves as the base for
  /// the app's color palette.
  AppTheme({
    required this.primaryColor,
  });

  /// Returns a light theme configuration for the application.
  ///
  /// The theme is configured to use Material 3 and generates a light color
  /// scheme based on the provided [primaryColor].
  ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: primaryColor,
    );
  }

  /// Returns a dark theme configuration for the application.
  ///
  /// The theme is configured to use Material 3 and generates a dark color
  /// scheme based on the provided [primaryColor].
  ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: primaryColor,
    );
  }
}
