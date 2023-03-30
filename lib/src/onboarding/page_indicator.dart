import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator(
    this.currentPage, {
    super.key,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    List<Widget> indicators = [];
    for (int i = 1; i <= 3; i++) {
      indicators.add(
        AnimatedContainer(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          duration: const Duration(milliseconds: 500),
          width: currentPage == i ? 24 : 16,
          height: 8,
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: currentPage == i
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).disabledColor,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}
