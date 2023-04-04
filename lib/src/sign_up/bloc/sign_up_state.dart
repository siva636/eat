part of 'sign_up_bloc.dart';

@immutable
class SignUpState {
  const SignUpState({
    required this.viewStatus,
    required this.mobileNumberInput,
    required this.dietInput,
    required this.saveLocationPreference,
    required this.location,
    required this.smsCodeInput,
    required this.smsCodeUi,
  });
  const SignUpState.initial()
      : this(
          viewStatus: ViewStatus.initial,
          mobileNumberInput: const MobileNumberInput.pure(),
          dietInput: const DietInput.pure(),
          saveLocationPreference: true,
          location: const MyLocation.unknown(),
          smsCodeInput: const SmsCodeInput.pure(),
          smsCodeUi: false,
        );

  // system status
  final ViewStatus viewStatus;
  // user input related
  final MobileNumberInput mobileNumberInput;
  final DietInput dietInput;
  final bool saveLocationPreference;
  final MyLocation location;
  // sms code related
  final SmsCodeInput smsCodeInput;
  final bool smsCodeUi;

  SignUpState copyWith({
    ViewStatus? viewStatus,
    MobileNumberInput? mobileNumberInput,
    DietInput? dietInput,
    bool? saveLocationPreference,
    MyLocation? location,
    SmsCodeInput? smsCodeInput,
    bool? smsCodeUi,
  }) {
    return SignUpState(
      viewStatus: viewStatus ?? this.viewStatus,
      mobileNumberInput: mobileNumberInput ?? this.mobileNumberInput,
      dietInput: dietInput ?? this.dietInput,
      saveLocationPreference:
          saveLocationPreference ?? this.saveLocationPreference,
      location: location ?? this.location,
      smsCodeInput: smsCodeInput ?? this.smsCodeInput,
      smsCodeUi: smsCodeUi ?? this.smsCodeUi,
    );
  }
}
