import 'package:flutter/material.dart';
import 'package:pharmacy/core/themes/text_styles.dart';
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 3);

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
              IconButton(
                onPressed: () {},
                icon: Assets.images.cartUnselected.svg(
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                color: Colors.white,
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
