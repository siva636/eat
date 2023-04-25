part of 'dashboard_bloc.dart';

class DashboardState {
  DashboardState(this.viewStatus);

  DashboardState.initial() : this(ViewStatus.initial);

  ViewStatus viewStatus;
}
