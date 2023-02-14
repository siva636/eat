import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/account/account.dart';
import 'package:eat/src/auth/sms_code_input.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:eat/src/utils/enums/view_state.dart';
import 'package:eat/src/utils/widgets/progress_indicator_for_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthByPhone extends StatefulWidget {
  const AuthByPhone({super.key});

  static const path = '/auth';

  @override
  State<AuthByPhone> createState() => _AuthByPhoneState();
}

class _AuthByPhoneState extends State<AuthByPhone> {
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormFieldState> _phoneFieldKey = GlobalKey<FormFieldState>();
  final TextEditingController _textEditingController = TextEditingController();
  final MaterialStatesController _materialStatesController =
      MaterialStatesController();
  ViewState viewState = ViewState.idle;

  @override
  void dispose() {
    _textEditingController.dispose();
    _materialStatesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(gutter),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in with phone',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: verticalGap),
                TextFormField(
                  key: _phoneFieldKey,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '+16505551111',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (String? value) {
                    // TODO: This validation must be improved with a RegExp
                    if (value == null || value.isEmpty) {
                      return 'Enter a value';
                    }
                    if (!value.startsWith('+')) {
                      return 'Enter a correct value, ex: +16505551234';
                    }
                  },
                ),
                const SizedBox(height: verticalGap),
                FilledButton(
                  statesController: _materialStatesController,
                  onPressed: () async {
                    if (_phoneFieldKey.currentState!.validate()) {
                      setState(() {
                        viewState = ViewState.busy;
                      });
                      _materialStatesController.update(
                          MaterialState.disabled, true);

                      await auth.verifyPhoneNumber(
                        phoneNumber: _textEditingController.text,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          setState(() {
                            viewState = ViewState.idle;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign in success'),
                            ),
                          );
                          context.go(Account.path);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          setState(() {
                            viewState = ViewState.idle;
                          });
                          _materialStatesController.update(
                              MaterialState.disabled, false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign in failed'),
                            ),
                          );
                          context.go(Account.path);
                        },
                        codeSent:
                            (String verificationId, int? resendToken) async {
                          String? smsCode = await showDialog(
                            context: context,
                            builder: (context) => const Dialog.fullscreen(
                              child: SmsCodeInput(),
                            ),
                          );

                          if (smsCode == null || smsCode.isEmpty) {
                            setState(() {
                              viewState = ViewState.error;
                            });
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sign in failed'),
                                ),
                              );

                              context.go(Splash.path);
                            }
                            return;
                          }
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationId,
                                  smsCode: smsCode);

                          await auth.signInWithCredential(credential);
                          setState(() {
                            viewState = ViewState.idle;
                          });
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sign in success'),
                              ),
                            );

                            context.go(Account.path);
                          }
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          setState(() {
                            viewState = ViewState.error;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sign in failed'),
                            ),
                          );
                          context.go(Splash.path);
                        },
                      );
                    }
                  },
                  child: viewState == ViewState.busy
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            ProgressIndicatorForButton(),
                            Text('Continue'),
                          ],
                        )
                      : const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
