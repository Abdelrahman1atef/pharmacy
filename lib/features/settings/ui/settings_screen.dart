import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/app_config_provider/app_config_provider.dart';
import 'package:pharmacy/core/themes/text/text_styles.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


// Selected language and theme mode
  String? _selectedLang;
  String? _selectedThemeMode;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<Object>> languages = [
      DropdownMenuEntry(value: "ar", label: S.of(context).arabic),
      DropdownMenuEntry(value: "en", label: S.of(context).english),
    ];
    List<DropdownMenuEntry<Object>> themeMode = [
       DropdownMenuEntry(value: ThemeMode.light, label:S.of(context).light),
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
                  Text(S.of(context).appMode, style: TextStyles.settingsTitle,),
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
