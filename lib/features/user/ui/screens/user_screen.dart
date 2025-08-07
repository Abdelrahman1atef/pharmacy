import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';

import '../../../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../widgets/user_info_body.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(orElse: () {
          return const SizedBox.shrink();
        }, authenticated: (user) {
          return Scaffold(
            appBar: const PharmacyAppBar(
              isGeneralLayout: true,
            ),
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 15,vertical: 15),
                  child: SingleChildScrollView(
                     child:  UserInfoBody(user: user),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
