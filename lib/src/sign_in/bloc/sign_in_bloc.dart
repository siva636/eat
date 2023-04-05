import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eat/src/sign_in/repository/sign_in_repository.dart';
import 'package:eat/src/sign_up/models/models.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this.signInRepository) : super(const SignInState.initial()) {
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<MobileNumberInvalid>(_onMobileNumberInvalid);
    on<SmsCodeChanged>(_onSmsCodeChanged);
    on<SmsCodeInvalid>(_onSmsCodeInvalid);
    on<SmsCodeReceived>(_smsCodeReceived);
    on<SignIn>(_signIn);
  }

  final SignInRepository signInRepository;
  final auth = FirebaseAuth.instance;
  Completer<String> tillSmsCodeReceived = Completer<String>();
  Completer<bool> tillMobileNumberVerified = Completer<bool>();

  _onMobileNumberChanged(event, emit) {
    String mobileNumber = event.mobileNumber;
    return emit(
      state.copyWith(
        mobileNumberInput: MobileNumberInput.dirty(mobileNumber),
      ),
    );
  }

  _onMobileNumberInvalid(event, emit) {
    return emit(
      state.copyWith(
        mobileNumberInput:
            MobileNumberInput.dirty(state.mobileNumberInput.value),
      ),
    );
  }

  _onSmsCodeInvalid(event, emit) {
    return emit(
      state.copyWith(
        smsCodeInput: SmsCodeInput.dirty(state.smsCodeInput.value),
      ),
    );
  }

  _onSmsCodeChanged(event, emit) {
    String smsCode = event.smsCode;
    return emit(
      state.copyWith(
        smsCodeInput: SmsCodeInput.dirty(smsCode),
      ),
    );
  }

  _smsCodeReceived(event, emit) {
    String smsCode = event.smsCode;
    emit(state.copyWith(
      smsCodeUi: false,
    ));
    tillSmsCodeReceived.complete(smsCode);
  }

  _signIn(event, emit) async {
    emit(state.copyWith(
      viewStatus: ViewStatus.inProgress,
    ));

    bool completed = false;
    final mobileNumber = event.mobileNumberInput.value;

    bool isSignedUp = await signInRepository.isSignedUp(mobileNumber);
    if (!isSignedUp) {
      return emit(state.copyWith(
        signedUp: false,
      ));
    }

    await auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        if (!completed) {
          completed = true;
          tillMobileNumberVerified.complete(true);
          emit(state.copyWith(
            viewStatus: ViewStatus.success,
          ));
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (!completed) {
          completed = true;
          tillMobileNumberVerified.complete(false);
          emit(state.copyWith(
            viewStatus: ViewStatus.failure,
          ));
        }
      },
      verificationFailed: (FirebaseAuthException e) async {
        if (!completed) {
          completed = true;
          tillMobileNumberVerified.complete(false);
          emit(state.copyWith(
            viewStatus: ViewStatus.failure,
          ));
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        emit(state.copyWith(
          smsCodeUi: true,
        ));
        String smsCode = await tillSmsCodeReceived.future;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

        await auth.signInWithCredential(credential);
        if (!completed) {
          completed = true;
          tillMobileNumberVerified.complete(true);
          emit(state.copyWith(
            viewStatus: ViewStatus.success,
          ));
        }
      },
    );
    await tillMobileNumberVerified.future;
  }
}
