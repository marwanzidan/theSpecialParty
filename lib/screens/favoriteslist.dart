import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/favoritemode.dart';
import 'package:TheSpecialParty/screens/Homepage.dart';
import 'package:TheSpecialParty/screens/productdetails.dart';
import 'package:TheSpecialParty/screens/productslist.dart';
import 'package:TheSpecialParty/screens/registrationpage.dart';
import 'package:TheSpecialParty/services/favoritesservice.dart';

class FavoritesList extends StatefulWidget {
  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  bool notauser = false;
  bool loadingfavs = false;
  TextEditingController productsearchcontroller = TextEditingController();
  final tabs = [
    HomePage(),
    FavoritesList(),
  ];
  getFavorites() async {
    setState(() {
      loadingfavs = true;
    });
    var product = await FavoriteService().getFavorites();
    print(product);

    setState(() {
      favorites = product;
      loadingfavs = false;
    });

    print(favorites);

// setState(() {
//   productsLoading=false;
// });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   homeloading = true;
    // });
    // setState(() {
    //   productsLoading=true;
    // });
    if (userModel == null) {
      setState(() {
        notauser = true;
      });
    } else {
      setState(() {
        notauser = false;
      });
      getFavorites();
    }
  }

  List<FavoriteData> favorites;
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Container(
          width: double.infinity,
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
            color: Color(0xFFF8F8F8),
          ),
          child: loadingfavs
              ? SpinKitRing(
                  color: pinktheme,
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      right: 25, left: 25, top: 10, bottom: 85),
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
                      //           contentPadding:
                      //               EdgeInsets.symmetric(horizontal: 10),
                      //           hintText: 'بحث',
                      //           hintStyle: TextStyle(
                      //               color: pinktheme,
                      //               fontFamily: 'cairoreg',
                      //               fontSize: 15),
                      //           border: OutlineInputBorder(
                      //               //  borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(color: Colors.white)),
                      //           enabledBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(color: Colors.white)),
                      //           focusedBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(color: Colors.white))),
                      //     ),
                      //   ),
                      // ),
                      notauser
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'انت لست مسجلا',
                                    style: TextStyle(
                                      fontFamily: 'hayah',
                                      fontSize: 20,
                                    ),
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
                                          fontFamily: 'hayah',
                                          fontSize: 20,
                                          color: pinktheme),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : favorites.length == 0
                              ? Center(
                                  child: Text(
                                    'لا يوجد لديك اي منتجات مفضلة حتي الان',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'hayah',
                                        fontSize: 16),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 10),
                                  child: GridView.count(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    childAspectRatio: 9 / 12,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30,
                                    children: favorites
                                        .map((e) => ProductItem(
                                              price: e.product.price,
                                              name: e.product.name,
                                              code: e.product.code,
                                              image: e.product.imageHeader,
                                              item: e.product,
                                            ))
                                        .toList()
                                        .where((element) => element.name
                                            .contains(
                                                productsearchcontroller.text))
                                        .toList(),
                                  ),
                                ),
                    ],
                  ),
                )),
    );
  }
}
