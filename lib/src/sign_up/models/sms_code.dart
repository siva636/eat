import 'package:formz/formz.dart';

enum SmsCodeInputError {
  empty('Value is required'),
  invalid('Enter a valid value');

  const SmsCodeInputError(this.message);
  final String message;
}

class SmsCodeInput extends FormzInput<String, SmsCodeInputError> {
  const SmsCodeInput.pure() : super.pure('');
  const SmsCodeInput.dirty(String value) : super.dirty(value);
  @override
  SmsCodeInputError? validator(String value) {
    if (value.isEmpty) {
      return SmsCodeInputError.empty;
    } else {
      if (value.length != 6) {
        return SmsCodeInputError.invalid;
      } else {
        return null;
      }
    }
  }
}
