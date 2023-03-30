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

class SaveLocationPreferenceChanged extends SignUpEvent {
  SaveLocationPreferenceChanged(this.save);
  final bool save;
}

class SignUpFormInvalid extends SignUpEvent {}

class SignUpFormSubmitted extends SignUpEvent {
  SignUpFormSubmitted({
    required this.mobileNumberInput,
    required this.dietInput,
    required this.location,
  });

  final MobileNumberInput mobileNumberInput;
  final DietInput dietInput;
  final MyLocation location;
}

class SignUp extends SignUpEvent {}
