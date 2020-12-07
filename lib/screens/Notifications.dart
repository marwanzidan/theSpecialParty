import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/notificationmodel.dart';
import 'package:TheSpecialParty/services/notificationService.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationModel notificationModel = NotificationModel();
  List<NotificationsList> notificationsList = [];
  bool loading = false;
  Future getNotification() async {
    if (userModel != null) {
      setState(() {
        loading = true;
      });
      await NotificationService()
          .getNotification(
              link: notificationModel.notifications == null
                  ? null
                  : notificationModel.notifications.nextPageUrl)
          .then((value) {
        setState(() {
          notificationModel = value;
          if (value.notifications.notificationsList.isNotEmpty ||
              value.notifications != null) {
            notificationsList.addAll(value.notifications.notificationsList);
            final ids = notificationsList.map((e) => e.id).toSet();
            notificationsList.retainWhere((x) => ids.remove(x.id));
          }
          loading = false;
        });
      });
    }
  }

  @override
  void initState() {
    getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: SizedBox(width: 0),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ],
            title: Center(
              child: Text(
                'الإشعارات',
                style: TextStyle(
                    color: Colors.white, fontSize: 21, fontFamily: 'hayah'),
              ),
            ),
            elevation: 0,
            backgroundColor: pinktheme),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
              color: Color(0xFFF8F8F8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 25, left: 25, top: 30, bottom: 30),
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    // _loadData();
                    print('reached end');
                    setState(() {
                      if (notificationModel.notifications.nextPageUrl == null) {
                        print('there\'s no next page');
                      } else {
                        getNotification();
                      }
                    });
                  }
                  return true;
                },
                child: ListView(
                    children: loading
                        ? [
                            SpinKitRing(color: pinktheme),
                            Center(
                              child: Text(
                                'جاري تحميل الإشعارات...',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'hayah',
                                    fontSize: 20),
                              ),
                            )
                          ]
                        : userModel == null
                            ? [
                                Center(
                                  child: Text(
                                    'لا يمكنك استخدام هذه الخاصية بدون حساب',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'hayah',
                                        fontSize: 20),
                                  ),
                                )
                              ]
                            : notificationsList.length == 0
                                ? [
                                    Center(
                                      child: Text(
                                        'لا يوجد لديك إشعارات بعد',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'hayah',
                                            fontSize: 20),
                                      ),
                                    )
                                  ]
                                : notificationsList
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.14,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          9.0),
                                                  color:
                                                      const Color(0xffffffff),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                          0x29000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 6,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image(
                                                          image: AssetImage(
                                                              'images/notification.png')),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            8.0),
                                                                child: Text(
                                                                  e
                                                                      .notificationData
                                                                      .order
                                                                      .status
                                                                      .status,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'hayah',
                                                                    fontSize:
                                                                          MediaQuery.of(context).size.height*0.022,
                                                                    color: const Color(
                                                                        0xff000000),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    height: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            12.0),
                                                                child: Text(
                                                                  "${DateFormat("hh:mm yyyy-MM-dd",).format(DateTime.parse(e.notificationData.order.createdAt).toLocal())}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                           MediaQuery.of(context).size.height*0.021,
                                                                      fontFamily:
                                                                          'hayah',
                                                                      color: Color(
                                                                          0xFF9F9F9F)),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.14,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(9),
                                                    bottomRight:
                                                        Radius.circular(9),
                                                  ),
                                                  color: pinktheme,
                                                ),
                                              ),
                                              Positioned(
                                                  top: 5,
                                                  left: 5,
                                                  child: Icon(
                                                    FontAwesomeIcons
                                                        .solidCircle,
                                                    color: pinktheme,
                                                    size: 10,
                                                  ))
                                            ],
                                          ),
                                        ))
                                    .toList()),
              ),
            )),
      ),
    );
  }
}
