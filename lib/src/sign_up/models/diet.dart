import 'package:formz/formz.dart';

enum DietInputError {
  empty('Select a value');

  const DietInputError(this.message);
  final String message;
}

class DietInput extends FormzInput<String, DietInputError> {
  const DietInput.pure() : super.pure('');
  const DietInput.dirty(value) : super.dirty(value);

  @override
  DietInputError? validator(String value) {
    return value.isEmpty ? DietInputError.empty : null;
  }
}
