import 'package:flutter/material.dart';
import 'package:pharmacy/core/themes/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../generated/l10n.dart';
import '../routes/routes.dart';

class HeaderWidget extends StatelessWidget {
  final String widgetTitle;
  final bool showAllIsVisible;

  const HeaderWidget(
      {super.key, required this.widgetTitle, this.showAllIsVisible = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widgetTitle, style: TextStyles.sectionTitles),
        Visibility(
          visible: showAllIsVisible,
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(context, Routes.itemListScreen,arguments: widgetTitle),
                child: Text(
                  S.of(context).show_all,
                  style: TextStyles.showAllText,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorName.secondaryColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
