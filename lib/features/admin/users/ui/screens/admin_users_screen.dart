import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/admin/users/logic/admin_users/admin_users_cubit.dart';
import 'package:pharmacy/features/admin/users/ui/widgets/user_card.dart';
import 'package:pharmacy/features/admin/users/ui/widgets/search_bar_widget.dart';
import 'package:pharmacy/gen/colors.gen.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AdminUsersCubit>().fetchUsers();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<AdminUsersCubit>().loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor1,
      appBar: const PharmacyAppBar(
        isGeneralLayout: false,
        heightFactor: 1.1223,
      ),
      body: Column(
        children: [
          Text(
            S.of(context).usersManagement,
            style: TextStyles.sectionTitles.copyWith(
              color: ColorName.blackColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              controller: _searchController,
              onSearch: (query) {
                context.read<AdminUsersCubit>().searchUsers(query);
              },
              onClear: () {
                _searchController.clear();
                context.read<AdminUsersCubit>().clearSearch();
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (users, searchQuery, isLoadingMore) {
                    if (users.results.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: AppColors.black.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              searchQuery != null && searchQuery.isNotEmpty
                                  ? S.of(context).noUsersFoundFor(searchQuery)
                                  : S.of(context).noUsersFound,
                              style: TextStyles.productSubTitles.copyWith(
                                color: AppColors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<AdminUsersCubit>().fetchUsers(
                              search: searchQuery,
                            );
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: users.results.length + (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == users.results.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final user = users.results[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: UserCard(
                              user: user,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/admin/user-detail',
                                  arguments: user.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${S.of(context).error}: $message',
                          style: TextStyles.productSubTitles.copyWith(
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AdminUsersCubit>().fetchUsers();
                          },
                          child: Text(S.of(context).retry),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 