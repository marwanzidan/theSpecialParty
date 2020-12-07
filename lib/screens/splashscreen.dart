import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/UserModel.dart';
import 'package:TheSpecialParty/screens/Homepage.dart';
import 'package:TheSpecialParty/screens/loginpage.dart';
import 'package:TheSpecialParty/services/push_notifications.dart';
import 'package:TheSpecialParty/services/sharedprefrences.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    PushNotificationService()
      ..initialise()
      ..getToken().then((value) {
        print("Mobile Token: $value");
        setState(() {
          userMobileToken = value;
        });
      });
    super.initState();
    checkLogin();
    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 4000), () {});

    return true;
  }

  void _navigateToHome() {
    userModel == null
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          )
        : Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationPage(
                      currentindex: 0,
                    )),
          );
  }

  Future checkLogin() async {
    String user = await readData(key: 'user');
    if (user != null) {
      setState(() {
        userModel = UserModel.fromJson(json.decode(user));
        print(userModel.accessToken);
      });
    } else {
      setState(() {
        userModel = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          // persistentFooterButtons: [
          //   Image(image: AssetImage('images/splashscreen.png'))
          // ],
          body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image(image: AssetImage('images/logohd.png'))),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/splashscreen.png'))),
          )
        ],
      )),
    );
  }
}
