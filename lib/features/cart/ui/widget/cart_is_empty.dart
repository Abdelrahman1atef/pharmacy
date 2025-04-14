import 'package:flutter/material.dart';

import '../../../../core/common_widgets/gradient_button.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../main/presentation/screens/main_screen.dart';

class CartIsEmpty extends StatelessWidget {
  const CartIsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.cartNoItem.svg(width: 150),
            const SizedBox(height: 20,),
            Text(S.of(context).noItemInCart,style: TextStyles.productTitles,),
            const SizedBox(height: 50,),

            GradientElevatedButton(
                onPressed: () {
                  mainPageKey.currentState?.changePage(0);
                },
                text: S.of(context).browsItem)
          ],
        ),
      ),
    );
  }
}
