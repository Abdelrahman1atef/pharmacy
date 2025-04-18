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
                        provider.changeLang(value);
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

  _dropdownButton(
      {required List<DropdownMenuItem<Object>> dropdownMenuItem,
      required String hintText,
      required Function(dynamic) onSelected}) {
    return DropdownButton(
      items: dropdownMenuItem,
      onChanged: (value) {},
      hint: Text(hintText),
    );
  }
}

//################################################################
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../app_config_provider/app_config_provider.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
//   // Language options
//   List<Map<String, dynamic>> languages = [
//     {'value': "ar", 'label': "العربية"},
//     {'value': "en", 'label': "English"},
//   ];
//
//   // Selected language
//   String? _selectedLang;
//
//   // Animation controller for dropdown menu
//   late final AnimationController _animationController;
//   late final Animation<double> _opacityAnimation;
//
//   // Flag to track if the dropdown is visible
//   bool _isDropdownVisible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _opacityAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<AppConfigProvider>(context);
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20), // Spacing at the top
//
//             // Language Section
//             Text(
//               "لغة التطبيق",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//
//             // Custom Dropdown Container
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Column(
//                 children: [
//                   // Dropdown Button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Text(
//                             _selectedLang != null
//                                 ? "${_selectedLang} (${languages.firstWhere((lang) => lang['value'] == _selectedLang)['label']})"
//                                 : "اللغة (العربية)",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.arrow_drop_down),
//                         onPressed: () {
//                           setState(() {
//                             _isDropdownVisible = !_isDropdownVisible; // Toggle visibility
//                             if (_isDropdownVisible) {
//                               _animationController.forward(); // Show dropdown
//                             } else {
//                               _animationController.reverse(); // Hide dropdown
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 1, thickness: 1),
//
//                   // Animated Dropdown Options
//                   AnimatedOpacity(
//                     opacity: _isDropdownVisible ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                     child: Column(
//                       children: [
//                         ...languages.map((lang) {
//                           return RadioListTile(
//                             title: Text(lang['label']),
//                             value: lang['value'],
//                             groupValue: _selectedLang,
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedLang = value as String;
//                                 provider.changeLang(value); // Update provider
//                                 _isDropdownVisible = false; // Close dropdown after selection
//                                 _animationController.reverse(); // Hide dropdown
//                               });
//                             },
//                           );
//                         }).toList(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20), // Spacing between sections
//
//             // Additional Sections (e.g., About App, Share, etc.)
//             // You can add more sections here following the same pattern
//           ],
//         ),
//       ),
//     );
//   }
// }
