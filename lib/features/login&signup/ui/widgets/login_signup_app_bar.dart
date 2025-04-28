import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/device_size.dart';

class LoginSignUpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginSignUpAppBar(
      {super.key,});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.1);

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);
    return Container(
      height: deviceSize.height * 0.207,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(20),
          bottomEnd: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            ColorName.primaryColor,
            ColorName.secondaryColor,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: deviceSize.topPadding+8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => { Navigator.pop(context)},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )),
              Row(
                children: [
                  Text(S.of(context).app_name, style: TextStyles.appTitle),
                  Padding(
                    padding:  EdgeInsetsDirectional.only(start: 8.w),
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(Assets.images.rPIcon.path),
                    ),
                  ),
                ],
              ),
              SizedBox()
            ],
          ),


        ],
      ),
    );
  }
}
