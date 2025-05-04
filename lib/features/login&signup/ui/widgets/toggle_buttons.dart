import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/login&signup/logic/login/login_cubit.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/colors.gen.dart';
import '../../logic/login/login_state.dart';

class MyToggleButtons extends StatelessWidget {
  final List<String> loginOption;
  final FocusNode emailPhoneFocusNode;
  const MyToggleButtons({
    required this.loginOption,
    required this.emailPhoneFocusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginScreenCubit, LoginScreenState>(
      builder: (BuildContext context, state) {
        return AnimatedToggleSwitch<bool>.size(
            current: state.isPhoneSelected,
            values: const [true, false],
            indicatorSize: const Size.fromWidth(double.infinity),
            customIconBuilder: (context, local, global) => Text(
                  local.value ? loginOption[0] : loginOption[1],
                  style: TextStyles.productTitles.copyWith(fontSize: 12.sp),
                ),
            iconAnimationType: AnimationType.onHover,
            style: ToggleStyle(
                indicatorColor: Colors.blue[200],
                borderColor: ColorName.whiteColor,
                borderRadius: BorderRadiusDirectional.circular(15)),
            selectedIconScale: 1,
            onChanged: (value) {
              emailPhoneFocusNode.unfocus();
              context.read<LoginScreenCubit>().setPhoneSelected(value);
              Future.delayed(const Duration(milliseconds: 500), () {
                emailPhoneFocusNode.requestFocus(); // Re-request focus after state update
              });
            });
      },
    );
  }
}
