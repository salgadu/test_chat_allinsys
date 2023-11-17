import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/infra/notification/custom_notification.dart';
import 'package:mensageiro/app/core/infra/notification/notification_service.dart';

class FirebaseMessageService {
  final NotificationService _notificationService;
  final FirebaseMessaging firebaseMessaging;

  FirebaseMessageService(this._notificationService, this.firebaseMessaging);

  Future<void> initialize() async {
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
        badge: true, sound: true, alert: true);  
    _onMessage();
    _onMessageOpenedApp();
  }

  Future<String?> getDeviceFirebaseToken() async {
    final token = await firebaseMessaging.getToken();
    return token;
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _notificationService.showNotification(CustomNootification(
            id: android.hashCode,
            title: notification.title,
            body: notification.body,
            payload: message.data['route'] ?? ''));
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      Modular.to.pushNamed('/home/contacts/$route');
    }
  }
}
