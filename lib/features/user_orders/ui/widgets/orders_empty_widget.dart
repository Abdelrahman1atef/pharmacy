import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/gradient_button.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../main/logic/main_cubit.dart';

class OrdersEmpty extends StatefulWidget {
  const OrdersEmpty({super.key});

  @override
  State<OrdersEmpty> createState() => _OrdersEmptyState();
}

class _OrdersEmptyState extends State<OrdersEmpty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.orders.svg(width: 150),
            const SizedBox(height: 20,),
            Text(
              S.of(context).noOrdersYet, 
              style: TextStyles.productTitles,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10,),
            Text(
              S.of(context).startShoppingToSeeOrders,
              style: TextStyles.productSubTitles.copyWith(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50,),
            GradientElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<MainCubit>(context).selectTab(0);
              },
              child: Text(
                S.of(context).startShopping,
                style: TextStyles.gradientElevatedButtonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 