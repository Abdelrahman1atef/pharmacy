import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import 'user_info.dart';
import 'account_details.dart';
import 'account_actions.dart';

import '../../../../app_config_provider/logic/auth/model/data.dart';

class UserInfoBody extends StatelessWidget {
  final Data user;
  const UserInfoBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: 20.h,),
        UserInfo(user: user),
        const Divider(
          color: ColorName.blackColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountDetails(user: user),
            const AccountActions(),
          ],
        ),
        SizedBox(height: 50.h,)
      ],
    );
  }
} 