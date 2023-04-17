part of 'search_bloc.dart';

@immutable
class SearchState {
  const SearchState._({
    required this.viewStatus,
    required this.profile,
    required this.searchResults,
    required this.showSearchFiltersUi,
    required this.isVegetarian,
    required this.searchRange,
  });

  SearchState.initial()
      : this._(
          viewStatus: ViewStatus.initial,
          searchResults: [],
          showSearchFiltersUi: true,
          isVegetarian: false,
          searchRange: .5,
          profile: null,
        );

  final ViewStatus viewStatus;
  final ProfileForSearch? profile;
  final List<NearbyRestaurant> searchResults;
  final bool showSearchFiltersUi;
  final bool isVegetarian;
  final double searchRange;

  SearchState copyWith({
    ViewStatus? viewStatus,
    ProfileForSearch? profile,
    List<NearbyRestaurant>? searchResults,
    bool? showSearchFiltersUi,
    bool? isVegetarian,
    double? searchRange,
  }) {
    return SearchState._(
      viewStatus: viewStatus ?? this.viewStatus,
      profile: profile ?? this.profile,
      searchResults: searchResults ?? this.searchResults,
      showSearchFiltersUi: showSearchFiltersUi ?? this.showSearchFiltersUi,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      searchRange: searchRange ?? this.searchRange,
    );
  }
}
