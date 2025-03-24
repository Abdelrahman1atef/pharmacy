import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/search/ui/widget/search_widget.dart';
import '../../gen/colors.gen.dart';
import '../../utils/device_size.dart';

class PharmacyAppBar extends StatelessWidget {
  final bool searchEnabled;
  final VoidCallback? onSearchTap;
  final TextEditingController? searchController;
  final Widget widget;

  const PharmacyAppBar(
      {super.key,
      this.searchEnabled = false, // Default behavior: disabled
      this.onSearchTap,
      this.searchController,
      this.widget = const Icon(
        Icons.arrow_back,
        color: Colors.white,
      )});

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);
    // String? currentRoute = ModalRoute.of(context)?.settings.name;
    return Container(
      height: deviceSize.height * 0.2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(20),
          bottomEnd: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            ColorName.primaryColor,
            Colors.blue,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: deviceSize.topPadding,
          ),
          Text(
            "Pharmacy",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () => {
                  if(searchEnabled)
                  Navigator.pop(context)
                },
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget,
              ))
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
