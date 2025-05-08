import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/app_config_provider/logic/internet_server_connection/logic/internet_server_connection_cubit.dart';
import 'package:pharmacy/app_config_provider/logic/internet_server_connection/logic/internet_server_connection_state.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';

import '../../app_config_provider/logic/auth/logic/auth_cubit.dart';
import '../../app_config_provider/logic/auth/logic/auth_state.dart';
import '../../core/routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          authenticated: (user) {
            if(user.isStaff ==false){//false
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacementNamed(context, Routes.main);
              });
            }else if(user.isStaff == true){//true
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacementNamed(context, Routes.adminMain);
              });
            }
          },
          unauthenticated: (e) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(context, Routes.login);
            });
          },
        );
      },
      child: BlocConsumer<InternetServerConnectionCubit,
          InternetServerConnectionState>(
        listener: (context, state) {
          if (state is ServerIsWork) {
            context.read<AuthCubit>().checkAuthStatus();
          }
        },
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: _buildStateUI(context, state),
          );
        },
      ),
    );
  }

  Widget _buildStateUI(
      BuildContext context, InternetServerConnectionState state) {
    return Scaffold(
      appBar: const PharmacyAppBar(
        heightFactor: 1.1,
        isGeneralLayout: false,
      ),
      body: state.when(
        initial: () => _loadingScreen(),
        loading: () => _loadingScreen(),
        error: (message) =>
            _noInternetScreen(context: context, message: message),
        deviceIsConnected: (message) =>
            _serverDownScreen(context: context, message: message),
        serverIsWork: () => _loadingAuthScreen(),
      ),
    );
  }

  /// 1. Shown while checking internet/server
  Widget _loadingScreen() {
    return _animatedLoading(message: "Checking connection...");
  }

  /// 2. If no internet
  Widget _noInternetScreen(
      {required BuildContext context, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 80, color: Colors.red),
          const SizedBox(height: 20),
          Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Restart app or retry logic
              Phoenix.rebirth(context);
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Try Again"),
          )
        ],
      ),
    );
  }

  /// 3. If device is online but server is unreachable
  Widget _serverDownScreen(
      {required BuildContext context, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 80, color: Colors.orange),
          const SizedBox(height: 20),
          Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              context
                  .read<InternetServerConnectionCubit>()
                  .emitDeviceIsConnected();
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Retry Server Check"),
          )
        ],
      ),
    );
  }

  /// 4. Once server works, wait for Auth result and show splash while waiting
  Widget _loadingAuthScreen() {
    return _animatedLoading(message: "Checking connection...");
  }


  Widget _animatedLoading({required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
              'assets/pharmacy_loading_animation.json',
              width: 300,
              height: 300,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Text(
              message,
              key: ValueKey(message),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }


}
