import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/models/couponmodel.dart';
import 'package:TheSpecialParty/models/createordermodel.dart';
import 'package:TheSpecialParty/screens/shoppingcart.dart';
import 'package:TheSpecialParty/services/couponservice.dart';
import 'package:TheSpecialParty/services/orderService.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';
import 'package:TheSpecialParty/widgets/customdialog.dart';
import 'package:TheSpecialParty/widgets/webview.dart';

_PaymentMethodState _paymentMethodState;

class PaymentMethod extends StatefulWidget {
  PaymentMethod(
      {this.recivername,
      this.reciverphone,
      this.cityofgifting,
      this.latitude,
      this.longitude,
      this.district,
      this.messgtext,
      this.tempproducts,
      this.totalprice});

  String recivername;
  String reciverphone;
  String cityofgifting;
  double longitude;
  double latitude;
  String district;
  String messgtext;
  double totalprice;
  List<Products> tempproducts;

  @override
  _PaymentMethodState createState() {
    _paymentMethodState = _PaymentMethodState();
    return _paymentMethodState;
  }
}

class _PaymentMethodState extends State<PaymentMethod> {
  TextEditingController coupon = TextEditingController();
  TextEditingController cardownercontroller = TextEditingController();
  TextEditingController expiredatecontroller = TextEditingController();
  TextEditingController cvvcontroller = TextEditingController();
  TextEditingController creditcardnumber = TextEditingController();
  String hour='';

  bool payloading = false;
  bool calendarnotselected = false;
  bool emptycoponfield = false;
  bool wrongcopon = false;
  bool couponloading = false;
  bool confirmDate = false;
  String chosenDate = '';
  Future _selectDate(BuildContext context) async {
    DateTime date = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      confirmText: 'موافق',
      cancelText: 'رجوع',
      lastDate: date.add(Duration(days: 30)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme:
                TextTheme(button: TextStyle(fontSize: 20, fontFamily: 'hayah')),
            primaryColor: pinktheme,
            accentColor: pinktheme,
            colorScheme: ColorScheme.light(primary: pinktheme),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          confirmDate = true;
          date = value;
          chosenDate = DateFormat('yyyy-MM-dd').format(date);
          print(chosenDate);
           hour=hourchoosen[selecttime]['hour'];
                                                          
          // _selectTime(context);
        });
      }
    });
  }

  bool agreeonterms = false;
  int id = 1;
  List paymentmethod = [
    {'icon': 'images/visa.png', 'index': '3', 'name': 'VISA'},
    {'icon': 'images/MASTERCARD.png', 'index': '2', 'name': 'MASTERCARD'},
    {'icon': 'images/apple pay.png', 'index': '4', 'name': 'applyepay'},
    {'icon': 'images/mada.png', 'index': '1', 'name': 'mada'},
    {'icon': 'images/cashicon.png', 'index': '0', 'name': 'cash'},
  ];
  List hourchoosen = [
    {
      'hour': "10AM - 3PM",
    },
    {
      'hour': "3PM - 9PM",
    },
    {
      'hour': "9PM - 1AM",
    },
  ];
  bool successful = false;
  String paymenttype;
  int selecttime = 0;
  CouponModel couponModel = CouponModel();
  double oldPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oldPrice = totalprice;
    print(cart.length);
    widget.tempproducts = [];
    for (var i = 0; i < cart.length; i++) {
      widget.tempproducts.add(Products(
          quantity: cart[i].quantity.toString(),
          productId: cart[i].id.toString()));
    }
    print(widget.tempproducts);
  }

  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting('en', null);
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
                'طريقة الدفع',
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
                  right: 25, left: 25, top: 40, bottom: 30),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidCalendarAlt,
                        color: pinktheme,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'موعد وتوقيت التوصيل',
                          style: TextStyle(
                            fontFamily: 'hayah',
                            fontSize: 16,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => TableC()));
                        await _selectDate(context).then((value) {
                          !confirmDate
                              ? null
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: CustomAlertDialog(
                                          content: Container(
                                              color: Color(0xFFF8F8F8),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [],
                                                    ),
                                                    Text(
                                                      'اختر الوقت المناسب لك',
                                                      style: TextStyle(
                                                        fontFamily: 'hayah',
                                                        fontSize: 20,
                                                        color: const Color(
                                                            0xff000000),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    ListView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            hourchoosen.length,
                                                        itemBuilder:
                                                            ((BuildContext
                                                                    context,
                                                                int index) {
                                                          return GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  index=index;
                                                                  selecttime =
                                                                      index;
                                                                       hour=hourchoosen[selecttime]['hour'];
                                                          

                                                                  print(
                                                                      selecttime);
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.0),
                                                                    // color: const Color(0xff8a9dd0),
                                                                    color: selecttime ==
                                                                            index
                                                                        ? Color(
                                                                            0xff919191)
                                                                        : Colors
                                                                            .white,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: const Color(
                                                                            0x3b000000),
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        blurRadius:
                                                                            6,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            15),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        hourchoosen[index]
                                                                            [
                                                                            'hour'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Cairoreg',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black,
                                                                          letterSpacing:
                                                                              -0.132,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ));
                                                        })),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15,
                                                          horizontal: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            chosenDate=chosenDate;
                                                           hour=hourchoosen[selecttime]['hour'];
                                                          
                                                                print(calendarnotselected);
                                                          });
                                                         Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              color: pinktheme,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: const Color(
                                                                      0x29000000),
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  blurRadius: 6,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'تأكيد',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'hayah',
                                                                  fontSize: 13,
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      );
                                    });
                                  });
                        });
                        // _selectDate(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.0),
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
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                chosenDate.isNotEmpty &&
                                        hourchoosen[selecttime]['hour']
                                            .isNotEmpty
                                    ? chosenDate +'  '+ hour
                                    
                                    //  +
                                    //     ' ' +
                                    //     hourchoosen[selecttime]['hour']
                                    : '',
                                    style: TextStyle(
                                      // fontFamily: 'hayah',
                                      fontSize: 16
                                    ),
                                  
                              ),
                              SvgPicture.asset('images/calendarsvg.svg')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  chosenDate.isNotEmpty &&
                              hourchoosen[selecttime]['hour'].isNotEmpty
                      ? 
                       SizedBox():
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'من فضلك اختر الوقت والتاريخ',
                            style: TextStyle(
                                color: Colors.red, fontFamily: 'hayah'),
                          ),
                        ),
                      
                  Row(
                    children: [
                      Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.0),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                agreeonterms = !agreeonterms;
                              });
                            },
                            child: Icon(
                              Icons.check,
                              color: agreeonterms == true
                                  ? pinktheme
                                  : Colors.white,
                              size: 18,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 12,
                              color: const Color(0xff757575),
                            ),
                            children: [
                              TextSpan(
                                text: 'أوافق على  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'سياسة الخصوصية',
                                style: TextStyle(
                                  color: const Color(0xffe33e71),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  !agreeonterms
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'من فضلك اضغظ علي اوافق علي سياسة الخصوصية',
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'hayah',
                                fontSize: 11),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return CustomAlertDialog(
                                  content: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'من فضلك ادخل الكوبون',
                                                style: TextStyle(
                                                    fontFamily: 'hayah',
                                                    fontSize: 14),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Icon(
                                                    FontAwesomeIcons.times,
                                                    size: 16,
                                                  ))
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              controller: coupon,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFCFD0D0))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFFCFD0D0))),
                                                hintText: 'الكوبون',
                                                hintStyle: TextStyle(
                                                    fontFamily: 'hayah',
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          wrongcopon
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      'الكوبون ليس صحيح',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily: 'hayah'),
                                                    )
                                                  ],
                                                )
                                              : SizedBox(),
                                          emptycoponfield
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      'من فضلك ادخل الكوبون',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily: 'hayah'),
                                                    )
                                                  ],
                                                )
                                              : SizedBox(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: GestureDetector(
                                              onTap: () async {
                                                if (coupon.text.isNotEmpty) {
                                                  setState(() {
                                                    emptycoponfield = false;
                                                    couponloading = true;
                                                  });
                                                  couponModel = CouponModel();
                                                  couponModel =
                                                      await CouponCodeService()
                                                          .checkCoupon(
                                                              coupon:
                                                                  coupon.text)
                                                          .then((value) {
                                                    setState(() {
                                                      couponModel = value;
                                                    });
                                                    return value;
                                                  });
                                                  setState(() {
                                                    couponloading = false;
                                                  });
                                                  if (couponModel.coupon ==
                                                      null) {
                                                    print('wrongtest');
                                                    setState(() {
                                                      wrongcopon = true;
                                                    });
                                                  } else {
                                                    _paymentMethodState
                                                        .setState(() {
                                                      oldPrice = totalprice;
                                                      oldPrice = (oldPrice -
                                                          (double.parse(couponModel
                                                                      .coupon
                                                                      .value) *
                                                                  oldPrice) /
                                                              100);
                                                      wrongcopon = false;
                                                    });

                                                    print(couponModel
                                                        .coupon.value);

                                                    Navigator.pop(context);
                                                  }
                                                } else {
                                                  setState(() {
                                                    emptycoponfield = true;
                                                    wrongcopon = false;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  color: pinktheme,
                                                  //  const Color(0xff8a9dd0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                          0x29000000),
                                                      offset: Offset(0, 0),
                                                      blurRadius: 6,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: couponloading
                                                      ? SpinKitRing(
                                                          color: Colors.white,
                                                          size: 30,
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text("التأكيد",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      'hayah',
                                                                  color: Colors
                                                                      .white))),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.0),
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
                          padding: const EdgeInsets.all(17.0),
                          child: Text(
                            '+ اضافة كوبون خصم',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 16,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image(image: AssetImage('images/payment.png')),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'طريقة الدفع',
                          style: TextStyle(
                            fontFamily: 'hayah',
                            fontSize: 14,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  MediaQuery.of(context).size.width > 400
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Radio(
                                            activeColor: pinktheme,
                                            focusColor: pinktheme,
                                            value: 0,
                                            groupValue: id,
                                            onChanged: (val) {
                                              setState(() {
                                                id = 0;
                                              });
                                            }),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: Image(
                                              image: AssetImage(
                                                  'images/madaa.png')),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Radio(
                                            activeColor: pinktheme,
                                            focusColor: pinktheme,
                                            value: 1,
                                            groupValue: id,
                                            onChanged: (val) {
                                              setState(() {
                                                id = 1;
                                              });
                                            }),
                                        SvgPicture.asset('images/cashsvg.svg'),
                                        Text(
                                          'الدفع عند الاستلام',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'hayah'),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: pinktheme,
                                              focusColor: pinktheme,
                                              value: 2,
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  id = 2;
                                                });
                                              }),
                                          SvgPicture.asset('images/visasvg.svg')
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: pinktheme,
                                              focusColor: pinktheme,
                                              value: 3,
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  id = 3;
                                                });
                                              }),
                                          SvgPicture.asset(
                                              'images/mastercardsvg.svg')
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: pinktheme,
                                              focusColor: pinktheme,
                                              value: 4,
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  id = 4;
                                                });
                                              }),
                                          Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.16,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.16,
                                              child: Image(
                                                  image: AssetImage(
                                                      'images/applepaypng.png')))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Radio(
                                            activeColor: pinktheme,
                                            focusColor: pinktheme,
                                            value: 0,
                                            groupValue: id,
                                            onChanged: (val) {
                                              setState(() {
                                                id = 0;
                                              });
                                            }),
                                        SvgPicture.asset('images/madasvg.svg')
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Radio(
                                            activeColor: pinktheme,
                                            focusColor: pinktheme,
                                            value: 1,
                                            groupValue: id,
                                            onChanged: (val) {
                                              setState(() {
                                                id = 1;
                                              });
                                            }),
                                        Expanded(
                                          child: SvgPicture.asset(
                                              'images/cashsvg.svg'),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'الدفع عند الاستلام',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'hayah'),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: pinktheme,
                                              focusColor: pinktheme,
                                              value: 2,
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  id = 2;
                                                });
                                              }),
                                          SvgPicture.asset('images/visasvg.svg')
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: pinktheme,
                                              focusColor: pinktheme,
                                              value: 3,
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  id = 3;
                                                });
                                              }),
                                          SvgPicture.asset(
                                              'images/mastercardsvg.svg')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Radio(
                                      activeColor: pinktheme,
                                      focusColor: pinktheme,
                                      value: 4,
                                      groupValue: id,
                                      onChanged: (val) {
                                        setState(() {
                                          id = 4;
                                        });
                                      }),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.16,
                                      width: MediaQuery.of(context).size.width *
                                          0.16,
                                      child: Image(
                                          image: AssetImage(
                                              'images/applepaypng.png')))
                                ],
                              ),
                            ],
                          )),

                  // 300<MediaQuery.of(context).size.width?
                  // Text(
                  //   'إسم صاحب البطاقة',
                  //   style: TextStyle(
                  //     fontFamily: 'hayah',
                  //     fontSize: 14,
                  //     color: const Color(0xff000000),
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 4),
                  //   child: Material(
                  //     elevation: 2,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     child: TextField(
                        
                  //       controller: cardownercontroller,
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               'تاريخ الانتهاء',
                  //               style: TextStyle(
                  //                 fontFamily: 'hayah',
                  //                 fontSize: 14,
                  //                 color: const Color(0xff000000),
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(vertical: 4),
                  //               child: Material(
                  //                 elevation: 2,
                  //                 borderRadius: BorderRadius.circular(10.0),
                  //                 child: TextField(
                  //                   controller: expiredatecontroller,
                  //                   cursorColor: pinktheme,
                  //                   decoration: InputDecoration(
                  //                       enabledBorder: OutlineInputBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10.0),
                  //                           borderSide: BorderSide(
                  //                               color: Colors.white)),
                  //                       focusedBorder: OutlineInputBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10.0),
                  //                           borderSide: BorderSide(
                  //                               color: Colors.white))),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 30,
                  //       ),
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               'CVV',
                  //               style: TextStyle(
                  //                 fontFamily: 'hayah',
                  //                 fontSize: 14,
                  //                 color: const Color(0xff000000),
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(vertical: 4),
                  //               child: Material(
                  //                 elevation: 2,
                  //                 borderRadius: BorderRadius.circular(10.0),
                  //                 child: TextField(
                  //                   controller: cvvcontroller,
                  //                   cursorColor: pinktheme,
                  //                   decoration: InputDecoration(
                  //                       enabledBorder: OutlineInputBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10.0),
                  //                           borderSide: BorderSide(
                  //                               color: Colors.white)),
                  //                       focusedBorder: OutlineInputBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10.0),
                  //                           borderSide: BorderSide(
                  //                               color: Colors.white))),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Text(
                  //   'رقم البطاقة الائتمانية',
                  //   style: TextStyle(
                  //     fontFamily: 'hayah',
                  //     fontSize: 14,
                  //     color: const Color(0xff000000),
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 4),
                  //   child: Material(
                  //     elevation: 2,
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     child: TextField(
                  //       controller: creditcardnumber,
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
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الضريبة 15%',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'hayah',
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'hayah',
                                    fontSize: 18),
                              ),
                            ),
                            Text(
                              'مجاني',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'hayah',
                                  fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'تكلفة المنتجات',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'hayah',
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                oldPrice.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'hayah',
                                    fontSize: 18),
                              ),
                            ),
                            Text(
                              'ريال',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'hayah',
                                  fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'تكلفة التوصيل',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'hayah',
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              'مجاني',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'hayah',
                                  fontSize: 18),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المجموع الكلي',
                          style: TextStyle(
                              color: pinktheme,
                              fontFamily: 'hayah',
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                oldPrice.toString(),
                                style: TextStyle(
                                    color: pinktheme,
                                    fontFamily: 'hayah',
                                    fontSize: 18),
                              ),
                            ),
                            Text(
                              'ريال',
                              style: TextStyle(
                                  color: pinktheme,
                                  fontFamily: 'hayah',
                                  fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (chosenDate.isNotEmpty &&
                          hourchoosen[selecttime]['hour'].isNotEmpty &&
                          agreeonterms) {
                        setState(() {
                          calendarnotselected = false;
                        });
                        print('here');
                        print(widget.tempproducts);

                        CreateOrderModel createOrderModel = CreateOrderModel(
                            // sendermail: widget.sendermail,
                            // senderphone: widget.senderphone,
                            // sendername: widget.sendername,
                            address: widget.cityofgifting,
                            deliveryDate: chosenDate,
                            latitude: widget.latitude,
                            longitude: widget.longitude
                            ,
                            // latitude: widget.latitude == null
                            //     ? null
                            //     : widget.latitude.toInt(),
                            // longitude: widget.longitude == null
                            //     ? null
                            //     : widget.longitude.toInt(),
                            note: widget.messgtext,
                            products: widget.tempproducts,
                            totalPrice: oldPrice,
                            typePayment: 
                            id==0?'mada':id==1?'cash':id==2?
                            'visa':id==3?'mastercard':id==4?'applypay':'',
                            district: widget.district,
                            cardDescription: widget.messgtext,
                            deliveryTime: hourchoosen[selecttime]['hour'],
                            reciverName: widget.recivername,
                            
                            // productsmodel: cart,
                            // reciverPhone: widget.check
                            //     ? widget.senderphone
                            //     : widget.tempphone
                            reciverPhone: widget.reciverphone);

                        setState(() {
                          payloading = true;
                        });

                         paymenttype= await OrderService()
                            .postOrders(
                                createOrderModel: createOrderModel,
                                context: context)
                            .then((value) {
                          setState(() {
                            paymenttype = value;
                          });
                          print(paymenttype);
                          return value;
                          
                        });

                        setState(() {
                          payloading = false;
                        });

                        if (paymenttype==null) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 4), () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavigationPage(
                                                currentindex: 0,
                                              )));
                                });
                                return Material(
                                  color: Colors.transparent,
                                  child: CustomAlertDialog(
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'images/orderrecived.png')),
                                            Image(
                                                image: AssetImage(
                                                    'images/confirmlogo.png')),
                                            Text(
                                              'نسعد بخدمتكم',
                                              style: TextStyle(
                                                fontFamily: 'hayah',
                                                fontSize: 19,
                                                color: const Color(0xff8c9dbe),
                                                letterSpacing:
                                                    -0.00916666841506958,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'نتمنى ان نكون عند حسن ظنكم دائما',
                                              style: TextStyle(
                                                fontFamily: 'hayah',
                                                fontSize: 18,
                                                color: const Color(0xff000000),
                                                letterSpacing:
                                                    -0.006666667938232422,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NavigationPage(
                                                                currentindex: 0,
                                                              )));
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          const Color(
                                                              0xffee6886),
                                                          const Color(
                                                              0xffdf2e6a)
                                                        ],
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 20,
                                                                horizontal: 0),
                                                        child: Center(
                                                          child: Text(
                                                            'الصفحة الرئيسية',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'hayah'),
                                                          ),
                                                        ))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        else{
                          print('da msh cash');
                           Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: WView(
                                    html: paymenttype,
                                  ),
                                ),
                              );
                            }));
                        }
                      } else {
                        setState(() {
                          calendarnotselected = true;
                        });
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderInfo()));
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
                            vertical: 17, horizontal: 0),
                        child: Center(
                          child: payloading
                              ? SpinKitRing(
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Text(
                                  'تأكيد عملية الشراء',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'hayah'),
                                ),
                        ),
                      ),
                    ),
                  ),
                  // GridView.count(
                  //   crossAxisCount: 3,
                  //   childAspectRatio: 9 / 4,
                  //   reverse: true,
                  //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  //   crossAxisSpacing: 0,
                  //   mainAxisSpacing: 0,
                  //   shrinkWrap: true,
                  //   addAutomaticKeepAlives: false,
                  //   addRepaintBoundaries: false,

                  //   physics: NeverScrollableScrollPhysics(),
                  //   children: paymentmethod
                  //       .map((e) => Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //             children: [
                  //               Expanded(
                  //                 flex: e['index']=='0'?4:
                  //                  1,
                  //                                                 child: Radio(
                  //                     activeColor: pinktheme,
                  //                     focusColor: pinktheme,
                  //                     value: int.parse(e['index']),
                  //                     groupValue: id,
                  //                     onChanged: (val) {
                  //                       setState(() {
                  //                         id = int.parse(e['index']);
                  //                       });
                  //                     }),
                  //               ),
                  //               Expanded(
                  //                 flex:
                  //                  e['index']=='0'?4:
                  //                  1,
                  //                                                 child: Container(

                  //                     width:

                  //                     MediaQuery.of(context).size.width *
                  //                         0.15,
                  //                     child: Image(image: AssetImage(e['icon']))),
                  //               ),
                  //                     e['index']=='0'?  Expanded(
                  //                       flex: 1,
                  //                       child: Text('الدفع عند الاستلام',
                  //                       style: TextStyle(
                  //                         fontFamily: 'hayah',
                  //                         fontSize: 10
                  //                       ),
                  //                       ),

                  //                       ):SizedBox(),

                  //             ],
                  //           ))
                  //       .toList(),
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
