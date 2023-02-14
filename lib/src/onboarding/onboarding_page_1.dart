import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

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
                  Image.asset('assets/images/onboarding/onboarding_1.png'),
                  Padding(
                    padding: const EdgeInsets.all(contentPadding),
                    child: Text(
                      onboardingSlogan1,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
