import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  static const path = '/about';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('About'),
      ),
    );
  }
}
