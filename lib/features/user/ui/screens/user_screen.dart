import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../../app_config_provider/logic/auth/model/data.dart';
import '../../../../generated/l10n.dart';
import '../../model/account_action.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(orElse: () {
          return const SizedBox.shrink();
        }, authenticated: (user) {
          return Scaffold(
            appBar: const PharmacyAppBar(
              isGeneralLayout: true,
            ),
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _userInfoBody(context, user),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

Widget _userInfoBody(BuildContext context, Data user) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            S.of(context).profile,
            style: TextStyles.settingsTitle,
          ),
        ],
      ),
      _userInfo(user),
      const Divider(
        color: ColorName.blackColor,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accountDetails(context, user),
          _actionInAccount(context),
        ],
      )
    ],
  );
}

Widget _userInfo(Data user) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: ColorName.secondaryColor,
            borderRadius: BorderRadiusDirectional.circular(50)),
        child: Center(
          child: user.profilePicture == " "
              ? Image.network("${user.profilePicture}")
              : Text(
                  user.firstName.substring(0, 1),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                ),
        ),
      ),
      Text(
        "${user.firstName} ${user.lastName}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.sp,
        ),
      ),
      Text(
        user.phone,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15.sp,
        ),
      ),
    ],
  );
}

Widget _accountDetails(BuildContext context, Data user) {
  final List<Map<String, dynamic>> accountDetailsItems = [
    {"key": S.of(context).email, "value": user.email},
    {"key": S.of(context).gender, "value": user.gender},
    {"key": S.of(context).birthdate, "value": user.birthdate},
  ];
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).accountDetails, style: TextStyles.settingsTitle),
          Text(
            S.of(context).edit,
            style: TextStyles.loginSignupText.copyWith(
              color: ColorName.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: accountDetailsItems.map((item) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['key'], // Display the key
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  item['value'], // Display the value
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          );
        }).toList(),
      )
    ],
  );
}

Widget _actionInAccount(context) {
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
      action: () =>_logoutAction(context),
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
        padding:  EdgeInsetsDirectional.symmetric(vertical: 15.h,horizontal: 25.w),
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

void _logoutAction(BuildContext context) async {
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
