import 'package:bloc/bloc.dart';
import 'package:eat/src/sign_up/models/models.dart';
import 'package:eat/src/sign_up/repository/repository.dart';
import 'package:eat/src/utils/enums/view_state.dart';
import 'package:eat/src/utils/models/my_location.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this.signUpRepository) : super(const SignUpState.initial()) {
    on<LocationRequested>(_onLocationRequested);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<DietChanged>(_onDietChanged);
    on<SaveLocationPreferenceChanged>(_onSaveLocationPreferenceChanged);
    on<SignUpFormInvalid>(_signUpFormInvalid);
    on<SignUpFormSubmitted>(_signUpFormSubmitted);
  }

  SignUpRepository signUpRepository;

  Function _onLocationRequested(event, emit) {
    MyLocation location = event.location;
    return emit(
      state.copyWith(
        location: location,
      ),
    );
  }

  Function _onMobileNumberChanged(event, emit) {
    String mobileNumber = event.mobileNumber;
    return emit(
      state.copyWith(
        mobileNumberInput: MobileNumberInput.dirty(mobileNumber),
      ),
    );
  }

  Function _onDietChanged(event, emit) {
    String diet = event.diet;
    return emit(
      state.copyWith(
        dietInput: DietInput.dirty(diet),
      ),
    );
  }

  Function _onSaveLocationPreferenceChanged(event, emit) {
    bool save = event.save;
    return emit(
      state.copyWith(
        saveLocationPreference: save,
      ),
    );
  }

  Function _signUpFormInvalid(event, emit) {
    return emit(
      state.copyWith(
        mobileNumberInput:
            MobileNumberInput.dirty(state.mobileNumberInput.value),
        dietInput: DietInput.dirty(state.dietInput.value),
      ),
    );
  }

  _signUpFormSubmitted(event, emit) async {
    emit(state.copyWith(
      signUpInProgress: true,
    ));

    try {
      Profile profile = Profile(
        mobileNumberInput: event.mobileNumberInput,
        dietInput: event.dietInput,
        location: event.location,
      );
      await signUpRepository.signUp(profile);
      return emit(state.copyWith(
        signUpCompleted: true,
        signUpInProgress: false,
      ));
    } catch (e) {
      return emit(state.copyWith(
        signUpFailed: true,
        signUpInProgress: false,
      ));
    }
  }
}
