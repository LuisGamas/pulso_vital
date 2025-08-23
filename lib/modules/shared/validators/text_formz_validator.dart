// 📦 Package imports:
import 'package:formz/formz.dart';

// Define input validation errors
enum TextFormzError { empty, format }

// Extend FormzInput and provide the input type and error type.
class TextFormzValidator extends FormzInput<String, TextFormzError> {

  static final RegExp nameRegExp = RegExp(
    r'^[a-zA-Z\s]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const TextFormzValidator.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TextFormzValidator.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TextFormzError.empty) return 'El campo es requerido';
    if (displayError == TextFormzError.format) return 'Por favor ingresa un nombre válido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TextFormzError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TextFormzError.empty;
    if (!nameRegExp.hasMatch(value)) return TextFormzError.format;

    return null;
  }
}