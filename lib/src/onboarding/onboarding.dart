import 'package:eat/src/onboarding/onboarding_page_1.dart';
import 'package:eat/src/onboarding/onboarding_page_2.dart';
import 'package:eat/src/onboarding/onboarding_page_3.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late int currentPage;
  late PageController pageController;
  late List<Widget> onboardingPages;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    onboardingPages = [
      OnboardingPage1(currentPage),
      OnboardingPage2(currentPage),
      OnboardingPage3(currentPage),
    ];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: PageView(
            onPageChanged: (value) => setState(() {
              currentPage = value + 1;
            }),
            controller: pageController,
            children: onboardingPages,
          ),
        ),
      ),
    );
  }
}
