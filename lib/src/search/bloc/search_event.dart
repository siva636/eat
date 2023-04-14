part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class ProfileFetchStarted extends SearchEvent {}

class SearchStarted extends SearchEvent {}

class DietInputChanged extends SearchEvent {}

class SearchRangeInputChanged extends SearchEvent {}
