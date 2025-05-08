import 'package:flutter/material.dart';

import '../../../main/ui/widgets/admin_scaffold.dart';

class AdminUserMangerScreen extends StatelessWidget {
  const AdminUserMangerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   AdminScaffold(
      body: Center(child: Text(key.toString()),),
    );
  }
}
