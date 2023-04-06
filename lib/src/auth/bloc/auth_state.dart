part of 'auth_bloc.dart';

@immutable
class AuthState {
  const AuthState._(this.authenticationStatus, [this.myUser]);
  const AuthState.initial() : this._(AuthenticationStatus.unknown);
  const AuthState.unknown() : this._(AuthenticationStatus.unknown);
  const AuthState.unauthenticated()
      : this._(AuthenticationStatus.unauthenticated);
  const AuthState.authenticated(this.myUser)
      : authenticationStatus = AuthenticationStatus.authenticated;

  final AuthenticationStatus authenticationStatus;
  final MyUser? myUser;
}
