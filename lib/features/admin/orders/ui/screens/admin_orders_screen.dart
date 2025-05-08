import 'package:flutter/material.dart';
import 'package:pharmacy/features/admin/main/ui/widgets/admin_scaffold.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: Center(child: Text(this.key.toString()),),
    );
  }
}
