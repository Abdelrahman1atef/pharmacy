// initial_check_screen.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/core/network/constant.dart';
import '../../../core/network/dio_config.dart';
import '../../../pharmacy_app.dart';
import 'offline_screen.dart';

class InitialCheckScreen extends StatefulWidget {
  const InitialCheckScreen({super.key});

  @override
  State<InitialCheckScreen> createState() => _InitialCheckScreenState();
}

class _InitialCheckScreenState extends State<InitialCheckScreen> {
  bool _isOnline = false;
  bool _isLoading = true;

  Future<void> checkServerStatus() async {
    Dio dio = DioConfig.getDio();

    try {
      final response = await dio.get(Constant.apiHealth); // Use health check endpoint

      if (response.statusCode == 200 && response.data['status'] == 'ok') {
        setState(() {
          _isOnline = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isOnline = false;
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      setState(() {
        _isOnline = false;
        _isLoading = false;
      });

      print("Dio Error while checking server status: ${e.message}");
    } catch (e) {
      setState(() {
        _isOnline = false;
        _isLoading = false;
      });

      print("Unexpected error during server check: $e");
    }
  }
  @override
  void initState() {
    super.initState();
    checkServerStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isOnline) {
      return const  OfflineScreen(); // Show offline screen
    }

    // Server is online, proceed to main app
    return const PharmacyApp();
  }
}