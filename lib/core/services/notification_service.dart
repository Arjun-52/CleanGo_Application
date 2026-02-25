import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initialize notifications
  Future<void> init() async {
    // Ask notification permission
    NotificationSettings settings = await _messaging.requestPermission();

    print("Permission: ${settings.authorizationStatus}");

    // Get device FCM token
    String? token = await _messaging.getToken();
    print("FCM TOKEN => $token");

    // TODO: Send token to backend later
    // sendTokenToServer(token);

    // Foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification received in foreground");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
    });

    // Notification click handling
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification clicked");
    });
  }
}
