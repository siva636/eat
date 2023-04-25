import 'package:eat/src/dashboard/view/dashboard.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: contentPadding),
        const SizedBox(height: contentPadding),
        FilledButton(
          style: FilledButton.styleFrom(),
          onPressed: () => context.go(Dashboard.path),
          child: const Text('Dashboard'),
        ),
        const SizedBox(height: contentPadding),
      ],
    );
  }
}
