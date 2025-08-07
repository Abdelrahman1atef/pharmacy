// import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  // static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Temporarily disabled due to Android compilation issue
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');

    // const InitializationSettings initializationSettings = InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   // Add iOS if needed
    // );

    // await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    // Temporarily disabled due to Android compilation issue
    // const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails(
    //   'default_channel_id',
    //   'Default',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   icon: '@mipmap/ic_launcher',
    // );
    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);
    // await _notificationsPlugin.show(
    //   0,
    //   title,
    //   body,
    //   platformChannelSpecifics,
    // );
  }
}



































