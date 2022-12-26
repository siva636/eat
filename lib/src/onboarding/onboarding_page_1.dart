import 'package:eat/src/constants.dart';
import 'package:eat/src/onboarding/onboarding_actions.dart';
import 'package:eat/src/onboarding/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1(this.currentPage, {super.key});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/onboarding/onboarding_1.png'),
        const Spacer(),
        Text(
          onboardingSlogan1,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        const OnboardingActions(),
        PageIndicator(currentPage),
      ],
    ));
  }
}
