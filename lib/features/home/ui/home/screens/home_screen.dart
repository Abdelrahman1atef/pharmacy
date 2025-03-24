import 'package:flutter/material.dart';
import '../../../../../core/common_widgets/pharmacy_app_bar.dart';
import '../../../../../core/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                PharmacyAppBar(
                  widget: const Text(
                    "صباح الخير",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  searchEnabled: false,
                  onSearchTap: () =>
                      Navigator.pushNamed(context, Routes.searchScreen),
                ),
              ],
            ),
          )),
    );
  }
}
