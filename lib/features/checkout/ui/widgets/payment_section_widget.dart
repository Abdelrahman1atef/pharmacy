import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../logic/payment/payment_cubit.dart';
import '../../logic/payment/payment_state.dart';
import '../../logic/payment/payment_options.dart';

class PaymentSectionWidget extends StatelessWidget {
  const PaymentSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentOptions = getPaymentOptions(context);

    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).orderDetailsPayment,
                  style: TextStyles.orderInfoText
                      .copyWith(fontSize: 18.sp, color: ColorName.blackColor,fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 5),
              ...List.generate(paymentOptions.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: index,
                        groupValue: state.selectedPaymentIndex,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<PaymentCubit>().selectPayment(value);
                          }
                        },
                      ),
                      Icon(paymentOptions[index].icon,
                          color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          paymentOptions[index].labelBuilder(context) ,
                          style: TextStyles.orderInfoText
                              .copyWith(fontSize: 14.sp, color: ColorName.blackColor,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
