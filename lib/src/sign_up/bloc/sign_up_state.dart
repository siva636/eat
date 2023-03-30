part of 'sign_up_bloc.dart';

@immutable
class SignUpState {
  const SignUpState({
    required this.viewState,
    required this.mobileNumberInput,
    required this.dietInput,
    required this.saveLocationPreference,
    required this.location,
    required this.signUpCompleted,
    required this.signUpFailed,
    required this.signUpInProgress,
  });
  const SignUpState.initial()
      : this(
          viewState: ViewState.idle,
          mobileNumberInput: const MobileNumberInput.pure(),
          dietInput: const DietInput.pure(),
          saveLocationPreference: true,
          location: const MyLocation.unknown(),
          signUpCompleted: false,
          signUpFailed: false,
          signUpInProgress: false,
        );

  final ViewState viewState;
  final MobileNumberInput mobileNumberInput;
  final DietInput dietInput;
  final bool saveLocationPreference;
  final MyLocation location;
  final bool signUpCompleted;
  final bool signUpInProgress;
  final bool signUpFailed;

  SignUpState copyWith({
    ViewState? viewState,
    MobileNumberInput? mobileNumberInput,
    DietInput? dietInput,
    bool? saveLocationPreference,
    MyLocation? location,
    bool? signUpCompleted,
    bool? signUpInProgress,
    bool? signUpFailed,
  }) {
    return SignUpState(
      viewState: viewState ?? this.viewState,
      mobileNumberInput: mobileNumberInput ?? this.mobileNumberInput,
      dietInput: dietInput ?? this.dietInput,
      saveLocationPreference:
          saveLocationPreference ?? this.saveLocationPreference,
      location: location ?? this.location,
      signUpCompleted: signUpCompleted ?? this.signUpCompleted,
      signUpInProgress: signUpInProgress ?? this.signUpInProgress,
      signUpFailed: signUpFailed ?? this.signUpFailed,
    );
  }
}
