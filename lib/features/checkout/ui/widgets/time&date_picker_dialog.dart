import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';

class TimeAndDatePickerDialog {
  static Future<DateTime?> showTimeAndDatePicker({
    required BuildContext context,
    required bool isDelivery, // true for delivery, false for pickup
    DateTime? initialDateTime,
  }) async {
    final now = DateTime.now();
    DateTime selectedDate = initialDateTime?.date ?? now;
    TimeOfDay selectedTime = initialDateTime != null
        ? TimeOfDay.fromDateTime(initialDateTime)
        : TimeOfDay.now();

    return await showDialog<DateTime?>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                isDelivery
                    ? S.of(context).selectDeliveryTime
                    : S.of(context).selectPickupTime,
                style: TextStyles.orderInfoText.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Selection
                    Text(
                      S.of(context).selectDate,
                      style: TextStyles.productTitles.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: now,
                          lastDate: now.add(const Duration(days: 30)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: ColorName.secondaryColor,
                                  onPrimary: ColorName.whiteColor,
                                  surface: ColorName.whiteColor,
                                  onSurface: ColorName.blackColor,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(selectedDate),
                              style: TextStyles.productTitles.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              size: 18.sp,
                              color: ColorName.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Time Selection
                    Text(
                      S.of(context).selectTime,
                      style: TextStyles.productTitles.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: ColorName.secondaryColor,
                                  onPrimary: ColorName.whiteColor,
                                  surface: ColorName.whiteColor,
                                  onSurface: ColorName.blackColor,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedTime.format(context),
                              style: TextStyles.productTitles.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(
                              Icons.access_time,
                              size: 18.sp,
                              color: ColorName.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Selected DateTime Display
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: ColorName.secondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).selectedDateTime,
                            style: TextStyles.productTitles.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorName.secondaryColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            DateFormat('EEEE, MMMM dd, yyyy - hh:mm a').format(
                              DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              ),
                            ),
                            style: TextStyles.productTitles.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyles.productTitles.copyWith(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final selectedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                    Navigator.of(context).pop(selectedDateTime);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorName.secondaryColor,
                    foregroundColor: ColorName.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    S.of(context).confirm,
                    style: TextStyles.productTitles.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// Extension to get date without time
extension DateTimeExtension on DateTime {
  DateTime get date => DateTime(year, month, day);
}