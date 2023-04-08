import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/sign_in/bloc/bloc.dart';
import 'package:eat/src/sign_in/repository/sign_in_repository.dart';
import 'package:eat/src/sign_in/view/view.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static const path = '/sign_in';

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;
    return BlocProvider(
      create: (context) => SignInBloc(SignInRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(brand),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(gutter),
            child: const SignInForm(),
          ),
        ),
      ),
    );
  }
}
