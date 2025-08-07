import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../app_config_provider/logic/auth/model/data.dart';

class UserInfo extends StatelessWidget {
  final Data user;
  const UserInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: ColorName.secondaryColor,
              borderRadius: BorderRadiusDirectional.circular(50)),
          child: Center(
            child: user.profilePicture == " "
                ? Image.network("${user.profilePicture}")
                : Text(
                    user.firstName.substring(0, 1),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                  ),
          ),
        ),
        Text(
          "${user.firstName} ${user.lastName}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
        Text(
          user.phone,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
} 