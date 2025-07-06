import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/admin/dashboard/data/repository/dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository repository;

  DashboardCubit(this.repository) : super(const DashboardState.initial());

  Future<void> fetchDashboard() async {
    emit(const DashboardState.loading());

    await repository.fetchDashboardData().then((data) {
      data.when(
        success: (data) => emit(DashboardState.loaded(data)),
        failure: (e) => emit(DashboardState.error(e.toString())),
      );
    });
  }
}
