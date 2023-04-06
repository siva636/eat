import 'package:bloc/bloc.dart';
import 'package:eat/src/auth/models/models.dart';
import 'package:eat/src/auth/repository/auth_repository.dart';
import 'package:eat/src/utils/enums/authentication_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(const AuthState.initial()) {
    on<AuthStateChanged>(_onAuthStateChanged);
    on<SignOut>(_onSignOut);

    authRepository.authStateChanges().listen((MyUser? myUser) async {
      if (myUser != null) {
        add(AuthStateChanged.authenticated(myUser));
      } else {
        add(const AuthStateChanged.unauthenticated());
      }
    });
  }
  final AuthRepository authRepository;

  _onAuthStateChanged(event, emit) {
    final myUser = event.myUser;
    if (myUser != null) {
      emit(AuthState.authenticated(myUser));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  _onSignOut(event, emit) {
    authRepository.signOut();
    emit(const AuthState.unauthenticated());
  }
}
