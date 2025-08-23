// 📦 Package imports:
import 'package:formz/formz.dart';

/// An enumeration of possible validation errors for a double value.
///
/// `empty`: Indicates that the field is empty.
/// `format`: Indicates that the value is not a valid double format.
enum DoubleFormzError { empty, format }

/// A custom Formz validator for double-formatted strings.
///
/// This validator extends `FormzInput` to handle validation logic for input
/// that is expected to be a double (a number with an optional decimal point).
/// It checks for both an empty value and an invalid numerical format.
class DoubleFormzValidator extends FormzInput<String, DoubleFormzError> {
  /// A regular expression to validate a string as a double.
  ///
  /// The regex matches one or more digits (`\d+`), optionally followed by a
  /// decimal point and one or more digits (`\.\d+`).
  static final RegExp doubleRegExp = RegExp(
    r'^\d+(\.\d+)?$',
  );

  /// Creates a pure (initial) instance of the validator.
  ///
  /// This constructor is used to represent the initial state of the form
  /// input before any user interaction.
  const DoubleFormzValidator.pure() : super.pure('');

  /// Creates a dirty (modified) instance of the validator.
  ///
  /// This constructor is used after the user has interacted with the input
  /// field.
  const DoubleFormzValidator.dirty(super.value) : super.dirty();

  /// A computed property that returns a user-friendly error message.
  ///
  /// It checks the `displayError` property to determine which error message
  /// to show to the user.
  String? get errorMessage {
    // If the input is valid or hasn't been touched, there's no error message to display.
    if (isValid || isPure) return null;

    // Return specific error messages for each validation error type.
    if (displayError == DoubleFormzError.empty) return 'El campo es requerido';
    if (displayError == DoubleFormzError.format) return 'Debe contener un valor decimal';

    return null;
  }

  /// The main validation method that checks the input value.
  ///
  /// It returns a `DoubleFormzError` if the value is invalid, and `null`
  /// if the value is valid. This method is called automatically by Formz
  /// whenever the input value changes.
  @override
  DoubleFormzError? validator(String value) {
    // Check for an empty value (after trimming whitespace).
    if (value.isEmpty || value.trim().isEmpty) return DoubleFormzError.empty;

    // Check if the value matches the double number format.
    if (!doubleRegExp.hasMatch(value)) return DoubleFormzError.format;

    // Return `null` if the value is valid.
    return null;
  }
}
