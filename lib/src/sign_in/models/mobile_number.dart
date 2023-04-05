import 'package:formz/formz.dart';

enum MobileNumberInputError {
  empty('Value is required'),
  invalid('Enter a valid value');

  const MobileNumberInputError(this.message);
  final String message;
}

class MobileNumberInput extends FormzInput<String, MobileNumberInputError> {
  const MobileNumberInput.pure() : super.pure('');
  const MobileNumberInput.dirty(String value) : super.dirty(value);
  @override
  MobileNumberInputError? validator(String value) {
    if (value.isEmpty) {
      return MobileNumberInputError.empty;
    } else {
      // TODO: improve this validation logic, preferably with regexp
      if (!value.startsWith('+') || value.length < 8) {
        return MobileNumberInputError.invalid;
      } else {
        return null;
      }
    }
  }
}
