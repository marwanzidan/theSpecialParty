import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/models/productmodel.dart';
import 'package:TheSpecialParty/screens/Homepage.dart';
import 'package:TheSpecialParty/screens/favoriteslist.dart';
import 'package:TheSpecialParty/screens/productdetails.dart';
import 'package:TheSpecialParty/screens/productslist.dart';
import 'package:TheSpecialParty/services/productservice.dart';

class ProductsList extends StatefulWidget {
  ProductsList({this.pagetitle, this.id});
  String pagetitle;
  int id;

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  GetCategoryDetails getCategoryDetails = GetCategoryDetails();
  bool productsLoading = false;
  TextEditingController productsearchcontroller = TextEditingController();
  final tabs = [
    HomePage(),
    FavoritesList(),
  ];

  getProducts() async {
    getCategoryDetails = await Productservice()
        .getListOfProducts(
            widget.id,
            getCategoryDetails.products == null
                ? null
                : getCategoryDetails.products.nextPageUrl)
        .then((value) {
      print('value');
      print(json.encode(value));
      setState(() {
        if (value.products != null && value.products.data.isNotEmpty) {
          productsList.addAll(value.products.data);
          final ids = productsList.map((e) => e.id).toSet();
          productsList.retainWhere((x) => ids.remove(x.id));
        }
        getCategoryDetails = value;
        productsLoading = false;
      });
      return value;
    });
  }

  List products = [
    {
      'imgurl': 'images/product1.png',
      'name': 'الياسمين',
      'code': 'sp/01',
      'price': '50'
    },
    {
      'imgurl': 'images/product1.png',
      'name': 'الياسمين',
      'code': 'sp/01',
      'price': '50'
    },
    {
      'imgurl': 'images/product1.png',
      'name': 'الياسمين',
      'code': 'sp/01',
      'price': '50'
    },
    {
      'imgurl': 'images/product1.png',
      'name': 'الياسمين',
      'code': 'sp/01',
      'price': '50'
    },
    {
      'imgurl': 'images/product1.png',
      'name': 'الياسمين',
      'code': 'sp/01',
      'price': '50'
    }
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   homeloading = true;
    // });
    setState(() {
      productsLoading = true;
    });
    getProducts();

    // HomeService().homeget();
    // firstTime();
    // print('links elhome');
  }

  List<ProductData> productsList = [];
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
                widget.pagetitle,
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
                  right: 25, left: 25, top: 30, bottom: 20),
              child: productsLoading
                  ? SpinKitRing(color: pinktheme)
                  : productsList.length == 0
                      ? Center(
                          child: Text(
                            'لم يتم إضافة منتجات بعد في هذا التصنيف',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'hayah',
                                fontSize: 20),
                          ),
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              // _loadData();
                              print('reached end');
                              setState(() {
                                if (getCategoryDetails.products.nextPageUrl ==
                                    null) {
                                  print('there\'s no next page');
                                } else {
                                  getProducts();
                                }
                              });
                            }
                            return true;
                          },
                          child: ListView(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Material(
                              //     elevation: 4,
                              //     borderRadius: BorderRadius.circular(10),
                              //     child: TextField(
                              //       onChanged: (String value) {
                              //         setState(() {
                              //           productsearchcontroller == value;
                              //         });
                              //       },
                              //       controller: productsearchcontroller,
                              //       cursorColor: pinktheme,
                              //       style: TextStyle(color: pinktheme),
                              //       textAlign: TextAlign.center,
                              //       decoration: InputDecoration(
                              //           prefixIcon: Icon(
                              //             Icons.search,
                              //             color: pinktheme,
                              //           ),
                              //           contentPadding: EdgeInsets.symmetric(
                              //               horizontal: 10),
                              //           hintText: 'بحث',
                              //           hintStyle: TextStyle(
                              //               color: pinktheme,
                              //               fontFamily: 'cairoreg',
                              //               fontSize: 15),
                              //           border: OutlineInputBorder(
                              //               //  borderRadius: BorderRadius.circular(10),
                              //               borderSide: BorderSide(
                              //                   color: Colors.white)),
                              //           enabledBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               borderSide: BorderSide(
                              //                   color: Colors.white)),
                              //           focusedBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               borderSide: BorderSide(
                              //                   color: Colors.white))),
                              //     ),
                              //   ),
                              // ),

                              //                     GridView.builder(
                              //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
                              //     itemBuilder: (BuildContext context, int index) {
                              //       return  ProductItem(
                              //                             price: products[index]['price'],
                              //                             name: products[index]['name'],
                              //                             code: products[index]['code'],
                              //                             image: products[index]['imgurl'],
                              //                           );
                              //     },
                              // ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 10),
                                child: GridView.count(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  childAspectRatio: 9 / 12,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                  children: productsList
                                      .map((e) => ProductItem(
                                            price: e.price,
                                            name: e.name,
                                            code: e.code,
                                            image: e.imageHeader,
                                            item: e,
                                          ))
                                      .toList()
                                      .where((element) => element.name.contains(
                                          productsearchcontroller.text))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
            )),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem({this.code, this.name, this.price, this.image, this.item});

  final String name;
  String code;
  String price;
  String image;
  var item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.0),
          color: const Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 1),
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      code,
                      style: TextStyle(
                          color: Color(0xFFB1BACC),
                          fontSize: MediaQuery.of(context).size.width*0.031,
                          fontFamily: 'hayah'),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  // width: MediaQuery.of(context).size.width*0.25,
                  // height: MediaQuery.of(context).size.width*0.25,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(e['imgurl'],),
                  //     fit: BoxFit.fill
                  //   )
                  // ),
                  child: Image(
                      image: NetworkImage(
                    'https://specialparty.ga' + image,
                  )),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontFamily: 'hayah',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.033,
                                  color: Colors.black),
                            ),
                            Row(
                              children: [
                                Text(
                                  price,
                                  style: TextStyle(
                                      fontFamily: 'hayah',
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.031,
                                      color: pinktheme),
                                ),
                                Text(
                                  '  ر.س',
                                  style: TextStyle(
                                      fontFamily: 'hayah',
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.031,
                                      color: pinktheme),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                          productdetails: item,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: pinktheme),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.solidPlus,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
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
    );
  }
}
