import 'package:eat/src/auth/bloc/auth_bloc.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  static const path = '/account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Welcome ${context.read<AuthBloc>().state.myUser!.mobileNumber}!'),
            FilledButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.go(Splash.path);
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
