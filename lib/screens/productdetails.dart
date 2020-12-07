import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/productmodel.dart';
import 'package:TheSpecialParty/screens/shoppingcart.dart';
import 'package:TheSpecialParty/services/favoritesservice.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({this.productdetails});

  ProductData productdetails;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  bool fav = false;
  int _current = 0;
  List sliderlist = [
    {'img': 'images/NoPath - Copy (19).png'},
    {'img': 'images/NoPath - Copy (19).png'},
    {'img': 'images/NoPath - Copy (19).png'},
  ];
  @override
  void initState() {
    // TODO: implement initState
    print(widget.productdetails.id.toString());
    super.initState();

    // HomeService().homeget();
    // firstTime();
    // print('links elhome');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Image(image: AssetImage('images/productdetails.png')),
              Container(
                child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.55,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) => {
                        setState(() {
                          _current = index;
                        })
                      },
                    ),
                    items: widget.productdetails.images
                        .map((e) => Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://specialparty.ga' + e.image),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                              ],
                            ))
                        .toList()),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.43,
                left: 0,
                right: 0,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.productdetails.images.map((url) {
                        int index = widget.productdetails.images.indexOf(url);
                        return Container(
                          width: _current == index ? 9 : 7,
                          height: _current == index ? 9 : 7,
                          margin:
                              EdgeInsets.only(top: 0.0, bottom: 9.0, left: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                      color: Colors.white),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'images/flowersvg.svg'),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.productdetails.name,
                                                style: TextStyle(
                                                  fontFamily: 'hayah',
                                                  fontSize: 21,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              widget.productdetails.code,
                                              style: TextStyle(
                                                  color: pinktheme,
                                                  fontSize: 14,
                                                  fontFamily: 'hayah'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.productdetails.price,
                                            style: TextStyle(
                                              fontFamily: 'hayah',
                                              fontSize: 21,
                                              color: pinktheme,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'ر.س',
                                          style: TextStyle(
                                            fontFamily: 'hayah',
                                            fontSize: 21,
                                            color: pinktheme,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                widget.productdetails.description,
                                style: TextStyle(
                                    fontFamily: 'hayah',
                                    fontSize: 14,
                                    color: Color(0xFF807D7D)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                            'images/lengthsvg.svg'),
                                        Row(
                                          children: [
                                            Text(
                                              'الارتفاع',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'hayah',
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              widget.productdetails.length,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'hayah',
                                                  color: Colors.black),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SvgPicture.asset('images/widthsvg.svg'),
                                        Row(
                                          children: [
                                            Text(
                                              'العرض',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'hayah',
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              widget.productdetails.width,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'hayah',
                                                  color: Colors.black),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            quantity++;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: pinktheme,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(Icons.add,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          quantity.toString(),
                                          style: TextStyle(
                                              fontFamily: 'hayah',
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (quantity > 1) {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: pinktheme,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(FontAwesomeIcons.minus,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        (double.parse(widget
                                                    .productdetails.price) *
                                                quantity)
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'hayah',
                                            fontSize: 21,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        'ر.س',
                                        style: TextStyle(
                                            fontFamily: 'hayah',
                                            fontSize: 21,
                                            color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (quantity != 0) {
                                            bool found = false;
                                            int index = 0;
                                            setState(() {
                                              for (var item in cart) {
                                                if (item.id ==
                                                    widget.productdetails.id) {
                                                  found = true;
                                                  index = cart.indexOf(item);
                                                  widget.productdetails
                                                      .quantity = item.quantity;
                                                }
                                              }
                                              if (found) {
                                                print(
                                                    'has it: ${widget.productdetails.quantity.toString()}');
                                                setState(() {
                                                  print(widget
                                                      .productdetails.quantity);
                                                  // widget.productdetails.quantity += 1;
                                                  widget.productdetails
                                                          .quantity =
                                                      quantity +
                                                          widget.productdetails
                                                              .quantity;
                                                });
                                                ProductData tempProduct =
                                                    widget.productdetails;
                                                print(json
                                                    .encode(cart.toString()));
                                                cart.removeAt(index);
                                                print(json
                                                    .encode(cart.toString()));
                                                cart.insert(index, tempProduct);
                                                print(json
                                                    .encode(cart.toString()));
                                              } else {
                                                print('new');
                                                widget.productdetails.quantity =
                                                    quantity;
                                                cart.add(widget.productdetails);
                                              }
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NavigationPage(
                                                          currentindex: 1,
                                                        )));
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xffee6886),
                                                  const Color(0xffdf2e6a)
                                                ],
                                              ),
                                            ),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 40),
                                                child: Center(
                                                  child: Text(
                                                    'اضافة الي السلة',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 19,
                                                        fontFamily: 'hayah'),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (userModel == null) {
                                            showToastWidget(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 30.0,
                                                  vertical: 60,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                                  0xFF656565)
                                                              .withOpacity(0.9),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          21))),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.07,
                                                      child: Center(
                                                        child: Text(
                                                            'يجب ان تقوم بالتسجيل من اجل هذة الخاصية',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Sukarbold',
                                                                fontSize: 14)),
                                                      )),
                                                ),
                                              ),
                                              context: context,
                                            );
                                          } else {
                                            setState(() {
                                              widget.productdetails.favorite =
                                                  !widget
                                                      .productdetails.favorite;
                                            });

                                            await FavoriteService()
                                                .postFavorite(
                                                    productid: widget
                                                        .productdetails.id);
                                            showToastWidget(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 30.0,
                                                  vertical: 60,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                                  0xFF656565)
                                                              .withOpacity(0.9),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          21))),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.07,
                                                      child: Center(
                                                        child: Text(
                                                            widget.productdetails
                                                                    .favorite
                                                                ? 'تم اضافة المنتج الي المفضلة'
                                                                : 'تم حذف المنتج من المفضلة',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Sukarbold',
                                                                fontSize: 14)),
                                                      )),
                                                ),
                                              ),
                                              context: context,
                                            );
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              border:
                                                  Border.all(color: pinktheme)),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: !widget
                                                      .productdetails.favorite
                                                  ? Icon(
                                                      FontAwesomeIcons.heart,
                                                      color: pinktheme,
                                                    )
                                                  : Icon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color: pinktheme,
                                                    )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: Colors.white,
                        size: 30,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
