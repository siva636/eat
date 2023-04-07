import 'package:eat/src/sign_in/sign_in.dart';
import 'package:eat/src/sign_up/view/sign_up_page.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        if (!state.signedUp) {
          return const Center(child: Text('Not signed up yet'));
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
                      context.read<SignInBloc>().add(SmsCodeChanged(value));
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
                    if (Formz.validate([state.smsCodeInput])) {
                      context
                          .read<SignInBloc>()
                          .add(SmsCodeReceived(state.smsCodeInput.value));
                    } else {
                      context.read<SignInBloc>().add(SmsCodeInvalid());
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
          return const Center(child: Text('Sign in completed'));
        }
        if (state.viewStatus == ViewStatus.failure) {
          return const Center(child: Text('Sign in failed'));
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign in',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: verticalGap),
              TextFormField(
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    context.read<SignInBloc>().add(MobileNumberChanged(value));
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
              FilledButton(
                onPressed: () {
                  if (Formz.validate([state.mobileNumberInput])) {
                    context
                        .read<SignInBloc>()
                        .add(SignIn(state.mobileNumberInput));
                  } else {
                    context.read<SignInBloc>().add(MobileNumberInvalid());
                  }
                },
                child: const Text('Sign in'),
              ),
              const SizedBox(height: verticalGap),
              const Divider(),
              OutlinedButton(
                  onPressed: () {
                    context.go(SignUpPage.path);
                  },
                  child: const Text('Sign up'))
            ],
          ),
        );
      },
    );
  }
}
