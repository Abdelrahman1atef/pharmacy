import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/gen/colors.gen.dart';

import '../../app_config_provider/auth/logic/auth_cubit.dart';
import '../../app_config_provider/auth/logic/auth_state.dart';
import '../../core/routes/routes.dart';
import '../../gen/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => curr != prev,
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          authenticated: (user) {
            Future.delayed(
              const Duration(seconds: 5),
              () => Navigator.pushReplacementNamed(context, Routes.main),
            );
          },
          unauthenticated: (e) {
            Future.delayed(
              const Duration(seconds: 5),
              () => Navigator.pushReplacementNamed(context, Routes.login),
            );
          },
        );
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Card(
                shape: const CircleBorder(),
                shadowColor: ColorName.blackColor,
                elevation: 50,
                child: Image.asset(
                  Assets.images.rPIcon.path,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
