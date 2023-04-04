import 'package:eat/src/sign_up/sign_up.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:eat/src/utils/enums/diet.dart';
import 'package:eat/src/utils/enums/location_data.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:eat/src/utils/models/my_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    super.initState();
    requestLocation();
  }

  requestLocation() async {
    late MyLocation location;
    try {
      Position position = await _determinePosition();
      location = MyLocation.allowed({
        LocationData.latitude: position.latitude,
        LocationData.longitude: position.longitude,
      });
      if (mounted) {
        context.read<SignUpBloc>().add(LocationRequested(location));
      }
    } catch (x) {
      location = MyLocation.denied(x.toString());
      if (mounted) {
        context.read<SignUpBloc>().add(LocationRequested(location));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state.location.isUnknown) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.location.isDenied) {
          return Center(
            child: Text(
              state.location.error!,
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state.smsCodeUi) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sms code',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: verticalGap),
                TextFormField(
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      context.read<SignUpBloc>().add(SmsCodeChanged(value));
                    }
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Sms code',
                    errorText: state.smsCodeInput.isNotValid
                        ? state.smsCodeInput.displayError?.message
                        : null,
                  ),
                ),
                const SizedBox(height: verticalGap),
                FilledButton(
                  onPressed: () {
                    if (Formz.validate([
                      state.smsCodeInput,
                    ])) {
                      context
                          .read<SignUpBloc>()
                          .add(SmsCodeReceived(state.smsCodeInput.value));
                    }
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          );
        }

        if (state.viewStatus == ViewStatus.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.viewStatus == ViewStatus.success) {
          return const Center(child: Text('Sign up completed'));
        }
        if (state.viewStatus == ViewStatus.failure) {
          return const Center(child: Text('Sign up failed'));
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign up',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: verticalGap),
              TextFormField(
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    context.read<SignUpBloc>().add(MobileNumberChanged(value));
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Mobile number',
                  hintText: '+16505551234',
                  errorText: state.mobileNumberInput.isNotValid
                      ? state.mobileNumberInput.displayError?.message
                      : null,
                ),
              ),
              const SizedBox(height: verticalGap),
              DropdownButtonFormField<String>(
                onChanged: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    context.read<SignUpBloc>().add(DietChanged(value));
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Diet',
                  errorText: state.dietInput.isNotValid
                      ? state.dietInput.displayError?.message
                      : null,
                ),
                items: [
                  DropdownMenuItem(
                    value: Diet.nonvegetarian.value,
                    child: Text(Diet.nonvegetarian.description),
                  ),
                  DropdownMenuItem(
                    value: Diet.vegetarian.value,
                    child: Text(Diet.vegetarian.description),
                  ),
                ],
              ),
              const SizedBox(height: verticalGap),
              SwitchListTile(
                title: const Text('Save location'),
                secondary: state.saveLocationPreference
                    ? null
                    : Icon(Icons.warning,
                        color: Theme.of(context).colorScheme.error),
                value: state.saveLocationPreference,
                shape: const OutlineInputBorder(),
                onChanged: (value) {
                  context
                      .read<SignUpBloc>()
                      .add(SaveLocationPreferenceChanged(value));
                },
              ),
              const SizedBox(height: verticalGap),
              FilledButton(
                onPressed: () {
                  if (!state.saveLocationPreference) {
                    return;
                  }
                  if (!Formz.validate([
                    state.mobileNumberInput,
                    state.dietInput,
                  ])) {
                    return context.read<SignUpBloc>().add(SignUpFormInvalid());
                  }

                  context.read<SignUpBloc>().add(SignUpInitiated(
                        mobileNumberInput: state.mobileNumberInput,
                        dietInput: state.dietInput,
                        location: state.location,
                      ));
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        );
      },
    );
  }

// location related
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
