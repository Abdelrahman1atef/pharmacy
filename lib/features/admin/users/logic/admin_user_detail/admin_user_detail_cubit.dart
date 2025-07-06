import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/models/admin_user/admin_user_detail_response.dart';
import 'package:pharmacy/features/admin/users/repository/admin_user_detail_repository.dart';

part 'admin_user_detail_state.dart';
part 'admin_user_detail_cubit.freezed.dart';

class AdminUserDetailCubit extends Cubit<AdminUserDetailState> {
  final AdminUserDetailRepository _repository;

  AdminUserDetailCubit(this._repository) : super(const AdminUserDetailState.initial());

  Future<void> fetchUserDetail(int userId) async {
    emit(const AdminUserDetailState.loading());

    try {
      final data = await _repository.fetchUserDetail(
        userId: userId,
      );
      
          emit(AdminUserDetailState.loaded(user: data));
    } catch (e) {
      emit(AdminUserDetailState.error(message: e.toString()));
    }
  }

  void reset() {
    emit(const AdminUserDetailState.initial());
  }
} 