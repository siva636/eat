import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/auth/bloc/auth_bloc.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:eat/src/search/view/search.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  static const path = '/dashboard';

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;
    return Scaffold(
      appBar: AppBar(
        title: Text(brand),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(gutter),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Welcome ${context.read<AuthBloc>().state.myUser!.mobileNumber}!'),
                const SizedBox(height: verticalGap),
                Column(
                  children: [
                    FilledButton(
                      onPressed: () {
                        context.go(SearchPage.path);
                      },
                      child: const Text('Restaurants'),
                    ),
                    const SizedBox(height: verticalGap),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Delete'),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            context.go(Splash.path);
                          },
                          child: const Text('Sign out'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
