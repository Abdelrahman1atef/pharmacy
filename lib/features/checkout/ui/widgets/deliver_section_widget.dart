import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/checkout/ui/widgets/time&date_picker_dialog.dart';

import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../logic/toggle_buttons_logic/checkout_cubit.dart';
import '../../logic/toggle_buttons_logic/checkout_state.dart';

class DeliverSectionWidget extends StatelessWidget {
  const DeliverSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadiusDirectional.circular(15)),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) => state.isHomeDeliverySelected
              ? _buildDeliverySection(
            context: context,
            isDelivery: true,
            title: S.of(context).delivery,
            changeTimeText: S.of(context).changeTimeDeliver,
          )
              : _buildDeliverySection(
            context: context,
            isDelivery: false,
            title: S.of(context).pickup,
            changeTimeText: S.of(context).changeTimePickup,
          ),
        ),
      ),
    );
  }

  Widget _buildDeliverySection({
    required BuildContext context,
    required bool isDelivery,
    required String title,
    required String changeTimeText,
  }) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with title and change time button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyles.orderInfoText
                      .copyWith(fontSize: 18.sp, color: ColorName.blackColor,fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () async {
                    final selectedDateTime = await TimeAndDatePickerDialog.showTimeAndDatePicker(
                      context: context,
                      isDelivery: isDelivery,
                      initialDateTime: state.selectedDateTime,
                    );
                    if (selectedDateTime != null) {
                      context.read<CheckoutCubit>().setSelectedDateTime(selectedDateTime);
                    }
                  },
                  child: Text(
                    changeTimeText,
                    style: TextStyles.orderInfoText.copyWith(
                      fontSize: 14.sp,
                      color: ColorName.secondaryColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
            // Add spacing after header for pickup (to match original behavior)
            if (!isDelivery) const SizedBox(height: 10),

            // Display selected delivery window if available
            if (state.selectedDateTime != null && state.slotEndDateTime != null)
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorName.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16.sp,
                      color: ColorName.secondaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        // Example: "04 Jul 2025 - 04:30 PM to 06:30 PM"
                        '${DateFormat('dd MMM yyyy').format(state.selectedDateTime!)} - '
                        '${DateFormat('hh:mm a').format(state.selectedDateTime!)} to '
                        '${DateFormat('hh:mm a').format(state.slotEndDateTime!)}',
                        style: TextStyles.productTitles.copyWith(
                          fontSize: 12.sp,
                          color: ColorName.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Call request and status section
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: state.isCallRequestEnabled,
                      onChanged: (value) {
                        context.read<CheckoutCubit>().setCallRequestEnabled(value ?? false);
                      },
                    ),
                    Expanded(
                      child: Text(
                        S.of(context).requestACallToConfirmTheOrder,
                        style: TextStyles.productTitles.copyWith(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Bottom spacing
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}