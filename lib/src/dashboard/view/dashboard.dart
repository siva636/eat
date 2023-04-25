import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/dashboard/bloc/bloc.dart';
import 'package:eat/src/dashboard/repository/repository.dart';
import 'package:eat/src/dashboard/view/dashboard_content.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  static const path = '/dashboard';

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;
    return BlocProvider(
      create: (context) => DashboardBloc(DashboardRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(brand),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(gutter),
            child: const DashboardContent(),
          ),
        ),
      ),
    );
  }
}
