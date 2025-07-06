import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy/core/models/admin_user/admin_user_list_response.dart';
import 'package:pharmacy/features/admin/users/repository/admin_users_repository.dart';

part 'admin_users_state.dart';
part 'admin_users_cubit.freezed.dart';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  final AdminUsersRepository _repository;

  AdminUsersCubit(this._repository) : super(const AdminUsersState.initial());

  Future<void> fetchUsers({String? search, int page = 1}) async {
    if (page == 1) {
      emit(const AdminUsersState.loading());
    } else {
      emit(state.maybeWhen(
        loaded: (users, searchQuery, isLoadingMore) => AdminUsersState.loaded(
          users: users,
          searchQuery: searchQuery,
          isLoadingMore: true,
        ),
        orElse: () => const AdminUsersState.loading(),
      ));
    }

    try {
      final data = await _repository.fetchUsers(
        search: search,
        page: page,
      );
      
          if (page == 1) {
            emit(AdminUsersState.loaded(users: data, searchQuery: search));
          } else {
            final currentUsers = state.maybeWhen(
              loaded: (users, searchQuery, isLoadingMore) => users.results,
              orElse: () => <AdminUser>[],
            );
            
            final updatedResults = [...currentUsers, ...data.results];
            final updatedResponse = AdminUserListResponse(
              count: data.count,
              next: data.next,
              previous: data.previous,
              results: updatedResults,
            );
            
            emit(AdminUsersState.loaded(
              users: updatedResponse,
              searchQuery: search,
            ));
          }
    } catch (e) {
      emit(AdminUsersState.error(message: e.toString()));
    }
  }

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      await fetchUsers();
    } else {
      await fetchUsers(search: query);
    }
  }

  Future<void> loadMoreUsers() async {
    final currentState = state;
    currentState.maybeWhen(
      loaded: (users, searchQuery, isLoadingMore) {
        if (users.next != null) {
          final nextPage = _extractPageFromUrl(users.next!);
          if (nextPage != null) {
            fetchUsers(search: searchQuery, page: nextPage);
          }
        }
      },
      orElse: () {},
    );
  }

  int? _extractPageFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final pageParam = uri.queryParameters['page'];
      return pageParam != null ? int.parse(pageParam) : null;
    } catch (e) {
      return null;
    }
  }

  void clearSearch() {
    fetchUsers();
  }
} 