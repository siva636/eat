part of 'dashboard_bloc.dart';

abstract class DashboardEvent {
  const DashboardEvent();
}

class DeletionConfirmed extends DashboardEvent {
  DeletionConfirmed(this.uid);
  String uid;
}
