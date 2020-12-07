import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/createordermodel.dart';
import 'package:TheSpecialParty/screens/paymentmethod.dart';
import 'package:TheSpecialParty/services/userservice.dart';
import 'package:TheSpecialParty/widgets/Maps.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';
import 'package:TheSpecialParty/widgets/customdialog.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

TextEditingController locationmap = TextEditingController();
double longitutde;
double lattitude;

class Country {
  int id;
  String name;

  Country(this.id, this.name);

  static List<Country> getCountries() {
    return <Country>[
      // Country(1, 'جدة'),
      Country(2, 'الرياض'),
      // Country(3, 'الدمام'),
      // Country(4, 'مكة'),
    ];
  }
}

class OrderInfo extends StatefulWidget {
  OrderInfo({
    this.tempproducts,
    this.totalprice,
  });

  List<Products> tempproducts;
  double totalprice;
  String locationname;

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  List cities = [
    {"arabicname": "الرياض"}
  ];

  String city = '';
  TextEditingController sendermail = TextEditingController();

  TextEditingController senderphone = TextEditingController();
  TextEditingController reciverphone = TextEditingController();
  TextEditingController sendername = TextEditingController();
  TextEditingController recivername = TextEditingController();
  TextEditingController senderpassword = TextEditingController();
  TextEditingController cityofgifting = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController messagetext = TextEditingController();
  TextEditingController passwordcodelogincontroller = TextEditingController();
  bool nextpageloading=false;

  bool codeemptyfield = false;
  bool wrongcode = false;
  bool codeloading = false;
  bool registrationloading = false;

  bool emptyregisterdata = false;
  bool savedata = true;
  bool samesenderphone = false;
  bool contactwithphone = false;
  String wrongMessage = '';
  bool enterdata = false;
  List<Country> _countries = Country.getCountries();
  List<DropdownMenuItem<Country>> _dropdownMenuItems;
  Country _selectedCountries;

  List<DropdownMenuItem<Country>> buildDropdownMenuItems(List countries) {
    List<DropdownMenuItem<Country>> items = List();
    for (Country country in countries) {
      items.add(
        DropdownMenuItem(
          value: country,
          child: Text(country.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Country selectedCompany) {
    setState(() {
      _selectedCountries = selectedCompany;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _dropdownMenuItems = buildDropdownMenuItems(_countries);
    _selectedCountries = _dropdownMenuItems[0].value;
    setState(() {
      locationmap = widget.locationname == null
          ? TextEditingController()
          : TextEditingController(text: widget.locationname);
    });
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
                'بيانات الطلب',
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
                  right: 25, left: 25, top: 10, bottom: 30),
              child: ListView(
                children: [
                  userModel != null
                      ? Container()
                      : Column(
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(
                              //     color: pinktheme
                              //   ),
                              //   borderRadius: BorderRadius.circular(10)
                              // ),
                              child: Text(
                                'بيانات المرسل',
                                style: TextStyle(
                                  fontFamily: 'hayah',
                                  fontSize: 19,
                                  color: const Color(0xffe33e71),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            UserInfo(
                              title: 'الاسم',
                              titleicon: FontAwesomeIcons.solidIdCard,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 2),
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10.0),
                                child: TextField(
                                  style: TextStyle(color: Colors.black,
                      fontSize: 18
                        ),
                                  controller: sendername,
                                  cursorColor: pinktheme,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: UserInfo(
                                title: 'رقم الجوال',
                                titleicon: FontAwesomeIcons.solidPhoneAlt,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 2),
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.087,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 1),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.118,
                                    child: TextField(
                                      style: TextStyle(color: Colors.black,
                      fontSize: 18
                        ),
                                      maxLength: 9,
                                      keyboardType: TextInputType.number,
                                      controller: senderphone,
                                      cursorColor: pinktheme,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                'images/ksasvg.svg'),
                                          ),
                                          suffixText: '(966+)',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //       Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 4, horizontal: 2),
                            //         child: Container(
                            //           // decoration: BoxDecoration(
                            //           //     boxShadow: [
                            //           //   BoxShadow(
                            //           //     color: const Color(0x24000000),
                            //           //     offset: Offset(0, 0),
                            //           //     blurRadius: 1,
                            //           //     spreadRadius: 0.1
                            //           //   ),
                            //           // ],
                            //           // ),
                            //           child: TextField(

                            //              maxLength: 9,
                            // keyboardType: TextInputType.number,
                            //             controller: senderphone,
                            //             cursorColor: pinktheme,
                            //             decoration: InputDecoration(
                            //               fillColor: Colors.white,
                            //               filled: true,
                            //                 suffixIcon: Image(
                            //                     image: AssetImage('images/ksa.png')),
                            //                 suffixText: '(966+)',
                            //                 enabledBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10.0),
                            //                     borderSide:
                            //                         BorderSide(color: Colors.white)),
                            //                 focusedBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(10.0),
                            //                     borderSide:
                            //                         BorderSide(color: Colors.white))),
                            //           ),
                            //         ),
                            //       ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 25.0),
                            //   child: UserInfo(
                            //     title: 'الايميل',
                            //     titleicon: FontAwesomeIcons.mailbox,
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 4, horizontal: 2),
                            //   child: Material(
                            //     elevation: 2,
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     child: TextField(
                            //       controller: sendermail,
                            //       cursorColor: pinktheme,
                            //       decoration: InputDecoration(
                            //           enabledBorder: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10.0),
                            //               borderSide:
                            //                   BorderSide(color: Colors.white)),
                            //           focusedBorder: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(10.0),
                            //               borderSide:
                            //                   BorderSide(color: Colors.white))),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: UserInfo(
                                title: 'كلمة المرور',
                                titleicon: FontAwesomeIcons.solidLock,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 2),
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10.0),
                                child: TextField(
                                  style: TextStyle(color: Colors.black,
                      fontSize: 18
                        ),
                                  controller: senderpassword,
                                  obscureText: true,
                                  cursorColor: pinktheme,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide:
                                              BorderSide(color: Colors.white))),
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Switch(
                            //         activeColor: pinktheme,
                            //         value: savedata,
                            //         onChanged: (x)  {
                            //           setState(() {
                            //             savedata = x;
                            //           });
                                     
                            //         }
                            //         ),
                            //     Text(
                            //       'حفظ البيانات',
                            //       style: TextStyle(
                            //         fontFamily: 'hayah',
                            //         fontSize: 14,
                            //         color: pinktheme,
                            //         fontWeight: FontWeight.w700,
                            //       ),
                            //       textAlign: TextAlign.center,
                            //     )
                            //   ],
                            // ),
                            registrationloading
                                ? SpinKitRing(
                                    color: pinktheme,
                                    size: 20,
                                  )
                                : SizedBox(),
                            wrongMessage.isNotEmpty
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          wrongMessage,
                                          style: TextStyle(
                                              fontFamily: 'hayah',
                                              color: Colors.red),
                                        ),
                                      ],
                                    ))
                                : SizedBox(),
                            emptyregisterdata
                                ? Row(
                                    children: [
                                      Text(
                                        'من فضلك ادخل جميع البيانات',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'hayah'),
                                      )
                                    ],
                                  )
                                : SizedBox(),
                            Text(
                              'تعتبر البيانات المدخلة أعلاه بمثابة انشاء حساب جديد\nفي الحفلة المميزة',
                              style: TextStyle(
                                fontFamily: 'hayah',
                                fontSize: 12,
                                color: const Color(0xffb1bacc),
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'بيانات المرسل له',
                      style: TextStyle(
                        fontFamily: 'hayah',
                        fontSize: 20,
                        color: const Color(0xffe33e71),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  UserInfo(
                      title: 'اسم المرسل له (اختياري)',
                      titleicon: FontAwesomeIcons.solidUser),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black,
                      fontSize: 18
                        ),
                        controller: recivername,
                        cursorColor: pinktheme,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: UserInfo(
                            title: 'رقم جوال المرسل له',
                            titleicon: FontAwesomeIcons.solidPhoneAlt,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        samesenderphone = !samesenderphone;
                                        samesenderphone
                                            ? reciverphone =
                                                TextEditingController(
                                                    text: userModel.user.phone
                                                        .substring(3))
                                            : reciverphone =
                                                TextEditingController();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                        color: const Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(0, 1),
                                            blurRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: samesenderphone
                                              ? Icon(
                                                  FontAwesomeIcons.solidCircle,
                                                  color: pinktheme,
                                                  size: 10,
                                                )
                                              : SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'نفس جوال المرسل',
                                      style: TextStyle(
                                        fontFamily: 'hayah',
                                        fontSize: 11,
                                        color: const Color(0xffe33e71),
                                        fontWeight: FontWeight.w700,
                                        height: 1.4545454545454546,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.087,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.118,
                          child: TextField(
                            style: TextStyle(color: Colors.black,
                      fontSize: 18
                        ),
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            controller: reciverphone,
                            cursorColor: pinktheme,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset('images/ksasvg.svg'),
                                ),
                                suffixText: '(966+)',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  //   child: Material(
                  //     elevation: 2,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     child: TextField(
                  //       // maxLength: 12,
                  //       keyboardType: TextInputType.number,
                  //       controller: reciverphone,
                  //       cursorColor: pinktheme,
                  //       decoration: InputDecoration(
                  //           suffixIcon:
                  //               Image(image: AssetImage('images/ksa.png')),
                  //           suffixText: samesenderphone ? "" : '(966+)',
                  //           enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10.0),
                  //               borderSide: BorderSide(color: Colors.white)),
                  //           focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10.0),
                  //               borderSide: BorderSide(color: Colors.white))),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: UserInfo(
                        title: 'مدينة الاهداء',
                        titleicon: FontAwesomeIcons.solidMapMarkerAlt),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: TextStyle(
                                    fontFamily: 'hayah',
                                    color: Colors.black,
                                    fontSize: 16),
                                value: _selectedCountries,
                                items: _dropdownMenuItems,
                                onChanged: onChangeDropdownItem,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 25.0),
                  //   child: UserInfo(
                  //       title: 'مدينة الاهداء',
                  //       titleicon: FontAwesomeIcons.solidMapMarkerAlt),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  //   child: Material(
                  //     elevation: 2,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     child: TextField(
                  //       controller: cityofgifting,
                  //       cursorColor: pinktheme,
                  //       decoration: InputDecoration(
                  //           enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10.0),
                  //               borderSide: BorderSide(color: Colors.white)),
                  //           focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10.0),
                  //               borderSide: BorderSide(color: Colors.white))),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: UserInfo(
                                title: 'موقع المرسل اليه',
                                titleicon: FontAwesomeIcons.solidMapMarkerAlt),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          contactwithphone = !contactwithphone;
                                          if (contactwithphone) {
                                            locationmap.clear();
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                          color: const Color(0xffffffff),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x29000000),
                                              offset: Offset(0, 1),
                                              blurRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: contactwithphone
                                                ? Icon(
                                                    FontAwesomeIcons
                                                        .solidCircle,
                                                    color: pinktheme,
                                                    size: 10,
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                    width: 10,
                                                  )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        'يرجى التواصل عبر الجوال',
                                        style: TextStyle(
                                          fontFamily: 'hayah',
                                          fontSize: 11,
                                          color: const Color(0xffe33e71),
                                          fontWeight: FontWeight.w700,
                                          height: 1.4545454545454546,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 1),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapsPikerPage()));
                          },
                          child: TextField(
                            enabled: contactwithphone ? true : false,
                            readOnly: contactwithphone ? true : false,
                            cursorColor: pinktheme,
                            controller: locationmap,
                            decoration: InputDecoration(
                                fillColor: contactwithphone
                                    ? Colors.grey.withOpacity(0.3)
                                    : Colors.white,
                                filled: true,
                                suffixIcon: Icon(
                                  FontAwesomeIcons.solidMapPin,
                                  color: pinktheme,
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: UserInfo(
                        title: 'الحي(اختياري)',
                        titleicon: FontAwesomeIcons.lightMapMarkerAlt),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black,
                      fontSize: 18
                        ),
                        controller: district,
                        cursorColor: pinktheme,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 5),
                    child: UserInfo(
                        title: 'نص الرسالة علي الكارت(اختياري)',
                        titleicon: FontAwesomeIcons.solidCommentAlt),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        style: TextStyle(color: Colors.black,
                      fontSize: 18
                        ),
                        controller: messagetext,
                        cursorColor: pinktheme,
                        maxLines: 5,
                        minLines: 5,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                  ),
                  enterdata
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'من فضلك ادخل البيانات المطلوبة',
                            style: TextStyle(
                                fontFamily: 'hayah',
                                fontSize: 16,
                                color: Colors.red),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                      onTap: () async{
                        print(_selectedCountries.name);

                        if (userModel == null) {
                        if(!savedata){
                            showToastWidget(
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 60,
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFF656565).withOpacity(0.9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(21))),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                            'يجب ان تقوم بالتسجيل عن طريق \n حفظ البيانات من اجل هذة الخاصية',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Sukarbold',
                                                fontSize: 14)),
                                      ),
                                    )),
                              ),
                            ),
                            context: context,
                          );
                        }
                        else
                           if (reciverphone.text.isNotEmpty &&
                              _selectedCountries.name.isNotEmpty
                              &&senderphone.text.isNotEmpty
                              &&senderpassword.text.isNotEmpty&&
                              sendername.text.isNotEmpty
                              
                              ){

                                setState(() {
                                  nextpageloading=true;
                                });
                                var reginfo = await UserService()
                                            .registration(
                                                name: sendername.text,
                                                // email: sendermail.text,
                                                password: senderpassword.text,
                                                phone:
                                                    "966" + senderphone.text);
                                        setState(() {
                                          nextpageloading=false;
                                         
                                        });
                                        if (reginfo == 'true') {
                                          setState(() {
                                            wrongMessage = '';
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return WillPopScope(
                                                  onWillPop: (){
                                                    setState(() {
                                                      userModel=null;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                                                                  child: StatefulBuilder(builder:
                                                      (context, setState) {
                                                    return Material(
                                                      color: Colors.grey,
                                                      child: CustomAlertDialog(
                                                        content: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.36,
                                                          child: Center(
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'التحقق من رقم الجوال',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'hayah',
                                                                      fontSize:
                                                                          16,
                                                                      color: const Color(
                                                                          0xffe33e71),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            12),
                                                                    child: Text(
                                                                      'أدخل الكود المرسل لك على الهاتف',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'hayah',
                                                                        fontSize:
                                                                            14,
                                                                        color: const Color(
                                                                            0xff919191),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                  PinInputTextField(
                                                                    controller:
                                                                        passwordcodelogincontroller,
                                                                    pinLength: 4,
                                                                    decoration:
                                                                        BoxLooseDecoration(
                                                                      bgColorBuilder: PinListenColorBuilder(
                                                                          Colors
                                                                              .grey
                                                                              .withOpacity(
                                                                                  0.5),
                                                                          Colors
                                                                              .grey
                                                                              .withOpacity(0.5)),
                                                                      strokeColorBuilder: PinListenColorBuilder(
                                                                          Color(
                                                                              0xFFF8F8F8),
                                                                          Color(
                                                                              0xFFF8F8F8)),
                                                                    ),
                                                                  ),
                                                                  codeemptyfield
                                                                      ? Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  8),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                'من فضلك ادخل البيانات',
                                                                                style: TextStyle(fontFamily: 'hayah', color: Colors.red),
                                                                              ),
                                                                            ],
                                                                          ))
                                                                      : SizedBox(),
                                                                  wrongcode
                                                                      ? Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  8),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                'الكود غير صحيح',
                                                                                style: TextStyle(fontFamily: 'hayah', color: Colors.red),
                                                                              ),
                                                                            ],
                                                                          ))
                                                                      : SizedBox(),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            20),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (passwordcodelogincontroller
                                                                            .text
                                                                            .isEmpty) {
                                                                          setState(
                                                                              () {
                                                                            codeemptyfield =
                                                                                true;
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            codeemptyfield =
                                                                                false;
                                                                            codeloading =
                                                                                true;
                                                                          });

                                                                          var coderight =
                                                                              await UserService().verifyCode(code: passwordcodelogincontroller.text);
                                                                          setState(
                                                                              () {
                                                                            codeloading =
                                                                                false;
                                                                          });

                                                                          if (coderight["massage"] ==
                                                                              "Successfully") {
                                                                            setState(
                                                                                () {
                                                                              wrongcode =
                                                                                  false;
                                                                            });

                                                                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentMethod(
                                          tempproducts: widget.tempproducts,
                                          reciverphone:
                                              '966' + reciverphone.text,
                                          totalprice: widget.totalprice,
                                          longitude: longitutde,
                                          latitude: lattitude,
                                          cityofgifting:
                                              _selectedCountries.name,
                                          district: district.text,
                                          messgtext: messagetext.text,
                                          recivername: recivername.text,
                                        )));
                                                                          } else {
                                                                            setState(
                                                                                () {
                                                                              wrongcode =
                                                                                  true;
                                                                            });
                                                                          }
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(12.0),
                                                                            gradient:
                                                                                LinearGradient(
                                                                              colors: [
                                                                                const Color(0xffee6886),
                                                                                const Color(0xffdf2e6a)
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          child: Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                                                                              child: Center(
                                                                                child: codeloading
                                                                                    ? SpinKitRing(
                                                                                        color: Colors.white,
                                                                                        size: 30,
                                                                                      )
                                                                                    : Text(
                                                                                        'تأكيد',
                                                                                        style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'hayah'),
                                                                                      ),
                                                                              ))),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                );
                                              });
                                        } else if (reginfo['error']['phone']
                                                .toString() ==
                                            '[صيغة الهاتف .غير صحيحة.]') {
                                          setState(() {
                                            wrongMessage =
                                                'صيغة الهاتف غير صحيحة';
                                          });
                                        } else if (reginfo['error']['email']
                                                .toString() ==
                                            '[يجب أن يكون البريد الالكتروني عنوان بريد إلكتروني صحيح البُنية.]') {
                                          setState(() {
                                            wrongMessage =
                                                'صيغة البريد الاكتروني غير صحيحة';
                                          });
                                        } else if (reginfo['error']['email']
                                                    .toString() ==
                                                '[قيمة البريد الالكتروني مُستخدمة من قبل.]' &&
                                            reginfo['error']['phone']
                                                    .toString() ==
                                                '[قيمة الهاتف مُستخدمة من قبل.]') {
                                          setState(() {
                                            wrongMessage =
                                                'البريد الاكتروني وقيمة الهاتف مستخدمين من قبل';
                                          });
                                          print(
                                              'use anothermail and another phone');
                                        } else if (reginfo['error']['email']
                                                .toString() ==
                                            '[قيمة البريد الالكتروني مُستخدمة من قبل.]') {
                                          setState(() {
                                            wrongMessage =
                                                'قيمة البريد الالكتروني مُستخدمة من قبل';
                                          });
                                          print('use another mail');
                                        } else {
                                          setState(() {
                                            wrongMessage =
                                                'قيمة الهاتف مُستخدمة من قبل';
                                          });
                                          print('use another phone');
                                        }
                                      } 



                              
                        
                              else{
                                setState(() {
                                  enterdata=true;
                                });
                              }

                        
                        }
                        
                         else if (reciverphone.text.isNotEmpty &&
                              _selectedCountries.name.isNotEmpty
                              
                              ) {
                            print(reciverphone.text);
                            setState(() {
                              enterdata = false;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentMethod(
                                          tempproducts: widget.tempproducts,
                                          reciverphone:
                                              '966' + reciverphone.text,
                                          totalprice: widget.totalprice,
                                          longitude: longitutde,
                                          latitude: lattitude,
                                          cityofgifting:
                                              _selectedCountries.name,
                                          district: district.text,
                                          messgtext: messagetext.text,
                                          recivername: recivername.text,
                                        )));
                          } else {
                            print(cityofgifting.text);
                            print(reciverphone.text);
                            setState(() {
                              enterdata = true;
                            });
                          }
                        
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
                                  vertical: 15, horizontal: 0),
                              child: Center(
                                child: 
                                nextpageloading?
                                SpinKitRing(color: Colors.white,
                                size: 30,
                                ):
                                Text(
                                  'تأكيد عملية الشراء',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'hayah'),
                                ),
                              ))),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  UserInfo({this.title, this.titleicon});

  String title;
  IconData titleicon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
                  child: Icon(
            titleicon,
            color: pinktheme,
            size: 20,
          ),
        ),
        Expanded(
          flex: 15,
                  child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'hayah',
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
             
            ),
          ),
        )
      ],
    );
  }
}




















//  if (sendername.text.isNotEmpty &&
//                                           senderphone.text.isNotEmpty &&
//                                           senderpassword.text.isNotEmpty) {
//                                         setState(() {
//                                           emptyregisterdata = false;
//                                           registrationloading = true;
//                                         });
//                                         var reginfo = await UserService()
//                                             .registration(
//                                                 name: sendername.text,
//                                                 // email: sendermail.text,
//                                                 password: senderpassword.text,
//                                                 phone:
//                                                     "966" + senderphone.text);
//                                         setState(() {
//                                           registrationloading = false;
//                                         });
//                                         if (reginfo == 'true') {
//                                           setState(() {
//                                             wrongMessage = '';
//                                           });
//                                           showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return StatefulBuilder(builder:
//                                                     (context, setState) {
//                                                   return Material(
//                                                     color: Colors.grey,
//                                                     child: CustomAlertDialog(
//                                                       content: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             0.7,
//                                                         height: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .height *
//                                                             0.36,
//                                                         child: Center(
//                                                           child:
//                                                               SingleChildScrollView(
//                                                             child: Column(
//                                                               children: [
//                                                                 Text(
//                                                                   'التحقق من رقم الجوال',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontFamily:
//                                                                         'hayah',
//                                                                     fontSize:
//                                                                         16,
//                                                                     color: const Color(
//                                                                         0xffe33e71),
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w700,
//                                                                   ),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                 ),
//                                                                 Padding(
//                                                                   padding: const EdgeInsets
//                                                                           .symmetric(
//                                                                       vertical:
//                                                                           12),
//                                                                   child: Text(
//                                                                     'أدخل الكود المرسل لك على الهاتف',
//                                                                     style:
//                                                                         TextStyle(
//                                                                       fontFamily:
//                                                                           'hayah',
//                                                                       fontSize:
//                                                                           14,
//                                                                       color: const Color(
//                                                                           0xff919191),
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700,
//                                                                     ),
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                   ),
//                                                                 ),
//                                                                 PinInputTextField(
//                                                                   controller:
//                                                                       passwordcodelogincontroller,
//                                                                   pinLength: 4,
//                                                                   decoration:
//                                                                       BoxLooseDecoration(
//                                                                     bgColorBuilder: PinListenColorBuilder(
//                                                                         Colors
//                                                                             .grey
//                                                                             .withOpacity(
//                                                                                 0.5),
//                                                                         Colors
//                                                                             .grey
//                                                                             .withOpacity(0.5)),
//                                                                     strokeColorBuilder: PinListenColorBuilder(
//                                                                         Color(
//                                                                             0xFFF8F8F8),
//                                                                         Color(
//                                                                             0xFFF8F8F8)),
//                                                                   ),
//                                                                 ),
//                                                                 codeemptyfield
//                                                                     ? Padding(
//                                                                         padding: const EdgeInsets.symmetric(
//                                                                             vertical:
//                                                                                 8),
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               'من فضلك ادخل البيانات',
//                                                                               style: TextStyle(fontFamily: 'hayah', color: Colors.red),
//                                                                             ),
//                                                                           ],
//                                                                         ))
//                                                                     : SizedBox(),
//                                                                 wrongcode
//                                                                     ? Padding(
//                                                                         padding: const EdgeInsets.symmetric(
//                                                                             vertical:
//                                                                                 8),
//                                                                         child:
//                                                                             Row(
//                                                                           children: [
//                                                                             Text(
//                                                                               'الكود غير صحيح',
//                                                                               style: TextStyle(fontFamily: 'hayah', color: Colors.red),
//                                                                             ),
//                                                                           ],
//                                                                         ))
//                                                                     : SizedBox(),
//                                                                 Padding(
//                                                                   padding: const EdgeInsets
//                                                                           .symmetric(
//                                                                       vertical:
//                                                                           20),
//                                                                   child:
//                                                                       GestureDetector(
//                                                                     onTap:
//                                                                         () async {
//                                                                       if (passwordcodelogincontroller
//                                                                           .text
//                                                                           .isEmpty) {
//                                                                         setState(
//                                                                             () {
//                                                                           codeemptyfield =
//                                                                               true;
//                                                                         });
//                                                                       } else {
//                                                                         setState(
//                                                                             () {
//                                                                           codeemptyfield =
//                                                                               false;
//                                                                           codeloading =
//                                                                               true;
//                                                                         });

//                                                                         var coderight =
//                                                                             await UserService().verifyCode(code: passwordcodelogincontroller.text);
//                                                                         setState(
//                                                                             () {
//                                                                           codeloading =
//                                                                               false;
//                                                                         });

//                                                                         if (coderight["massage"] ==
//                                                                             "Successfully") {
//                                                                           setState(
//                                                                               () {
//                                                                             wrongcode =
//                                                                                 false;
//                                                                           });
//                                                                           // Navigator.pushReplacement(
//                                                                           //     context,
//                                                                           //     MaterialPageRoute(
//                                                                           //         builder:
//                                                                           //             (context) =>
//                                                                           //                 OrderInfo()));
//                                                                         } else {
//                                                                           setState(
//                                                                               () {
//                                                                             wrongcode =
//                                                                                 true;
//                                                                           });
//                                                                         }
//                                                                       }
//                                                                     },
//                                                                     child: Container(
//                                                                         decoration: BoxDecoration(
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(12.0),
//                                                                           gradient:
//                                                                               LinearGradient(
//                                                                             colors: [
//                                                                               const Color(0xffee6886),
//                                                                               const Color(0xffdf2e6a)
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                         child: Padding(
//                                                                             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
//                                                                             child: Center(
//                                                                               child: codeloading
//                                                                                   ? SpinKitRing(
//                                                                                       color: Colors.white,
//                                                                                       size: 30,
//                                                                                     )
//                                                                                   : Text(
//                                                                                       'تأكيد',
//                                                                                       style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'hayah'),
//                                                                                     ),
//                                                                             ))),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 });
//                                               });
//                                         } else if (reginfo['error']['phone']
//                                                 .toString() ==
//                                             '[صيغة الهاتف .غير صحيحة.]') {
//                                           setState(() {
//                                             wrongMessage =
//                                                 'صيغة الهاتف غير صحيحة';
//                                           });
//                                         } else if (reginfo['error']['email']
//                                                 .toString() ==
//                                             '[يجب أن يكون البريد الالكتروني عنوان بريد إلكتروني صحيح البُنية.]') {
//                                           setState(() {
//                                             wrongMessage =
//                                                 'صيغة البريد الاكتروني غير صحيحة';
//                                           });
//                                         } else if (reginfo['error']['email']
//                                                     .toString() ==
//                                                 '[قيمة البريد الالكتروني مُستخدمة من قبل.]' &&
//                                             reginfo['error']['phone']
//                                                     .toString() ==
//                                                 '[قيمة الهاتف مُستخدمة من قبل.]') {
//                                           setState(() {
//                                             wrongMessage =
//                                                 'البريد الاكتروني وقيمة الهاتف مستخدمين من قبل';
//                                           });
//                                           print(
//                                               'use anothermail and another phone');
//                                         } else if (reginfo['error']['email']
//                                                 .toString() ==
//                                             '[قيمة البريد الالكتروني مُستخدمة من قبل.]') {
//                                           setState(() {
//                                             wrongMessage =
//                                                 'قيمة البريد الالكتروني مُستخدمة من قبل';
//                                           });
//                                           print('use another mail');
//                                         } else {
//                                           setState(() {
//                                             wrongMessage =
//                                                 'قيمة الهاتف مُستخدمة من قبل';
//                                           });
//                                           print('use another phone');
//                                         }
//                                       } else {
//                                         setState(() {
//                                           emptyregisterdata = true;
//                                         });
//                                       }