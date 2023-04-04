import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eat/src/sign_up/models/models.dart';
import 'package:eat/src/sign_up/repository/repository.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:eat/src/utils/models/my_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this.signUpRepository) : super(const SignUpState.initial()) {
    on<LocationRequested>(_onLocationRequested);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<DietChanged>(_onDietChanged);
    on<SmsCodeChanged>(_onSmsCodeChanged);
    on<SaveLocationPreferenceChanged>(_onSaveLocationPreferenceChanged);
    on<SignUpFormInvalid>(_signUpFormInvalid);
    on<SmsCodeReceived>(_smsCodeReceived);
    on<SignUpInitiated>(_signUpInitiated);
    on<PersistUserRequested>(_persistUserRequested);
  }

  SignUpRepository signUpRepository;
  final auth = FirebaseAuth.instance;
  Completer<String> tillSmsCodeReceived = Completer<String>();
  Completer<bool> tillMobileNumberVerified = Completer<bool>();

  _onLocationRequested(event, emit) {
    MyLocation location = event.location;
    return emit(
      state.copyWith(
        location: location,
      ),
    );
  }

  _onMobileNumberChanged(event, emit) {
    String mobileNumber = event.mobileNumber;
    return emit(
      state.copyWith(
        mobileNumberInput: MobileNumberInput.dirty(mobileNumber),
      ),
    );
  }

  _onDietChanged(event, emit) {
    String diet = event.diet;
    return emit(
      state.copyWith(
        dietInput: DietInput.dirty(diet),
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

  _onSaveLocationPreferenceChanged(event, emit) {
    bool save = event.save;
    return emit(
      state.copyWith(
        saveLocationPreference: save,
      ),
    );
  }

  _signUpFormInvalid(event, emit) {
    return emit(
      state.copyWith(
        mobileNumberInput:
            MobileNumberInput.dirty(state.mobileNumberInput.value),
        dietInput: DietInput.dirty(state.dietInput.value),
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

  _signUpInitiated(event, emit) async {
    bool completed = false;
    final mobileNumber = event.mobileNumberInput.value;

    emit(state.copyWith(
      viewStatus: ViewStatus.inProgress,
    ));

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
    bool verified = await tillMobileNumberVerified.future;
    if (verified) {
      _persistUserRequested(event, emit);
    }
  }

  _persistUserRequested(event, emit) async {
    String? uid = auth.currentUser?.uid;
    if (uid == null) {
      return emit(state.copyWith(
        viewStatus: ViewStatus.failure,
      ));
    }

    try {
      Profile profile = Profile(
        mobileNumberInput: event.mobileNumberInput,
        dietInput: event.dietInput,
        location: event.location,
      );
      await signUpRepository.signUp(uid: uid, profile: profile);
      return emit(state.copyWith(
        viewStatus: ViewStatus.success,
      ));
    } catch (e) {
      return emit(state.copyWith(
        viewStatus: ViewStatus.failure,
      ));
    }
  }
}
