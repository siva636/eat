import 'package:eat/src/account/account.dart';
import 'package:eat/src/constants.dart';
import 'package:eat/src/search/Search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: contentPadding),
        FilledButton(
          style: FilledButton.styleFrom(
            fixedSize: const Size(200, 50),
          ),
          onPressed: () => context.go(Search.path),
          child: const Text('Search'),
        ),
        const SizedBox(height: contentPadding),
        FilledButton(
          style: FilledButton.styleFrom(
            fixedSize: const Size(200, 50),
          ),
          onPressed: () => context.go(Account.path),
          child: const Text('Account'),
        ),
        const SizedBox(height: contentPadding),
      ],
    );
  }
}
