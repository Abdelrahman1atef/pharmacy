// delivery_toggle_buttons.dart
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../logic/toggle_buttons_logic/checkout_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_state.dart';

class DeliveryToggleButtons extends StatelessWidget {
  const DeliveryToggleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (BuildContext context, state) {
        return AnimatedToggleSwitch<bool>.size(
          current: state.isHomeDeliverySelected,
          values: const [true, false],
          indicatorSize: const Size.fromWidth(double.infinity),
          customIconBuilder: (context, local, global) => Text(
            local.value
                ? S.of(context).homeDelivery
                : S.of(context).pharmacyPickup,
            style: TextStyles.productTitles.copyWith(
              fontSize: 12.sp,
              color: local.value == state.isHomeDeliverySelected
                  ? ColorName.whiteColor
                  : ColorName.productDetailTextColor,
            ),
          ),
          iconAnimationType: AnimationType.onHover,
          style: ToggleStyle(
            indicatorColor: Colors.blue[200],
            borderColor: ColorName.whiteColor,
            borderRadius: BorderRadiusDirectional.circular(15),
          ),
          selectedIconScale: 1,
          onChanged: (value) {
            context.read<CheckoutCubit>().setDeliveryMethod(value);

            // Optional: Add haptic feedback
            // HapticFeedback.lightImpact();

            // You can add any additional logic here
            Future.delayed(const Duration(milliseconds: 300), () {
              // Handle any post-toggle actions
              _onDeliveryMethodChanged(context, value);
            });
          },

        );
      },
    );
  }

  void _onDeliveryMethodChanged(BuildContext context, bool isHomeDelivery) {
    // Add any logic you want to execute after delivery method changes
    print('Delivery method changed to: ${isHomeDelivery ? 'Home Delivery' : 'Pharmacy Pickup'}');

    // You could show a snackbar, update other UI elements, etc.
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(isHomeDelivery ? 'Home delivery selected' : 'Pharmacy pickup selected'),
    //     duration: Duration(seconds: 1),
    //   ),
    // );
  }
}