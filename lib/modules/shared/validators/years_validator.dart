// 📦 Package imports:
import 'package:formz/formz.dart';

// Define input validation errors
enum YearsError { empty, format }

// Extend FormzInput and provide the input type and error type.
class YearsValidator extends FormzInput<String, YearsError> {

  static final RegExp idRegExp = RegExp(
    r'^[0-9]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const YearsValidator.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const YearsValidator.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == YearsError.empty) return 'El campo es requerido';
    if (displayError == YearsError.format) return 'Debe contener solo números';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  YearsError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return YearsError.empty;
    if (!idRegExp.hasMatch(value)) return YearsError.format;

    return null;
  }
}

