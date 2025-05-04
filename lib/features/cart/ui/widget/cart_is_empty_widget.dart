import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/gradient_button.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../main/logic/main_cubit.dart';

class CartIsEmpty extends StatefulWidget {
  const CartIsEmpty({super.key});

  @override
  State<CartIsEmpty> createState() => _CartIsEmptyState();
}

class _CartIsEmptyState extends State<CartIsEmpty> {
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
                  BlocProvider.of<MainCubit>(context).selectTab(0);
                },
                child: Text(S.of(context).browsItem,style: TextStyles.gradientElevatedButtonText,))
          ],
        ),
      ),
    );
  }
}
