import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// A utility class containing helper methods for common application tasks.
///
/// This class provides static methods to format dates and times.
class AppHelpers {

  /// Formats a given [DateTime] object into a localized date string.
  ///
  /// The date is formatted as 'day of month, year' (e.g., '22 de agosto, 2025').
  /// It initializes date formatting for the 'es_MX' locale to ensure correct
  /// Spanish month names.
  ///
  /// - Parameters:
  ///   - [date]: The `DateTime` object to format.
  /// - Returns: A formatted date string.
  static String getFormattedDate(DateTime date) {
    initializeDateFormatting('es_MX', null);
    final formatter = DateFormat('dd \'de\' MMMM, yyyy', 'es_MX');
    return formatter.format(date);
  }

  /// Formats a given [DateTime] object into a time string.
  ///
  /// The time is formatted using the `jm` pattern, which typically displays
  /// the hour and minute with an AM/PM indicator (e.g., '11:53 PM').
  ///
  /// - Parameters:
  ///   - [date]: The `DateTime` object to format.
  /// - Returns: A formatted time string.
  static String getFormattedTime(DateTime date) {
    final formatter = DateFormat.jm();
    return formatter.format(date);
  }
}