import 'package:TheSpecialParty/services/push_notifications.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/models/HomeModel.dart';
import 'package:TheSpecialParty/models/categorymodel.dart';
import 'package:TheSpecialParty/screens/Notifications.dart';
import 'package:TheSpecialParty/screens/favoriteslist.dart';
import 'package:TheSpecialParty/screens/productslist.dart';
import 'package:TheSpecialParty/services/categoryservice.dart';
import 'package:TheSpecialParty/services/homeService.dart';
import 'package:TheSpecialParty/widgets/categoryitem.dart';
import 'package:vibration/vibration.dart';

Map links = {};

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool homeloading = false;

  int _current = 0;
  final tabs = [HomePage(), FavoritesList()];

  List categoriesList = [
    {'title': 'مناسبات وافراح', 'image': 'images/home1.png'},
    {'title': 'مواليد واعياد ميلاد', 'image': 'images/home3.png'},
    {'title': 'مناسبات عائلية', 'image': 'images/home4.png'},
    {'title': 'مناسبات اخري', 'image': 'images/home3.png'},
  ];
  List sliderlist = [
    {'img': 'images/slider1.png'},
    {'img': 'images/slider1.png'},
    {'img': 'images/slider1.png'}
  ];
  Future getCategories() async {
    var category = await CategoryService().getListOfCategories().then((value) {
      return value;
    });

    setState(() {
      cateogoryList = category;
    });
  }

  getHome() async {
    Map responsehome = await HomeService().homeget();

    setState(() {
      sliders = responsehome["sliders"];
    });
    print(responsehome);
    print(sliders);
  }

  getlinks() async {
    Map responsesettings = await HomeService().homeget();
    setState(() {
      links = responsesettings['setting'];
    });
    print('hena ellinks');
    print(links);
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  // Future onSelectNotification(String payload) async {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return new AlertDialog(
  //         title: Text("PayLoad"),
  //         content: Text("Payload : $payload"),
  //       );
  //     },
  //   );
  // }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.max,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound('notification'),
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_notification');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: onSelectNotification,
    );
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        }
        showNotification(
            message['notification']['title'], message['notification']['body']);
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print(message);
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        }
        print("onLaunch: $message");
        // Navigator.pushNamed(context, '/notify');
      },
      onBackgroundMessage: backgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print(message);
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        }
        print("onResume: $message");
      },
    );
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   homeloading = true;
    // });
    setState(() {
      homeloading = true;
    });
    getlinks();
    getHome();
    getCategories().then((value) {
      setState(() {
        homeloading = false;
      });
    });

    // HomeService().homeget();
    // firstTime();
    // print('links elhome');
  }

  List<Categorymodel> cateogoryList;
  List sliders;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
            color: Color(0xFFF8F8F8),
          ),
          child: homeloading
              ? SpinKitRing(color: pinktheme)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            child: CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 1),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) => {
                                    setState(() {
                                      _current = index;
                                    })
                                  },
                                ),
                                items: sliders
                                    .map((e) => Container(
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            'https://specialparty.ga' +
                                                                e['image_path']),
                                                        fit: BoxFit.fill)),
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList()),
                          ),
                        ),
                      ),
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: sliderlist.map((url) {
                              int index = sliderlist.indexOf(url);
                              return Container(
                                width: _current == index ? 9 : 7,
                                height: _current == index ? 9 : 7,
                                margin: EdgeInsets.only(
                                    top: 0.0, bottom: 9.0, left: 5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: pinktheme),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 80),
                          child: GridView.count(
                              crossAxisCount: categoriesList == null ? 1 : 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              childAspectRatio: 9 / 8,
                              // MediaQuery.of(context).size.height > 600
                              //     ? 9 / 12
                              //     : MediaQuery.of(context).size.height > 450
                              //         ? 9 / 15
                              //         : 9 / 16,
                              children:
                                  // categoriesList  == null
                                  // ? [
                                  //   SpinKitCubeGrid(
                                  //               color: Color(0xFFC92799),
                                  //               size: 50.0,
                                  //             )

                                  //   ]
                                  //   :
                                  cateogoryList
                                      .map((floweritem) => Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CategoryItem(
                                              txt: floweritem.name,
                                              img: floweritem.img_url,
                                              id: floweritem.id,
                                            ),
                                          ))
                                      .toList()),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
