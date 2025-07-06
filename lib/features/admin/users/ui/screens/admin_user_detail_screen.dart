import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/features/admin/users/logic/admin_user_detail/admin_user_detail_cubit.dart';
import 'package:pharmacy/features/admin/users/ui/widgets/user_detail_header.dart';
import 'package:pharmacy/features/admin/users/ui/widgets/user_stats_card.dart';
import 'package:pharmacy/features/admin/users/ui/widgets/order_history_list.dart';
import 'package:pharmacy/generated/l10n.dart';

class AdminUserDetailScreen extends StatefulWidget {
  final int userId;

  const AdminUserDetailScreen({
    super.key,
    required this.userId,
  });

  @override
  State<AdminUserDetailScreen> createState() => _AdminUserDetailScreenState();
}

class _AdminUserDetailScreenState extends State<AdminUserDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminUserDetailCubit>().fetchUserDetail(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor1,
      appBar: AppBar(
        title: Text(
          S.of(context).userDetails,
          style: TextStyles.sectionTitles.copyWith(
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: BlocBuilder<AdminUserDetailCubit, AdminUserDetailState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (user) => SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDetailHeader(user: user),
                  const SizedBox(height: 24),
                  UserStatsCard(user: user),
                  const SizedBox(height: 24),
                  Text(
                    S.of(context).orderHistory,
                    style: TextStyles.sectionTitles.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OrderHistoryList(orderHistory: user.orderHistory),
                ],
              ),
            ),
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
                      context.read<AdminUserDetailCubit>().fetchUserDetail(widget.userId);
                    },
                    child: Text(S.of(context).retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 