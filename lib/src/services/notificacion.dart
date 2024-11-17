import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: camel_case_types
class notificacion {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // ignore: avoid_print
      print('Permiso concedido para notificaciones');
    } else {
      // ignore: avoid_print
      print('Permiso denegado para notificaciones');
    }

    String? token = await messaging.getToken();
    // ignore: avoid_print
    print('Token del dispositivo: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      print('Notificacion recibida: ${message.notification?.title}');
    });

    FirebaseMessaging.onBackgroundMessage(mensaje);
  }
}

@pragma('vm:entry-point')
Future<void> mensaje(RemoteMessage msn) async {
  // ignore: avoid_print
  print('Notidicacion en segundo plano: ${msn.notification?.title}');
}
