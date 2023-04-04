part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class LocationRequested extends SignUpEvent {
  LocationRequested(this.location);
  final MyLocation location;
}

class MobileNumberChanged extends SignUpEvent {
  MobileNumberChanged(this.mobileNumber);
  final String mobileNumber;
}

class DietChanged extends SignUpEvent {
  DietChanged(this.diet);
  final String diet;
}

class SmsCodeChanged extends SignUpEvent {
  SmsCodeChanged(this.smsCode);
  final String smsCode;
}

class SaveLocationPreferenceChanged extends SignUpEvent {
  SaveLocationPreferenceChanged(this.save);
  final bool save;
}

class SignUpFormInvalid extends SignUpEvent {}

class SmsCodeReceived extends SignUpEvent {
  SmsCodeReceived(this.smsCode);
  final String smsCode;
}

class SignUpInitiated extends SignUpEvent {
  SignUpInitiated({
    required this.mobileNumberInput,
    required this.dietInput,
    required this.location,
  });

  final MobileNumberInput mobileNumberInput;
  final DietInput dietInput;
  final MyLocation location;
}

class PersistUserRequested extends SignUpEvent {
  PersistUserRequested({
    required this.uid,
    required this.mobileNumberInput,
    required this.dietInput,
    required this.location,
  });

  final String uid;
  final MobileNumberInput mobileNumberInput;
  final DietInput dietInput;
  final MyLocation location;
}

class SignUp extends SignUpEvent {}
