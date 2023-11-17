import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/infra/notification/custom_notification.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDatails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotification();
  }

  _setupNotification() async {
    await _initializeNotification();
  }

  _initializeNotification() async {
    if (Platform.isAndroid) {
      //Solicitar permição de notificações android apartir do android 13
      localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await localNotificationsPlugin.initialize(
        const InitializationSettings(
          android: android,
        ), onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      _selectedNotification(notificationResponse.payload);
    });
  }

  _selectedNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Modular.to.pushNamed('/home/contacts/$payload');
    }
  }

  showNotification(CustomNootification nootification) {
    androidDatails = const AndroidNotificationDetails(
      'message_notification_1',
      'message',
      channelDescription: 'Este canal é para notificações de menssagens',
      importance: Importance.max,
      priority: Priority.max,
    );

    localNotificationsPlugin.show(
      nootification.id,
      nootification.title,
      nootification.body,
      NotificationDetails(
        android: androidDatails,
      ),
      payload: nootification.payload,
    );
  }

  checkForNotification() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _selectedNotification(details.notificationResponse!.payload);
    }
  }
}
