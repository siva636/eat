import 'package:eat/src/constants.dart';
import 'package:eat/src/onboarding/onboarding_actions.dart';
import 'package:eat/src/onboarding/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2(this.currentPage, {super.key});
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/onboarding/onboarding_2.png'),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(contentPadding),
          child: Text(
            onboardingSlogan2,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        const OnboardingActions(),
        PageIndicator(currentPage),
      ],
    ));
  }
}
