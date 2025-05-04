import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/app_config_provider/app_config_provider.dart';
import 'package:pharmacy/app_config_provider/auth/logic/auth_cubit.dart';
import 'package:pharmacy/app_config_provider/auth/logic/auth_state.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/routes.dart';
import '../../../generated/l10n.dart';

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
    // context.read<AuthCubit>().checkAuthStatus();
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
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 10.h),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
                      child: Text(
                        S.of(context).appLang,
                        style: TextStyles.settingsTitle,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    _dropdownMenu(
                      dropdownMenuEntries: languages,
                      hintText: _selectedLang != null
                          ? "${S.of(context).language} ($_selectedLang)"
                          : "${S.of(context).language} (${languages[0].label})",
                      onSelected: (value) {
                        setState(() {
                          provider.changeLang(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).appMode,
                    style: TextStyles.settingsTitle,
                  ),
                  _dropdownMenu(
                    dropdownMenuEntries: themeMode,
                    hintText: _selectedThemeMode != null
                        ? "$_selectedThemeMode"
                        : themeMode[0].label,
                    onSelected: (value) {
                      provider.changeTheme(value);
                    },
                  )
                ],
              ),
              BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const CircularProgressIndicator(),
                    unauthenticated: (e) => ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, Routes.login),
                          child: const Text("Login"),
                        ),
                    authenticated: (user) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Logged in as ${"${user.firstName} ${user.lastName}"}"),
                          _buildLogoutButton(context)

                        ],
                      );
                    });
              })
            ],
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
      trailingIcon: Icon(Icons.arrow_left),
      selectedTrailingIcon: Icon(Icons.arrow_drop_down),
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
}
Widget _buildLogoutButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Logout"),
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        await context.read<AuthCubit>().logout();

      }
    },
    child: const Text("Logout"),
  );
}

