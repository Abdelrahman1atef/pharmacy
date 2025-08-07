import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../model/account_action.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountActions extends StatelessWidget {
  const AccountActions({super.key});

  @override
  Widget build(BuildContext context) {
    List<AccountAction> actionItems = [
      AccountAction(
        text: Text(
          S.of(context).changePassword,
          style: TextStyles.loginSignupText.copyWith(
            color: ColorName.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: () {},
      ),
      AccountAction(
        icon: Assets.images.logout.svg(),
        text: Text(
          S.of(context).logout,
          style: TextStyles.unavailabilityText.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        action: () => logoutAction(context),
      ),
      AccountAction(
        icon: Assets.images.deleteAccount.svg(),
        text: Text(
          S.of(context).deleteAccount,
          style: TextStyles.unavailabilityText.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        action: () {},
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: actionItems.map((item) {
        return Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 15.h, horizontal: 25.w),
          child: InkWell(
            onTap: item.action,
            child: Row(
              children: [
                if (item.icon != null) item.icon!,
                item.text,
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

Future<void> logoutAction(BuildContext context) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(S.of(context).confirmLogoutTitle),
      content: Text(S.of(context).confirmLogoutContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          },
          child: Text(S.of(context).logout),
        ),
      ],
    ),
  );

  if (shouldLogout == true) {
    final authCubit = context.read<AuthCubit>();
    await authCubit.logout();
  }
} 