import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/network/api_service.dart';

import '../../../core/notifications/notification_service.dart';

class FCMService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final ApiService apiService;
  final String? userToken; // Auth token for backend

  FCMService({required this.apiService, required this.userToken});

  Future<void> initFCM(BuildContext context) async {
    // Request permissions (iOS, Android 13+)
    await _requestPermissions();
    // Get and send FCM token
    await _sendTokenToBackend();
    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showForegroundNotification(context, message);
    });
    // Optionally handle background/terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification tap
    });
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('Notification permission denied');
    }
  }

  Future<void> _sendTokenToBackend() async {
    String? fcmToken = await _messaging.getToken();
    if (fcmToken != null && userToken != null) {
      try {
        print('''
        fcmToken: $fcmToken,
        userToken: $userToken,
        ''');
        await apiService.sendFCMToken(fcmToken, userToken!);
      } catch (e) {
        debugPrint('Failed to send FCM token: $e');
      }
    }
  }

  void _showForegroundNotification(BuildContext context, RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
       NotificationService.showNotification(
         title: notification.title ?? 'New Notification',
         body: notification.body ?? '',
       );
    }
  }
} 