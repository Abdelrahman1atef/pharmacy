import 'package:flutter/material.dart';

import '../../../core/common_widgets/pharmacy_app_bar.dart';
import '../../../core/routes/routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<DropdownMenuEntry>langs=[
    const DropdownMenuEntry(value: "ar", label: "Arabic"),
    const DropdownMenuEntry(value: "en", label: "English"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PharmacyAppBar(
                  searchEnabled: false,
                  onSearchTap: () =>
                      Navigator.pushNamed(context, Routes.searchScreen),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Lang"),
                    DropdownMenu(dropdownMenuEntries: langs,hintText: langs[0].label,)
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
