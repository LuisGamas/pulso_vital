// 📦 Package imports:
import 'package:formz/formz.dart';

/// An enumeration of possible validation errors for a text field.
///
/// - `empty`: Indicates that the field is empty.
/// - `format`: Indicates that the value does not match the expected format.
enum TextFormzError { empty, format }

/// A custom Formz validator for text input, typically used for names.
///
/// This validator extends `FormzInput` to handle the validation logic for
/// strings. It checks for two common validation rules: ensuring the field is
/// not empty and that it contains a valid format (in this case, only letters
/// and spaces).
class TextFormzValidator extends FormzInput<String, TextFormzError> {
  /// A regular expression to validate a string as a name.
  ///
  /// The regex matches one or more letters (both lowercase and uppercase)
  /// and spaces (`[a-zA-Z\s]+`). This ensures that the input does not
  /// contain numbers, special characters, or symbols.
  static final RegExp nameRegExp = RegExp(
    r'^[a-zA-Z\s]+$',
  );

  /// Creates a pure (initial) instance of the validator.
  ///
  /// This constructor is used to represent the initial state of the form
  /// input before any user interaction.
  const TextFormzValidator.pure() : super.pure('');

  /// Creates a dirty (modified) instance of the validator.
  ///
  /// This constructor is used after the user has interacted with the input
  /// field.
  const TextFormzValidator.dirty(super.value) : super.dirty();

  /// A computed property that returns a user-friendly error message.
  ///
  /// It checks the `displayError` property to determine which error message
  /// to show to the user.
  String? get errorMessage {
    // If the input is valid or hasn't been touched, there's no error message.
    if (isValid || isPure) return null;

    // Return specific error messages for each validation error type.
    if (displayError == TextFormzError.empty) return 'El campo es requerido';
    if (displayError == TextFormzError.format) return 'Por favor ingresa un nombre válido';

    return null;
  }

  /// The main validation method that checks the input value.
  ///
  /// It returns a `TextFormzError` if the value is invalid, and `null` if the
  /// value is valid. This method is called automatically by Formz.
  @override
  TextFormzError? validator(String value) {
    // Check for an empty value after trimming whitespace.
    if (value.isEmpty || value.trim().isEmpty) return TextFormzError.empty;

    // Check if the value matches the name format.
    if (!nameRegExp.hasMatch(value)) return TextFormzError.format;

    // Return `null` if the value is valid.
    return null;
  }
}