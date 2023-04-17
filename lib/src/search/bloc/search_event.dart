part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class ProfileFetchStarted extends SearchEvent {
  ProfileFetchStarted(this.uid);
  final String uid;
}

class SearchStarted extends SearchEvent {}

class IsVegetarianChanged extends SearchEvent {
  IsVegetarianChanged(this.isVegetarian);
  final bool isVegetarian;
}

class SearchRangeChanged extends SearchEvent {
  SearchRangeChanged(this.searchRange);
  final double searchRange;
}
