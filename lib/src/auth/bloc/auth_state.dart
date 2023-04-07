part of 'auth_bloc.dart';

@immutable
class AuthState {
  const AuthState._({
    required this.viewStatus,
    required this.authenticationStatus,
    this.myUser,
  });
  const AuthState.initial()
      : this._(
          viewStatus: ViewStatus.initial,
          authenticationStatus: AuthenticationStatus.unknown,
        );
  const AuthState.error()
      : this._(
          viewStatus: ViewStatus.failure,
          authenticationStatus: AuthenticationStatus.unknown,
        );

  const AuthState.unauthenticated()
      : this._(
          viewStatus: ViewStatus.initial,
          authenticationStatus: AuthenticationStatus.unauthenticated,
        );
  const AuthState.authenticated(this.myUser)
      : viewStatus = ViewStatus.initial,
        authenticationStatus = AuthenticationStatus.authenticated;

  final ViewStatus viewStatus;
  final AuthenticationStatus authenticationStatus;
  final MyUser? myUser;
}
