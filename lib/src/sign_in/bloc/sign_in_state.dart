part of 'sign_in_bloc.dart';

@immutable
class SignInState {
  const SignInState({
    required this.viewStatus,
    required this.mobileNumberInput,
    required this.smsCodeInput,
    required this.smsCodeUi,
    required this.signedUp,
  });
  const SignInState.initial()
      : this(
          viewStatus: ViewStatus.initial,
          mobileNumberInput: const MobileNumberInput.pure(),
          smsCodeInput: const SmsCodeInput.pure(),
          smsCodeUi: false,
          signedUp: true,
        );

  final ViewStatus viewStatus;
  final MobileNumberInput mobileNumberInput;
  final SmsCodeInput smsCodeInput;
  final bool smsCodeUi;
  final bool signedUp;

  SignInState copyWith({
    ViewStatus? viewStatus,
    MobileNumberInput? mobileNumberInput,
    SmsCodeInput? smsCodeInput,
    bool? smsCodeUi,
    bool? signedUp,
  }) {
    return SignInState(
      viewStatus: viewStatus ?? this.viewStatus,
      mobileNumberInput: mobileNumberInput ?? this.mobileNumberInput,
      smsCodeInput: smsCodeInput ?? this.smsCodeInput,
      smsCodeUi: smsCodeUi ?? this.smsCodeUi,
      signedUp: signedUp ?? this.signedUp,
    );
  }
}
