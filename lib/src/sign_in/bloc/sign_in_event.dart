part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class MobileNumberChanged extends SignInEvent {
  MobileNumberChanged(this.mobileNumber);
  final String mobileNumber;
}

class MobileNumberInvalid extends SignInEvent {
  MobileNumberInvalid();
}

class SmsCodeChanged extends SignInEvent {
  SmsCodeChanged(this.smsCode);
  final String smsCode;
}

class SmsCodeInvalid extends SignInEvent {
  SmsCodeInvalid();
}

class SmsCodeReceived extends SignInEvent {
  SmsCodeReceived(this.smsCode);
  final String smsCode;
}

class SignIn extends SignInEvent {
  SignIn(this.mobileNumberInput);
  final MobileNumberInput mobileNumberInput;
}
