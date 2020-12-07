import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/screens/loginpage.dart';
import 'package:TheSpecialParty/services/userservice.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';
import 'package:TheSpecialParty/widgets/customdialog.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  bool hidepassword = true;
  bool registration_empty_field = false;
  TextEditingController passwordcodelogincontroller = TextEditingController();

  bool codeemptyfield = false;
  bool wrongcode = false;
  bool codeloading = false;
  String wrongMessage = '';
  bool registerloading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          setState(() {
            userModel=null;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              SizedBox(
                width: 30,
              )
            ],
            leading: SizedBox(),
            backgroundColor: pinktheme,
            elevation: 0,
            title: Center(
              child: Text(
                'الحفلة المميزة',
                style: TextStyle(
                    color: Colors.white, fontSize: 21, fontFamily: 'hayah'),
              ),
            ),
          ),
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
                    right: 25, left: 25, top: 5, bottom: 0),
                child: ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'انشاء حساب',
                          style: TextStyle(
                            fontFamily: 'hayah',
                            fontSize: 19,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'الاسم',
                      style: TextStyle(
                        fontFamily: 'hayah',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: namecontroller,
                        style: TextStyle(color: Colors.black,
                      fontSize: 18),
                        cursorColor: pinktheme,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    Text(
                      'رقم الجوال',
                      style: TextStyle(
                        fontFamily: 'hayah',
                        fontSize: 15,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                        controller: phonecontroller,
                        style: TextStyle(color: Colors.black,
                      fontSize: 18),
                        cursorColor: pinktheme,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('images/ksasvg.svg'),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    // Text(
                    //   'الايميل',
                    //   style: TextStyle(
                    //     fontFamily: 'hayah',
                    //     fontSize: 15,
                    //     color: const Color(0xff000000),
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8),
                    //   child: TextField(
                    //     controller: emailcontroller,
                    //     style: TextStyle(color: Colors.grey),
                    //     cursorColor: pinktheme,
                    //     decoration: InputDecoration(
                    //         contentPadding: EdgeInsets.all(0),
                    //         fillColor: Colors.white,
                    //         filled: true,
                    //         enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(6),
                    //             borderSide: BorderSide(color: Colors.white)),
                    //         focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(6),
                    //             borderSide: BorderSide(color: Colors.white))),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            'كلمة المرور',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 15,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: passwordcontroller,
                        obscureText: hidepassword,
                        style: TextStyle(color: Colors.black,
                      fontSize: 18),
                        cursorColor: pinktheme,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    registration_empty_field
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'من فضلك ادخل البيانات',
                                  style: TextStyle(
                                      fontFamily: 'hayah', color: Colors.red),
                                ),
                              ],
                            ))
                        : SizedBox(),
                    wrongMessage.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  wrongMessage,
                                  style: TextStyle(
                                      fontFamily: 'hayah', color: Colors.red),
                                ),
                              ],
                            ))
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: GestureDetector(
                        onTap: () async {
                          if (namecontroller.text.isNotEmpty &&
                              phonecontroller.text.isNotEmpty &&
                              passwordcontroller.text.isNotEmpty 
                             ) {
                            setState(() {
                              registration_empty_field = false;
                              registerloading = true;
                            });
                            var reginfo = await UserService().registration(
                                name: namecontroller.text,
                                password: passwordcontroller.text,
                                phone: '966' + phonecontroller.text,
                              );

                            setState(() {
                              registerloading = false;
                            });

                            // print(reginfo['error']['phone'].toString());
                            if (reginfo == 'true') {
                              setState(() {
                                wrongMessage = '';
                              });
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return Material(
                                        color: Colors.grey,
                                        child: CustomAlertDialog(
                                          content: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.36,
                                            child: Center(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'التحقق من رقم الجوال',
                                                      style: TextStyle(
                                                        fontFamily: 'hayah',
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xffe33e71),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12),
                                                      child: Text(
                                                        'أدخل الكود المرسل لك على الهاتف',
                                                        style: TextStyle(
                                                          fontFamily: 'hayah',
                                                          fontSize: 15,
                                                          color: const Color(
                                                              0xff919191),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    PinInputTextField(
                                                      controller:
                                                          passwordcodelogincontroller,
                                                      pinLength: 4,
                                                      decoration:
                                                          BoxLooseDecoration(
                                                        bgColorBuilder:
                                                            PinListenColorBuilder(
                                                                Colors.grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                Colors.grey
                                                                    .withOpacity(
                                                                        0.5)),
                                                        strokeColorBuilder:
                                                            PinListenColorBuilder(
                                                                Color(
                                                                    0xFFF8F8F8),
                                                                Color(
                                                                    0xFFF8F8F8)),
                                                      ),
                                                    ),
                                                    codeemptyfield
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'من فضلك ادخل البيانات',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'hayah',
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ],
                                                            ))
                                                        : SizedBox(),
                                                    wrongcode
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'الكود غير صحيح',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'hayah',
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ],
                                                            ))
                                                        : SizedBox(),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 20),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          if (passwordcodelogincontroller
                                                              .text.isEmpty) {
                                                            setState(() {
                                                              codeemptyfield =
                                                                  true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              codeemptyfield =
                                                                  false;
                                                              codeloading =
                                                                  true;
                                                            });

                                                            var coderight =
                                                                await UserService()
                                                                    .verifyCode(
                                                                        code: passwordcodelogincontroller
                                                                            .text);
                                                            setState(() {
                                                              codeloading =
                                                                  false;
                                                            });

                                                            if (coderight[
                                                                    "massage"] ==
                                                                "Successfully") {
                                                              setState(() {
                                                                wrongcode =
                                                                    false;
                                                              });
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              NavigationPage()));
                                                            } else {
                                                              setState(() {
                                                                wrongcode =
                                                                    true;
                                                              });
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  const Color(
                                                                      0xffee6886),
                                                                  const Color(
                                                                      0xffdf2e6a)
                                                                ],
                                                              ),
                                                            ),
                                                            child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        0),
                                                                child: Center(
                                                                  child: codeloading
                                                                      ? SpinKitRing(
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              30,
                                                                        )
                                                                      : Text(
                                                                          'تأكيد',
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
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  });
                            } else if (reginfo['error']['phone'].toString() ==
                                '[صيغة الهاتف .غير صحيحة.]') {
                              setState(() {
                                wrongMessage = 'صيغة الهاتف غير صحيحة';
                              });
                            } else if (reginfo['error']['email'].toString() ==
                                '[يجب أن يكون البريد الالكتروني عنوان بريد إلكتروني صحيح البُنية.]') {
                              setState(() {
                                wrongMessage =
                                    'صيغة البريد الاكتروني غير صحيحة';
                              });
                            } else if (reginfo['error']['email'].toString() ==
                                    '[قيمة البريد الالكتروني مُستخدمة من قبل.]' &&
                                reginfo['error']['phone'].toString() ==
                                    '[قيمة الهاتف مُستخدمة من قبل.]') {
                              setState(() {
                                wrongMessage =
                                    'البريد الاكتروني وقيمة الهاتف مستخدمين من قبل';
                              });
                              print('use anothermail and another phone');
                            } else if (reginfo['error']['email'].toString() ==
                                '[قيمة البريد الالكتروني مُستخدمة من قبل.]') {
                              setState(() {
                                wrongMessage =
                                    'قيمة البريد الالكتروني مُستخدمة من قبل';
                              });
                              print('use another mail');
                            } else {
                              setState(() {
                                wrongMessage = 'قيمة الهاتف مُستخدمة من قبل';
                              });
                              print('use another phone');
                            }
                          } else {
                            setState(() {
                              registration_empty_field = true;
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
                                  child: registerloading
                                      ? SpinKitRing(
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : Text(
                                          'تسجيل الدخول',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'hayah'),
                                        ),
                                ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '  املك بالفعل حساب ! ',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                userModel=null;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontFamily: 'hayah',
                                fontSize: 13,
                                color: const Color(0xffe33e71),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
