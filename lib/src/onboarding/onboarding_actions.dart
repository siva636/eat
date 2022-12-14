import 'package:eat/src/constants.dart';
import 'package:flutter/material.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
          onPressed: () {},
          child: const Text('Search'),
        ),
        const SizedBox(height: contentPadding),
        ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
          onPressed: () {},
          child: const Text('Sign in / Sign up'),
        ),
      ],
    );
  }
}
