import 'package:flutter/material.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_cubit.dart';

import '../../generated/l10n.dart';
import '../routes/routes.dart';

class HeaderWidget extends StatelessWidget {
  final String widgetTitle;
  final bool showAllIsVisible;
  final FetchType? fetchType;

  const HeaderWidget({
    super.key, 
    required this.widgetTitle, 
    this.showAllIsVisible = true,
    this.fetchType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widgetTitle, style: TextStyles.sectionTitles),
        Visibility(
          visible: showAllIsVisible,
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context, 
              Routes.itemListScreen,
              arguments: {
                'title': widgetTitle,
                'fetchType': fetchType,
              },
            ),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Text(
                  S.of(context).show_all,
                  style: TextStyles.showAllText,
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorName.secondaryColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
