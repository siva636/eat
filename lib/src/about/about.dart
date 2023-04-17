import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  static const path = '/about';

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;
    return Scaffold(
      appBar: AppBar(
        title: Text(brand),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.all(gutter),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('This app helps to find nearby restaurants.'),
                Text(
                    'You first sign up providing your current location and then able to view restaurants within a configurable distance.'),
                Text('You also can bookmark your favorite restaurants.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
