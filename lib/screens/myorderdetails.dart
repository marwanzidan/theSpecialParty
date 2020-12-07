import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/getorderdetailsmodel.dart';
import 'package:TheSpecialParty/services/getordersservice.dart';
import 'package:TheSpecialParty/services/orderService.dart';

class MyOrderDetails extends StatefulWidget {
  MyOrderDetails({this.orderid});

  int orderid;
  @override
  _MyOrderDetailsState createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  bool orderdetailsloading = false;
  ShowOrderDetails showOrderDetails = ShowOrderDetails();
  getMyOrdersDetails() async {
    setState(() {
      orderdetailsloading = true;
    });
    showOrderDetails =
        await OrderService().getOrderdetails(id: widget.orderid).then((value) {
      setState(() {
        showOrderDetails = value;
        orderdetailsloading = false;
      });
      print('length..: ${value.order.products.length}');
      return value;
    });

    print(jsonEncode(showOrderDetails));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   homeloading = true;
    // });
    getMyOrdersDetails();

    // HomeService().homeget();
    // firstTime();
    // print('links elhome');
  }

  Map<Order, dynamic> orderdetails = {};

  List orderstatus = [
    {
      "imgurl": "images/notification.png",
      "status": "تم اكتمال الطلب",
      "descp": "عميلنا العزيز تم اكتمال طلبكم وتمت جدولة الموعد"
    },
    {
      "imgurl": "images/notification.png",
      "status": "جاري العمل على طلبكم",
      "descp": "عميلنا العزيز نقوم الان بتجهيز باقة الزهور بكل حب لاجلك"
    },
    {
      "imgurl": "images/notification.png",
      "status": "تم التوصيل",
      "descp": "تم توصيل الطلب , نقدر لكم ثقتكم ونسعد دائما بخدمتكم"
    }
  ];
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
                'تفاصيل الطلب',
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
                  right: 15, left: 15, top: 30, bottom: 10),
              child: orderdetailsloading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitRing(color: pinktheme),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'جاري تحميل تفاصيل الطلب..',
                            style: TextStyle(fontFamily: 'hayah'),
                          ),
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: const Color(0xffffffff),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                   SvgPicture.asset('images/namesvg.svg'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        userModel.user.name.toString(),
                                        style: TextStyle(
                                          fontFamily: 'hayah',
                                          fontSize: 20,
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'رقم الطلب',
                                      style: TextStyle(
                                        fontFamily: 'hayah',
                                        fontSize: 13,
                                        color: pinktheme,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                       SvgPicture.asset('images/orderidsvg.svg'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                            showOrderDetails.order.id
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'hayah',
                                              fontSize: 20,
                                              color: const Color(0xff000000),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: showOrderDetails.order.products
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: const Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(0, 1),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image(
                                                        image: NetworkImage(
                                                            'https://specialparty.ga' +
                                                                e.imageHeader)),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                             SvgPicture.asset('images/flowersmallsvg.svg'),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Text(
                                                                  e.name,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'hayah',
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset('images/pricesvg.svg'),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Text(
                                                                  e.price
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'hayah',
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              Text(
                                                                'س.ر',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'hayah',
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                            SvgPicture.asset('images/qtsvg.svg'),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Text(
                                                                  e.pivot
                                                                      .quantity
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'hayah',
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          pinktheme),
                                                                ),
                                                              ),
                                                              Text(
                                                                'باقة زهور',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'hayah',
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        pinktheme),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                              top: 5,
                                              right: 5,
                                              child: Text(
                                                e.code.toString(),
                                                style: TextStyle(
                                                    color: Color(0xFFB1BACC),
                                                    fontSize: 9,
                                                    fontFamily: 'hayah'),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'تفاصيل الطلب',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 21,
                              color: const Color(0xff0c0101),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: IconStepper.externallyControlled(
                                direction: Axis.vertical,
                                stepReachedAnimationEffect: null,
                                activeStepColor: Colors.white,
                                activeStepBorderColor: Colors.white,
                                steppingEnabled: true,
                                stepColor: Colors.white,
                                scrollingDisabled: true,
                                stepReachedAnimationDuration:
                                    Duration(milliseconds: 0),
                                lineColor: Color(0xFFC9C9C9),
                                lineLength: 80,
                                icons: [
                                  Icon(FontAwesomeIcons.solidCheckCircle,
                                      color: pinktheme),
                                  Icon(
                                    FontAwesomeIcons.solidCheckCircle,
                                    color:
                                       showOrderDetails.order.status.index>1
                                            ? pinktheme
                                            : Color(0xFF9CA1AE),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.solidCheckCircle,
                                    color:
                                       showOrderDetails.order.status.index>3
                                            ? pinktheme
                                            : Color(0xFF9CA1AE),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                  children: orderstatus
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.16,
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0),
                                                                  child: Text(
                                                                    e['status'],
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          12.0),
                                                                  child: Text(
                                                                    e['descp'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                         MediaQuery.of(context).size.height*0.018,
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
                                                      0.16,
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
                          ],
                        )
                      ],
                    ),
            )),
      ),
    );
  }
}
