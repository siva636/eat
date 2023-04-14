import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:eat/src/search/bloc/search_bloc.dart';
import 'package:eat/src/search/repository/search_repository.dart';
import 'package:eat/src/search/view/search_screen.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  static const path = '/search';

  @override
  Widget build(BuildContext context) {
    double gutter = getBreakpointEntry(context).gutter;
    return BlocProvider(
      create: (context) => SearchBloc(SearchRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(brand),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(gutter),
            child: const SearchScreen(),
          ),
        ),
      ),
    );
  }
}
