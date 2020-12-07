import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/screens/Homepage.dart';
import 'package:TheSpecialParty/screens/Notifications.dart';
import 'package:TheSpecialParty/screens/aboutus.dart';
import 'package:TheSpecialParty/screens/favoriteslist.dart';
import 'package:TheSpecialParty/screens/loginpage.dart';
import 'package:TheSpecialParty/screens/myorders.dart';
import 'package:TheSpecialParty/screens/shoppingcart.dart';
import 'package:TheSpecialParty/screens/splashscreen.dart';
import 'package:TheSpecialParty/screens/terms_and_conditions.dart';
import 'package:TheSpecialParty/screens/userporfile.dart';
import 'package:TheSpecialParty/services/sharedprefrences.dart';
import 'package:TheSpecialParty/services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({this.currentindex});
  int currentindex = 0;
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
   Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
}
  bool showcustomerservice = false;
  @override
  Widget build(BuildContext context) {
    if (widget.currentindex == null) {
      setState(() {
        widget.currentindex = 0;
      });
    }
    return SafeArea(
      child: Scaffold(
          endDrawer: widget.currentindex == 0
              ? Drawer(
                  child: Scaffold(
                    bottomNavigationBar: showcustomerservice
                        ? BottomAppBar(
                            child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Color(0xFFF8F8F8)),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ShowUpAnimation(
                                  delayStart: Duration(seconds: 0),
                                  animationDuration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  direction: Direction.vertical,
                                  offset: 0.5,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                           SvgPicture.asset('images/flowersvg.svg'),
                                          Text(
                                            'سعيدون بتقديم المساعدة لك',
                                            style: TextStyle(
                                              fontFamily: 'hayah',
                                              fontSize: 16,
                                              color: const Color(0xffe33e71),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                         SvgPicture.asset('images/flowersvg.svg')
                                        ],
                                      ),
                                      Text(
                                        'اختر نوع المساعدة',
                                        style: TextStyle(
                                          fontFamily: 'hayah',
                                          fontSize: 16,
                                          color: const Color(0xff000000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      GestureDetector(
                                        onTap: ()async{
                                          
                                                   _launchInBrowser(links["whatsapp"]);

                                        },
                                                                              child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              child: Image(
                                                  image: AssetImage(
                                                      'images/whatsappcontact.png')),
                                            ),
                                            Text(
                                              'الواتس اب',
                                              style: TextStyle(
                                                fontFamily: 'hayah',
                                                fontSize: 16,
                                                color: const Color(0xff000000),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async{
                                          _launchInBrowser('tel://'+links["phone"]);
                                        },
                                                                              child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              child: Image(
                                                  image: AssetImage(
                                                      'images/phonecontact.png')),
                                            ),
                                            Text(
                                              'الاتصال',
                                              style: TextStyle(
                                                fontFamily: 'hayah',
                                                fontSize: 16,
                                                color: const Color(0xff000000),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                        : SizedBox(),
                    appBar: AppBar(
                        leading: SizedBox(width: 0),
                        actions: [SizedBox(width: 20)],
                        title: Center(
                          child: Text(
                            'الحفلة المميزة',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontFamily: 'hayah'),
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
                                right: 25, left: 25, top: 0, bottom: 30),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ListView(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyOrders()));
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'images/basketsvg.svg'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                'طلباتي',
                                                style: TextStyle(
                                                  fontFamily: 'hayah',
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff000000),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfile()));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.solidUser,
                                                color: pinktheme,
                                                size: 15,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                  'الملف الشخصي',
                                                  style: TextStyle(
                                                    fontFamily: 'hayah',
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0xff000000),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TermsAndConditions()));
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'images/termssvg.svg'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                'الشروط والاحكام',
                                                style: TextStyle(
                                                  fontFamily: 'hayah',
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff000000),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AboutUs()));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons
                                                    .solidInfoCircle,
                                                color: pinktheme,
                                                size: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                  'من نحن',
                                                  style: TextStyle(
                                                    fontFamily: 'hayah',
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0xff000000),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showcustomerservice =
                                                !showcustomerservice;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons
                                                  .solidCommentAltLines,
                                              color: pinktheme,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(
                                                'تواصل مع خدمة العملاء',
                                                style: TextStyle(
                                                  fontFamily: 'hayah',
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff000000),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      userModel == null
                                          ? 
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                              },
                                                                                        child: Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons.signOut,
                                                          color: pinktheme,
                                                          size: 20,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 8),
                                                          child: Text(
                                                            'تسجيل الدخول',
                                                            style: TextStyle(
                                                              fontFamily: 'hayah',
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xff000000),
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                            ),
                                                            textAlign:
                                                                TextAlign.center,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                            ),
                                          )



                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await UserService()
                                                      .logout()
                                                      .then((value) async {
                                                    if (value) {
                                                      SharedPreferences
                                                          sharedPreferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await sharedPreferences
                                                          .clear();
                                                      cart.clear();
                                                      totalprice = 0;
                                                      totalquantity = 0;
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Splashscreen()),
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.signOut,
                                                      color: pinktheme,
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: Text(
                                                        'تسجيل خروج',
                                                        style: TextStyle(
                                                          fontFamily: 'hayah',
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0xff000000),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                 onTap : ()

                                                 async {
                                                   _launchInBrowser(links["instagram"]);

                                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.11,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.11,
                                                    child: SvgPicture.asset(
                                                        'images/instasvg.svg'))),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: GestureDetector(
                                                onTap:()async{
                                                  _launchInBrowser(links["twitter"]);
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    child: SvgPicture.asset(
                                                        'images/twittersvg.svg')),
                                              ),
                                            ),
                                            GestureDetector(
                                               onTap:()async{
                                                  _launchInBrowser(links["snapchat"]);
                                                },
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1,
                                                  child: SvgPicture.asset(
                                                      'images/snapchatsvg.svg')),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: GestureDetector(
                                                 onTap:()async{
                                                  _launchInBrowser(links["gmail"]);
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                    child: SvgPicture.asset(
                                                        'images/gmailsvg.svg')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    left: 20,
                                    child: Image(
                                        image: AssetImage(
                                            'images/drawerstack.png')))
                              ],
                            ))),
                  ),
                )
              : SizedBox(),
          appBar: widget.currentindex == 0
              ? AppBar(
                  automaticallyImplyLeading: false,
                  leading: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notifications()));
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                    ),
                  ),

                  //  actions: [
                  //                     Padding(
                  //                       padding: const EdgeInsets.only(left: 30),
                  //                       child: InkWell(
                  //                   onTap: (){
                  //                    Scaffold.of(context).openEndDrawer();

                  //                   },
                  //                                           child: Icon(
                  //                       FontAwesomeIcons.bars,
                  //                       color: Colors.white,
                  //                       size: 20,
                  //                   ),
                  //                 ),
                  //                     )

                  //  ],
                  title: Center(
                    child: Text(
                      'الحفلة المميزة',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: 'hayah'),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: pinktheme)
              : widget.currentindex == 2
                  ? AppBar(
                      leading: SizedBox(width: 0),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                    widget.currentindex = 0;
                                  });
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
                          'المفضلة',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: 'hayah'),
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: pinktheme)
                  : widget.currentindex == 1
                      ? AppBar(
                          leading: SizedBox(width: 0),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    widget.currentindex = 0;
                                  });
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
                              'سلة الطلبات',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontFamily: 'hayah'),
                            ),
                          ),
                          elevation: 0,
                          backgroundColor: pinktheme)
                      : SizedBox(),
          body: Stack(
            children: [
              widget.currentindex == 0
                  ? HomePage()
                  : widget.currentindex == 1
                      ? ShoppingCart()
                      : widget.currentindex == 2
                          ? FavoritesList()
                          : SizedBox(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 0),
                        blurRadius: 6,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: BottomNavigationBar(
                    selectedItemColor: pinktheme,
                    selectedLabelStyle: TextStyle(
                        fontFamily: 'hayah', fontSize: 13, color: pinktheme),
                    unselectedLabelStyle: TextStyle(
                        fontFamily: 'hayah',
                        fontSize: 13,
                        color: Color(0xff8C9DBE)),
                    backgroundColor: Colors.transparent,
                    currentIndex: widget.currentindex,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    items: [
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                                child: SvgPicture.asset(widget.currentindex == 0
                                    ? 'images/flowersvg.svg'
                                    : 'images/inactiveflowersvg.svg')),
                          ),
                          label: 'الرئيسية'),
                      BottomNavigationBarItem(
                          icon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(widget.currentindex == 1
                                  ? 'images/activecartsvg.svg'
                                  : 'images/inactivecartsvg.svg')),
                          label: 'السلة'),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(FontAwesomeIcons.solidHeart,
                                color: widget.currentindex == 2
                                    ? pinktheme
                                    : Color(0xFFB1BACC)),
                          ),
                          label: 'المفضلة'),
                    ],
                    onTap: (index) {
                      setState(() {
                        widget.currentindex = index;
                      });
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
