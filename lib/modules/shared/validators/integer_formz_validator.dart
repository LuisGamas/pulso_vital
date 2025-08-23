// 📦 Package imports:
import 'package:formz/formz.dart';

/// An enumeration of possible validation errors for an integer value.
///
/// - `empty`: Indicates that the field is empty.
/// - `format`: Indicates that the value is not a valid integer format.
enum IntegerFormzError { empty, format }

/// A custom Formz validator for integer-formatted strings.
///
/// This validator extends `FormzInput` to handle validation logic for input
/// that is expected to be an integer (a whole number). It checks for both an
/// empty value and an invalid numerical format.
class IntegerFormzValidator extends FormzInput<String, IntegerFormzError> {
  /// A regular expression to validate a string as an integer.
  ///
  /// The regex matches one or more digits from 0-9 (`[0-9]+`).
  static final RegExp idRegExp = RegExp(
    r'^[0-9]+$',
  );

  /// Creates a pure (initial) instance of the validator.
  ///
  /// This constructor is used to represent the initial state of the form
  /// input before any user interaction.
  const IntegerFormzValidator.pure() : super.pure('');

  /// Creates a dirty (modified) instance of the validator.
  ///
  /// This constructor is used after the user has interacted with the input
  /// field.
  const IntegerFormzValidator.dirty(super.value) : super.dirty();

  /// A computed property that returns a user-friendly error message.
  ///
  /// It checks the `displayError` property to determine which error message
  /// to show to the user.
  String? get errorMessage {
    // If the input is valid or hasn't been touched, there's no error message to display.
    if (isValid || isPure) return null;

    // Return specific error messages for each validation error type.
    if (displayError == IntegerFormzError.empty) return 'El campo es requerido';
    if (displayError == IntegerFormzError.format) return 'Debe contener solo números';

    return null;
  }

  /// The main validation method that checks the input value.
  ///
  /// It returns an `IntegerFormzError` if the value is invalid, and `null`
  /// if the value is valid. This method is called automatically by Formz
  /// whenever the input value changes.
  @override
  IntegerFormzError? validator(String value) {
    // Check for an empty value (after trimming whitespace).
    if (value.isEmpty || value.trim().isEmpty) return IntegerFormzError.empty;

    // Check if the value matches the integer number format.
    if (!idRegExp.hasMatch(value)) return IntegerFormzError.format;

    // Return `null` if the value is valid.
    return null;
  }
}

