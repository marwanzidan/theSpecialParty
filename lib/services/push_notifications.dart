import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<String> getToken() async {
    return await _fcm.getToken();
  }

  Future initialise() async {
    // AudioCache audioCache = AudioCache();
    // Future<void> audioOnInit() async {
    //   await FlutterRadio.play(url: streamUrl);
    //   print('Audio Start On Init OK');
    // }

    // audioOnInit();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    // audioCache.play('assets/sounds/notification.wav');
    // AudioPlayer().play('assets/sounds/notification.wav', isLocal: true);
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.getToken().then((val) {});
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print(message);
      },
    );
  }
}
