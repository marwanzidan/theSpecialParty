import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/getallordersmode.dart';
import 'package:TheSpecialParty/screens/Homepage.dart';
import 'package:TheSpecialParty/screens/myorderdetails.dart';
import 'package:TheSpecialParty/screens/registrationpage.dart';
import 'package:TheSpecialParty/services/getordersservice.dart';
import 'package:TheSpecialParty/services/orderService.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool notauser = false;
  bool ordersloading = false;
  GetOrdersModel getOrdersModel = GetOrdersModel();
  List<MyOrderData> myOrderDataList = [];
  getMyOrders() async {
    setState(() {
      ordersloading = true;
    });

    getOrdersModel = await GetOrderService()
        .getListOfOrders(
            link: getOrdersModel.orders == null
                ? null
                : getOrdersModel.orders.nextPageUrl)
        .then((value) {
      setState(() {
        getOrdersModel = value;
      });
      return value;
    });

    setState(() {
      if (getOrdersModel.orders.data.isNotEmpty) {
        myOrderDataList.addAll(getOrdersModel.orders.data);
        final ids = myOrderDataList.map((e) => e.id).toSet();
        myOrderDataList.retainWhere((x) => ids.remove(x.id));
      }
      ordersloading = false;
    });

    // print(allMyOrders[0].productoforders);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   homeloading = true;
    // });
    if (userModel == null) {
      setState(() {
        notauser = true;
      });
    } else {
      setState(() {
        notauser = false;
      });
      getMyOrders();
    }

    // HomeService().homeget();
    // firstTime();
    // print('links elhome');
  }

  List myOrders = [
    {
      "imgurl": "images/product1.png",
      "name": "ورد الياسمين",
      "price": "50",
      "quant": "2",
      "code": "PL01",
      "status": "تحت الانشاء"
    },
    {
      "imgurl": "images/product1.png",
      "name": "ورد الياسمين",
      "price": "50",
      "quant": "2",
      "code": "PL01",
      "status": "تحت الانشاء"
    },
    {
      "imgurl": "images/product1.png",
      "name": "ورد الياسمين",
      "price": "50",
      "quant": "2",
      "code": "PL01",
      "status": "تحت الانشاء"
    }
  ];
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
                'طلباتي',
                style: TextStyle(
                    color: Colors.white, fontSize: 21, fontFamily: 'hayah'),
              ),
            ),
            elevation: 0,
            backgroundColor: pinktheme),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              // _loadData();
              print('reached end');
              setState(() {
                if (getOrdersModel.orders.nextPageUrl == null) {
                  print('there\'s no next page');
                } else {
                  print(getOrdersModel.orders.nextPageUrl);
                  GetOrderService()
                      .getListOfOrders(link: getOrdersModel.orders.nextPageUrl)
                      .then((value) {
                    getOrdersModel = value;
                    if (getOrdersModel.orders.data.isNotEmpty) {
                      myOrderDataList.addAll(getOrdersModel.orders.data);
                      final ids = myOrderDataList.map((e) => e.id).toSet();
                      myOrderDataList.retainWhere((x) => ids.remove(x.id));
                    }
                  });
                }
              });
            }
            return true;
          },
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 30, bottom: 10),
                child: notauser
                    ? ListView(
                        children: [
                          Column(
                            children: [
                              Text(
                                'انت لست مسجلا',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'hayah'),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationPage()));
                                },
                                child: Text(
                                  'قم بالتسجيل',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'hayah',
                                      color: pinktheme),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : ordersloading
                        ? SpinKitRing(color: pinktheme)
                        : ListView(
                            children: [
                              myOrderDataList.length == 0
                                  ? Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'لا يوجد لديك طلبات',
                                          style: TextStyle(
                                              fontFamily: 'hayah',
                                              fontSize: 24),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NavigationPage()));
                                          },
                                          child: Text(
                                            'تسوق الان',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: 'hayah',
                                                color: pinktheme,
                                                fontSize: 21),
                                          ),
                                        ),
                                      ],
                                    ))
                                  : ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: myOrderDataList
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyOrderDetails(
                                                                  orderid: e.id,
                                                                )));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      color: const Color(
                                                          0xffffffff),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: const Color(
                                                              0x29000000),
                                                          offset: Offset(0, 1),
                                                          blurRadius: 6,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                flex: 5,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.12,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.12,
                                                                      child: Image(
                                                                          image:
                                                                              NetworkImage('https://specialparty.ga' + e.product.imageHeader)),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset('images/flowersmallsvg.svg'),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Text(
                                                                                  e.product.name,
                                                                                  style: TextStyle(fontFamily: 'hayah', fontSize: 14, color: Colors.black),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset('images/pricesvg.svg'),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Text(
                                                                                  e.totalPrice,
                                                                                  style: TextStyle(fontFamily: 'hayah', fontSize: 13, color: Colors.black),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'س.ر',
                                                                                style: TextStyle(fontFamily: 'hayah', fontSize: 13, color: Colors.black),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset('images/qtsvg.svg'),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                child: Text(
                                                                                  e.productsCount.toString(),
                                                                                  style: TextStyle(fontFamily: 'hayah', fontSize: 13, color: pinktheme),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'باقة زهور',
                                                                                style: TextStyle(fontFamily: 'hayah', fontSize: 13, color: pinktheme),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  e.status
                                                                      .status,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'hayah',
                                                                    fontSize:
                                                                        13,
                                                                    color: const Color(
                                                                        0xffe33e71),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    height:
                                                                        1.3846153846153846,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                            top: 5,
                                                            right: 5,
                                                            child: Text(
                                                              e.product.code,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFB1BACC),
                                                                  fontSize: 9,
                                                                  fontFamily:
                                                                      'hayah'),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                            ],
                          ),
              )),
        ),
      ),
    );
  }
}
