// 📦 Package imports:
import 'package:formz/formz.dart';

// Define input validation errors
enum NameError { empty }

// Extend FormzInput and provide the input type and error type.
class NameValidator extends FormzInput<String, NameError> {

  // Call super.pure to represent an unmodified form input.
  const NameValidator.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameValidator.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;

    return null;
  }
}