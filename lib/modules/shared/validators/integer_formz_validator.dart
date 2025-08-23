// 📦 Package imports:
import 'package:formz/formz.dart';

// Define input validation errors
enum IntegerFormzError { empty, format }

// Extend FormzInput and provide the input type and error type.
class IntegerFormzValidator extends FormzInput<String, IntegerFormzError> {

  static final RegExp idRegExp = RegExp(
    r'^[0-9]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const IntegerFormzValidator.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const IntegerFormzValidator.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == IntegerFormzError.empty) return 'El campo es requerido';
    if (displayError == IntegerFormzError.format) return 'Debe contener solo números';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  IntegerFormzError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return IntegerFormzError.empty;
    if (!idRegExp.hasMatch(value)) return IntegerFormzError.format;

    return null;
  }
}

