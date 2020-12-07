import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/models/UserModel.dart';
import 'dart:ui' as ui;

import 'package:TheSpecialParty/screens/aboutus.dart';
import 'package:TheSpecialParty/screens/loginpage.dart';
import 'package:TheSpecialParty/screens/paymentmethod.dart';
import 'package:TheSpecialParty/screens/splashscreen.dart';
import 'package:TheSpecialParty/services/sharedprefrences.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';
import 'package:easy_localization/easy_localization.dart';

UserModel userModel;
String userMobileToken;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// void main() {
//   runApp(
//     MyApp(),
//     // EasyLocalization(
//     //   child: MyApp(),
//     //   path: "resources/langs",
//     //   saveLocale: true,
//     //   supportedLocales: [
//     //     Locale('ar', 'AR'),
//     //     Locale('en', 'EN'),
//     //   ],
//     // ),
//   );
// }

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: pinktheme, primaryColor: pinktheme),
      title: 'The Special Party',
      home: Splashscreen(),
      builder: (context, child) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: child,
        );
      },
    );
  }
}
