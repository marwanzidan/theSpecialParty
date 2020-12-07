import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/models/createordermodel.dart';
import 'package:TheSpecialParty/models/productmodel.dart';
import 'package:TheSpecialParty/screens/orderinfo.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';

List<ProductData> cart = [];
int totalquantity = 0;
double totalprice = 0;

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Products> temproducts = [];

  @override
  void initState() {
    super.initState();
    for (var item in cart) {
      setState(() {
        item.deletebar = false;
      });
    }
    totalprice = 0;

    for (var i = 0; i < cart.length; i++) {
      // temproducts.add(Products(
      //     quantity: cart[i].quantity.toString(),
      //     productId: cart[i].id.toString()));

      totalprice += (double.parse(cart[i].price) * cart[i].quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        // appBar: AppBar(
        //     leading: SizedBox(width: 0),
        //     actions: [
        //       Padding(
        //         padding: const EdgeInsets.only(left: 30),
        //         child: InkWell(
        //           onTap: () {
        //             Navigator.pop(context);
        //           },
        //           child: Icon(
        //             FontAwesomeIcons.chevronLeft,
        //             color: Colors.white,
        //             size: 20,
        //           ),
        //         ),
        //       )
        //     ],
        //     title: Center(
        //       child: Text(
        //         'سلة الطلبات',
        //         style: TextStyle(
        //             color: Colors.white, fontSize: 21, fontFamily: 'hayah'),
        //       ),
        //     ),
        //     elevation: 0,
        //     backgroundColor: pinktheme),
        body: Container(
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
                  right: 15, left: 15, top: 30, bottom: 90),
              child: ListView(
                children: [
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: cart
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: GestureDetector(
                                // onHorizontalDragUpdate: (details){
                                //   if(details.primaryDelta>0){
                                //     print('swipped');
                                //    setState(() {
                                //      e.deletebar=true;

                                //    });
                                //   }
                                //   else{
                                //     setState(() {
                                //       e.deletebar=false;

                                //     });
                                //   }

                                // },

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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
                                                      image: NetworkImage(
                                                          'https://specialparty.ga' +
                                                              e.imageHeader)),
                                                ),
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
                                                          SvgPicture.asset(
                                                              'images/flowersmallsvg.svg'),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Text(
                                                              e.name,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'hayah',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              'images/pricesvg.svg'),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Text(
                                                              e.price,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'hayah',
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          Text(
                                                            'س.ر',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'hayah',
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              'images/qtsvg.svg'),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Text(
                                                              e.quantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'hayah',
                                                                  fontSize: 13,
                                                                  color:
                                                                      pinktheme),
                                                            ),
                                                          ),
                                                          Text(
                                                            'باقة زهور',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'hayah',
                                                                fontSize: 13,
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
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            e.quantity++;
                                                            totalprice +=
                                                                double.parse(
                                                                    e.price);
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color: pinktheme),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .solidPlus,
                                                              color:
                                                                  Colors.white,
                                                              size: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        e.quantity.toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'hayah'),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (e.quantity > 1) {
                                                            setState(() {
                                                              e.quantity--;
                                                              totalprice -=
                                                                  double.parse(
                                                                      e.price);
                                                            });
                                                          }
                                                        },
                                                        child: e.quantity == 1
                                                            ? Container()
                                                            : Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                7),
                                                                    color:
                                                                        pinktheme),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Icon(
                                                                    FontAwesomeIcons
                                                                        .minus,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 12,
                                                                  ),
                                                                ),
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        totalprice -=
                                                            double.parse(e
                                                                    .quantity
                                                                    .toString()) *
                                                                double.parse(
                                                                    e.price);
                                                        cart.remove(e);
                                                      });
                                                    },
                                                    child: Icon(
                                                      FontAwesomeIcons.trashAlt,
                                                      size: 20,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Text(
                                            e.code,
                                            style: TextStyle(
                                                color: Color(0xFFB1BACC),
                                                fontSize: 11,
                                                fontFamily: 'hayah'),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  cart.isEmpty
                      ? Center(
                          child: Text(
                            'لا يوجد اي منتجات في السلة',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'hayah',
                                fontSize: 20),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تكلفة المنتجات',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'hayah',
                                        fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text(
                                          totalprice.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'hayah',
                                              fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        'ريال',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'hayah',
                                            fontSize: 15),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تكلفة التوصيل',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'hayah',
                                        fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'مجاني',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'hayah',
                                            fontSize: 15),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            FDottedLine(
                              color: Colors.grey.withOpacity(0.4),
                              width: MediaQuery.of(context).size.width * 0.7,
                              strokeWidth: 1.0,
                              dottedLength: 3.0,
                              space: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'المجموع الكلي',
                                    style: TextStyle(
                                        color: pinktheme,
                                        fontFamily: 'hayah',
                                        fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text(
                                          totalprice.toString(),
                                          style: TextStyle(
                                              color: pinktheme,
                                              fontFamily: 'hayah',
                                              fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        'ريال',
                                        style: TextStyle(
                                            color: pinktheme,
                                            fontFamily: 'hayah',
                                            fontSize: 15),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NavigationPage()));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.grey.withOpacity(0.6)),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 0),
                                        child: Center(
                                          child: Text(
                                            'اضافة طلب اخر',
                                            style: TextStyle(
                                                color: pinktheme,
                                                fontSize: 16,
                                                fontFamily: 'hayah'),
                                          ),
                                        ))),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderInfo(
                                              tempproducts: temproducts,
                                              totalprice: totalprice,
                                            )));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xffee6886),
                                        const Color(0xffdf2e6a)
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 0),
                                      child: Center(
                                        child: Text(
                                          'اطلب الان',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'hayah'),
                                        ),
                                      ))),
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
