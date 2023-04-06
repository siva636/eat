part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStateChanged extends AuthEvent {
  const AuthStateChanged._(this.authenticationStatus, [this.myUser]);
  const AuthStateChanged.unauthenticated()
      : this._(AuthenticationStatus.unauthenticated);
  const AuthStateChanged.authenticated(MyUser this.myUser)
      : authenticationStatus = AuthenticationStatus.authenticated;

  final AuthenticationStatus authenticationStatus;
  final MyUser? myUser;
}

class SignOut extends AuthEvent {}
