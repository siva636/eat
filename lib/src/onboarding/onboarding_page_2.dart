import 'package:eat/src/constants.dart';
import 'package:eat/src/onboarding/onboarding_actions.dart';
import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

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
                  Image.asset('assets/images/onboarding/onboarding_2.png'),
                  Padding(
                    padding: const EdgeInsets.all(contentPadding),
                    child: Text(
                      onboardingSlogan2,
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const OnboardingActions(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
