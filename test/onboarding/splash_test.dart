import 'package:eat/src/constants.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Onboarding flow',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Splash()));
      expect(
        find.text(brand),
        findsOneWidget,
        reason: 'Splash screen should contain the brand name',
      );
      await tester.pumpAndSettle();
      expect(
        find.text(brand),
        findsNothing,
        reason: 'Onboarding screen 1 does not contain the brand name',
      );
      expect(
        find.text(onboardingSlogan1),
        findsOneWidget,
        reason:
            'Onboarding screen 1 should be loaded after splash screen animation',
      );
      await tester.drag(
        find.text(onboardingSlogan1),
        dragLeft,
      );
      await tester.pumpAndSettle();
      expect(
        find.text(onboardingSlogan2),
        findsOneWidget,
        reason:
            'If onboarding screen 1 is dragged left, onboarding screen 2 should be loaded',
      );
      await tester.drag(
        find.text(onboardingSlogan2),
        dragLeft,
      );
      await tester.pumpAndSettle();
      expect(
        find.text(onboardingSlogan3),
        findsOneWidget,
        reason:
            'If onboarding screen 2 is dragged left, onboarding screen 3 should be loaded',
      );
    },
  );
}
