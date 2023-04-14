import 'package:bloc/bloc.dart';
import 'package:eat/src/search/models/nearby_restaurant.dart';
import 'package:eat/src/search/repository/search_repository.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchRepository) : super(SearchState.initial()) {
    on<SearchStarted>(_onSearchStarted);
  }

  final SearchRepository searchRepository;

  _onSearchStarted(event, emit) async {
    emit(
      state.copyWith(
        viewStatus: ViewStatus.inProgress,
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
