import 'package:formz/formz.dart';

enum DoubleFormzError { empty, format }

class DoubleFormzValidator extends FormzInput<String, DoubleFormzError> {

  static final RegExp doubleRegExp = RegExp(
    r'^\d+(\.\d+)?$',
  );

  const DoubleFormzValidator.pure() : super.pure('');

  const DoubleFormzValidator.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DoubleFormzError.empty) return 'El campo es requerido';
    if (displayError == DoubleFormzError.format) return 'Debe contener un valor decimal';

    return null;
  }

  @override
  DoubleFormzError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DoubleFormzError.empty;
    if (!doubleRegExp.hasMatch(value)) return DoubleFormzError.format;

    return null;
  }
}