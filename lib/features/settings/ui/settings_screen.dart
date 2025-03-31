import 'package:flutter/material.dart';


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
