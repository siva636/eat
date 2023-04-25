import 'package:bloc/bloc.dart';
import 'package:eat/src/dashboard/repository/repository.dart';
import 'package:eat/src/utils/enums/view_status.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this.dashboardRepository) : super(DashboardState.initial()) {
    on<DeletionConfirmed>((event, emit) async {
      await _onDeletionConfirmed(event, emit);
    });
  }

  final DashboardRepository dashboardRepository;

  _onDeletionConfirmed(event, emit) async {
    String uid = event.uid;
    emit(DashboardState(ViewStatus.inProgress));

    try {
      await dashboardRepository.deleteProfile(uid);
      emit(DashboardState(ViewStatus.success));
      return Future.value();
    } catch (e) {
      emit(DashboardState(ViewStatus.failure));
      return Future.value();
    }
  }
}
