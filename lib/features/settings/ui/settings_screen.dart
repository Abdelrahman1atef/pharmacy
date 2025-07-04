

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../app_config_provider/app_config_provider.dart';
import '../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../../app_config_provider/logic/auth/model/data.dart';
import '../../../core/common_widgets/gradient_button.dart';
import '../../../core/routes/routes.dart';
import '../../../core/themes/text/text_styles.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../model/user_panel_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _selectedLang;
  String? _selectedThemeMode;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<Object>> languages = [
      DropdownMenuEntry(value: "ar", label: S.of(context).arabic),
      DropdownMenuEntry(value: "en", label: S.of(context).english),
    ];
    List<DropdownMenuEntry<Object>> themeMode = [
      DropdownMenuEntry(value: ThemeMode.light, label: S.of(context).light),
      DropdownMenuEntry(value: ThemeMode.dark, label: S.of(context).dark)
    ];
    var provider = Provider.of<AppConfigProvider>(context);
    _selectedLang=provider.appLang;
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 10.h),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _userSection(context),
                const Divider(),
                _appLang(
                  context: context,
                  languages: languages,
                  selectedLang: _selectedLang,
                  action: (value) {
                    setState(() {
                      provider.changeLang(value);
                    });
                  },
                ),
                Visibility(
                  visible: false,
                  child: _appTheme(
                    context: context,
                    themeMode: themeMode,
                    selectedThemeMode: _selectedThemeMode,
                    action: (value) {
                      setState(() {
                        provider.changeTheme(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _appLang(
    {context,
    languages,
    selectedLang,
    required dynamic Function(dynamic) action}) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).appLang,
          style: TextStyles.settingsTitle,
        ),
        SizedBox(
          height: 5.h,
        ),
        _dropdownMenu(
            dropdownMenuEntries: languages,
            hintText: selectedLang != null
                ? "${S.of(context).language} ($selectedLang)"
                : "${S.of(context).language} (${languages[0].label})",
            onSelected: action),
      ],
    ),
  );
}

Widget _appTheme(
    {context,
    themeMode,
    selectedThemeMode,
    required dynamic Function(dynamic) action}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        S.of(context).appMode,
        style: TextStyles.settingsTitle,
      ),
      _dropdownMenu(
          dropdownMenuEntries: themeMode,
          hintText: selectedThemeMode != null
              ? "$selectedThemeMode"
              : themeMode[0].label,
          onSelected: action)
    ],
  );
}

Widget _userSection(context) {
  return BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => const CircularProgressIndicator(),
          unauthenticated: (message) => _userUnAuthenticatedSection(context),
          authenticated: (user) {
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Visibility(
            //       visible: user.isStaff,
            //       child: ElevatedButton(
            //           style: ButtonStyle(
            //               backgroundColor:
            //               const WidgetStatePropertyAll(
            //                   ColorName.secondaryColor),
            //               shape: WidgetStatePropertyAll(
            //                   RoundedRectangleBorder(
            //                       borderRadius:
            //                       BorderRadiusDirectional
            //                           .circular(25))),
            //               fixedSize: const WidgetStatePropertyAll(
            //                   Size(200, 50))),
            //           onPressed: () => Navigator.pushNamed(
            //               context, Routes.adminMain),
            //           child: Text(
            //             "Admin Screen",
            //             style: TextStyle(
            //                 color: ColorName.whiteColor,
            //                 fontSize: 22.sp),
            //           )),
            //     )
            //   ],
            // )
            return _userAuthenticatedSection(context, user);
          });
    },
  );
}

double cardSize = 55.0;

Widget _userUnAuthenticatedSection(context) {
  return SizedBox(
    width: double.infinity,
    height: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).yourAccount,
          style: TextStyles.settingsTitle,
        ),
        Center(
            child: Text(
          S.of(context).notLoggedIn,
          style: TextStyles.loginSignupText,
        )),
        GradientElevatedButton(
          child: Text(S.of(context).LoginOrSignUp,
              style:
                  TextStyles.gradientElevatedButtonText.copyWith(fontSize: 15)),
          onPressed: () => Navigator.pushNamed(
            context,
            Routes.login,
          ),
        )
      ],
    ),
  );
}

Widget _userAuthenticatedSection(context, Data user) {
  final List<UserPanelItem> userSectionItems = [
    UserPanelItem(
        icon: Assets.images.userSelected.svg(),
        title: S.of(context).profile,
        function: () => Navigator.pushNamed(
              context,
              Routes.userScreen,
            )),
    UserPanelItem(
      icon: Assets.images.orders.svg(),
      title: S.of(context).myOrders,
      function: () {
        Navigator.pushNamed(
          context,
          Routes.userOrdersScreen,
        );

      }
    ),
    UserPanelItem(
      icon: Assets.images.admin.svg(),
      toStaff: true,
      title: S.of(context).adminScreen,
      function: () => Navigator.pushNamed(
        context,
        Routes.adminMain,
      ),
    ),
  ];
  final visibleItems = userSectionItems.where((item) {
    return !item.toStaff! || (item.toStaff! && user.isStaff);
  }).toList();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
        child: Text(
          S.of(context).yourAccount,
          style: TextStyles.settingsTitle,
        ),
      ),
      SizedBox(
        height: visibleItems.length * cardSize,
        child: ListView.builder(
          itemCount: visibleItems.length,
          itemBuilder: (context, index) =>
              _userPanelItem(visibleItems[index], user),
        ),
      )
    ],
  );
}

Widget _userPanelItem(UserPanelItem userSectionItem, Data user) {
  return InkWell(
    onTap: userSectionItem.function,
    child: SizedBox(
      height: cardSize,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 30.w, height: 30.h, child: userSectionItem.icon),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    userSectionItem.title,
                    style:
                        TextStyles.productDetailTitles.copyWith(fontSize: 17),
                  ),
                ],
              ),
              const Icon(Icons.arrow_right)
            ],
          ),
        ),
      ),
    ),
  );
}

_dropdownMenu(
    {required List<DropdownMenuEntry<Object>> dropdownMenuEntries,
    required String hintText,
    required Function(dynamic) onSelected}) {
  return DropdownMenu(
    width: double.infinity,
    dropdownMenuEntries: dropdownMenuEntries,
    hintText: hintText,
    trailingIcon: const Icon(Icons.arrow_left),
    selectedTrailingIcon: const Icon(Icons.arrow_drop_down),
    onSelected: onSelected,
    leadingIcon: const Icon(Icons.language_rounded),
    textStyle:
        TextStyles.productHomeTitles.copyWith(fontWeight: FontWeight.bold),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(35),
      ),
      filled: true,
    ),
    menuStyle: const MenuStyle(
      elevation: WidgetStatePropertyAll(5),
      visualDensity: VisualDensity(horizontal: 1),
    ),
  );
}
