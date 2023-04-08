import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/sign_up/repository/sign_up_repository.dart';
import 'package:eat/src/sign_up/sign_up.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static const path = '/sign_up';

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;
    return BlocProvider(
      create: (context) => SignUpBloc(SignUpRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(brand),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(gutter),
            child: const SignUpForm(),
          ),
        ),
      ),
    );
  }
}
