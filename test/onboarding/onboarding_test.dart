import 'package:eat/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Onboarding', () {
    testWidgets('should find greeting', (WidgetTester tester) async {
      const String greeting = 'Hello world!';
      await tester.pumpWidget(const MyApp());
      expect(
        find.text(greeting),
        findsOneWidget,
      );
      expect(
        find.byType(Center),
        findsOneWidget,
      );
      expect(
        find.byType(Text),
        findsOneWidget,
      );
    });
  });
}
