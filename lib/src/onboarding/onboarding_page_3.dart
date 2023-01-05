import 'package:eat/src/constants.dart';
import 'package:eat/src/onboarding/onboarding_actions.dart';
import 'package:eat/src/onboarding/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3(this.currentPage, {super.key});
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/onboarding/onboarding_3.png'),
                  Padding(
                    padding: const EdgeInsets.all(contentPadding),
                    child: Text(
                      onboardingSlogan3,
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const OnboardingActions(),
                  PageIndicator(currentPage),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
