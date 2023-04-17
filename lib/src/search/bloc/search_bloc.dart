import 'package:bloc/bloc.dart';
import 'package:eat/src/search/models/models.dart';
import 'package:eat/src/search/repository/search_repository.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchRepository) : super(SearchState.initial()) {
    on<SearchStarted>(_onSearchStarted);
    on<ProfileFetchStarted>(_onProfileFetchStarted);
    on<IsVegetarianChanged>(_onIsVegetarianChanged);
    on<SearchRangeChanged>(_onSearchRangeChanged);
  }

  final SearchRepository searchRepository;

  _onIsVegetarianChanged(event, emit) {
    final bool isVegetarian = event.isVegetarian;
    emit(
      state.copyWith(
        isVegetarian: isVegetarian,
      ),
    );
  }

  _onSearchRangeChanged(event, emit) {
    final double searchRange = event.searchRange;
    emit(
      state.copyWith(
        searchRange: searchRange,
      ),
    );
  }

  _onProfileFetchStarted(event, emit) async {
    final String uid = event.uid;
    emit(state.copyWith(
      viewStatus: ViewStatus.inProgress,
    ));
    try {
      final ProfileForSearch profile = await searchRepository.fetchProfile(uid);
      emit(state.copyWith(
        viewStatus: ViewStatus.success,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        viewStatus: ViewStatus.failure,
      ));
    }
  }

  _onSearchStarted(event, emit) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.inProgress,
        showSearchFiltersUi: false,
      ),
    );
    try {
      List<NearbyRestaurant> results =
          await searchRepository.getNearbyRestaurantsForTest();
      emit(state.copyWith(
        viewStatus: ViewStatus.success,
        searchResults: results,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failure,
        ),
      );
    }
  }
}
