import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';

class DiscountSectionWidget extends StatelessWidget {
  const DiscountSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'خصوماتك',
                style: TextStyles.orderInfoText
                    .copyWith(fontSize: 18.sp, color: ColorName.blackColor,fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
           Text(
            'الرمز الترويجي',
            style: TextStyles.orderInfoText
                .copyWith(fontSize: 12.sp, color: ColorName.productDetailTextColor,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
           TextField(
            decoration: InputDecoration(
              hintText: 'إضافة الرمز',
              hintStyle: TextStyles.orderInfoText
                .copyWith(fontSize: 12.sp, color: ColorName.blackColor),
              prefixIcon: const Icon(Icons.local_offer_outlined),
              filled: true,
              fillColor: const Color(0xFFEAF6FB),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null, // Disabled
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.grey[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('تطبيق الرمز', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
} 