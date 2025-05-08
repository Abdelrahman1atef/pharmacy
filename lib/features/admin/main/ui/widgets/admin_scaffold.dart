import 'package:flutter/material.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';

class AdminScaffold extends StatelessWidget {
  final Widget body;

  const AdminScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PharmacyAppBar(
        isGeneralLayout: false,
        heightFactor: 1.1,
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
