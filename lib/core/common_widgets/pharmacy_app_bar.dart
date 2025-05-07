import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/app_config_provider/auth/logic/auth_cubit.dart';
import 'package:pharmacy/app_config_provider/auth/logic/auth_state.dart';
import 'package:pharmacy/app_config_provider/auth/model/data.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import '../../features/search/ui/widget/search_widget.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../generated/l10n.dart';
import '../../utils/device_size.dart';
import '../../utils/network_image_utils.dart';

class PharmacyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const Widget defaultChild = Icon(
    Icons.arrow_back,
    color: Colors.white,
  );
  final bool searchEnabled;
  final bool backEnabled;
  final VoidCallback? onSearchTap;
  final TextEditingController? searchController;
  final Widget child;

  const PharmacyAppBar(
      {super.key,
      this.searchEnabled = false,
      this.backEnabled = true, // Default behavior: disabled
      this.onSearchTap,
      this.searchController,
      this.child = defaultChild});

  final bool isUnauthenticated = true;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2.71);

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);
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
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  Data? userInfo;
                  final isUnauthenticated = state.when(
                    initial: () => false,
                    loading: () => false,
                    unauthenticated: (e) => true,
                    authenticated: (user) {
                        userInfo = user;
                      return false;
                    },
                  );

                  return SizedBox(
                      width: 50.w,
                      height: 50.h,
                      child: userInfo == null
                          ? IconButton(
                              onPressed: () => isUnauthenticated
                                  ? Navigator.pushNamed(context, Routes.login)
                                  : print("Is Auth"),
                              icon: Assets.images.defaultProfileImage.svg(
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn)),
                              color: Colors.white,
                            )
                          : Padding(
                            padding: const EdgeInsetsDirectional.all(8.0),
                            child: Image.network(
                                userInfo?.profilePicture ?? "",
                                loadingBuilder: loadingBuilder(),
                                errorBuilder: (context, error, stackTrace) =>
                                    Assets.images.defaultProfileImage.svg(
                                        colorFilter: const ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn)),
                              ),
                          ));
                },
              ),
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
}
