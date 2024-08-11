import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  static late final FlutterLocalNotificationsPlugin notificationsPlugin;

  static Future<void> initNotification() async {
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  static Future<void> scheduleNotification() async {
    notificationsPlugin.periodicallyShow(
      0,
      "Daily reminder",
      "Track you'r today's Expense",
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder',
          'Daily reminder',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }
}
