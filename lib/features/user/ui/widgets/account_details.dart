import 'package:flutter/material.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../../app_config_provider/logic/auth/model/data.dart';

class AccountDetails extends StatelessWidget {
  final Data user;
  const AccountDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
                    item['key'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item['value'],
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
} 