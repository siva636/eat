part of 'search_bloc.dart';

@immutable
class SearchState {
  const SearchState._({
    required this.viewStatus,
    required this.searchResults,
    // required this.searchFiltersUi,
    // required this.dietInput,
    // required this.searchRangeInput,
    // required this.profile,
  });

  SearchState.initial()
      : this._(
          viewStatus: ViewStatus.initial,
          searchResults: [],
          // searchFiltersUi: true,
          // dietInput: DietInput.pure(),
          // searchRangeInput: SearchRangeInput(),
          // profile: Profile(),
        );

  final ViewStatus viewStatus;
  final dynamic searchResults;
  // final bool searchFiltersUi;
  // final FormzInput dietInput;
  // final double searchRangeInput;
  // final dynamic profile;

  SearchState copyWith({
    ViewStatus? viewStatus,
    dynamic searchResults,
    // bool? searchFiltersUi,
    // FormzInput? dietInput,
    // double? searchRangeInput,
    // dynamic profile,
  }) {
    return SearchState._(
      viewStatus: viewStatus ?? this.viewStatus,
      searchResults: searchResults ?? this.searchResults,
      // searchFiltersUi: searchFiltersUi ?? this.searchFiltersUi,
      // dietInput: dietInput ?? this.dietInput,
      // searchRangeInput: searchRangeInput ?? this.searchRangeInput,
      // profile: profile ?? this.profile,
    );
  }
}
