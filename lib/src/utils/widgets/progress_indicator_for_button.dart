import 'package:flutter/material.dart';

class ProgressIndicatorForButton extends StatelessWidget {
  const ProgressIndicatorForButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 8),
      child: SizedBox(
        height: 28,
        width: 28,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
