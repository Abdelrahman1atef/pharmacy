import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import '../../features/search/ui/widget/search_widget.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../generated/l10n.dart';
import '../../utils/device_size.dart';

class PharmacyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const Widget defaultChild = Icon(
    Icons.arrow_back,
    color: Colors.white,
  );
  final bool searchEnabled;
  final bool backEnabled;
  final bool isGeneralLayout;
  final VoidCallback? onSearchTap;
  final TextEditingController? searchController;
  final Widget child;
  final double heightFactor;

  const PharmacyAppBar(
      {super.key,
      this.searchEnabled = false,
      this.backEnabled = true, // Default behavior: disabled
      this.onSearchTap,
      this.searchController,
      this.child = defaultChild,
      this.isGeneralLayout = true,
      this.heightFactor = 2.71
      });

  final bool isUnauthenticated = true;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * heightFactor);

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);
    return isGeneralLayout
        ? generalLayout(context, deviceSize)
        : loginSignUpLayout(context, deviceSize);
  }

  Widget generalLayout(BuildContext context, deviceSize) {
    return Container(
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
            height: deviceSize.topPadding + 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).app_name, style: TextStyles.appTitle),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: Image.asset(Assets.images.rPIcon.path),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => {if (backEnabled) Navigator.pop(context)},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: child,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 8, vertical: 2),
            child: SearchWidget(
              enabled: searchEnabled,
              onTap: onSearchTap,
              searchController: searchController,
            ),
          ),
        ],
      ),
    );
  }

  Widget loginSignUpLayout(BuildContext context, deviceSize) {
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
            height: deviceSize.topPadding + 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () => {Navigator.pop(context)},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )),
              Row(
                children: [
                  Text(S.of(context).app_name, style: TextStyles.appTitle),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 8.w),
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.asset(Assets.images.rPIcon.path),
                    ),
                  ),
                ],
              ),
              const SizedBox()
            ],
          ),
          SizedBox(height: 8.h,),
        ],
      ),
    );
  }
}
