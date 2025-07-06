
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import '../../logic/product/product_cubit.dart';
import '../../logic/product/product_state.dart';

class ProductUnitToggle extends StatelessWidget {
  final Results product;

  const ProductUnitToggle({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (BuildContext context, state) {
        return AnimatedToggleSwitch<bool>.size(
          current: state.selectedUnit == 'productUnit2',
          values: const [false, true],
          indicatorSize: const Size.fromWidth(double.infinity),
          customIconBuilder: (context, local, global) => Text(
            local.value ? product.productUnit2! : product.productUnit1!,
            style: TextStyles.productTitles,
          ),
          iconAnimationType: AnimationType.onHover,
          style: ToggleStyle(
            indicatorColor: Colors.blue[200],
            borderColor: ColorName.whiteColor,
            borderRadius: BorderRadiusDirectional.circular(15),
          ),
          selectedIconScale: 1,
          onChanged: (value) {
            final selectedUnit = value ? 'productUnit2' : 'productUnit1';
            final price = value ? product.unit2SellPrice! : product.sellPrice!;
            context.read<ProductCubit>().selectUnit(selectedUnit, price);
          },
        );
      },
    );
  }
} 