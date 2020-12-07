import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/screens/Homepage.dart';
import 'package:TheSpecialParty/screens/registrationpage.dart';
import 'package:TheSpecialParty/screens/remmeberpassword.dart';
import 'package:TheSpecialParty/services/userservice.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';
import 'package:TheSpecialParty/widgets/customdialog.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController   passwordcodelogincontroller=TextEditingController();
  bool loginemptyfield = false;
  bool hidepassword = true;
  bool wrongdata = false;
  bool loadinglogin = false;
  bool codeemptyfield=false;
  
  bool codeloading=false;
  bool wrongcode=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {},
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
                    right: 25, left: 25, top: 5, bottom: 5),
                child: ListView(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'اهلا بك في الحفلة المميزة',
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
                      'رقم الجوال',
                      style: TextStyle(
                        fontFamily: 'hayah',
                        fontSize: 16,
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
                      fontSize: 18
                        ),
                        cursorColor: pinktheme,
                        decoration: InputDecoration(
                            suffixText: '(966+)',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('images/ksasvg.svg'),
                            ),
                            contentPadding: EdgeInsets.all(8),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'كلمة المرور',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 16,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RemmeberPassword()));
                          },
                          child: Text(
                            'نسيت كلمة المرور',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 12,
                              color: const Color(0xffe33e71),
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
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidepassword = !hidepassword;
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.solidEye,
                                color: Colors.grey,
                              ),
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
                    wrongdata
                        ? Text(
                            'ادخل البيانات الصحيحة',
                            style: TextStyle(
                                fontFamily: 'hayah', color: Colors.red),
                          )
                        : SizedBox(),
                    loginemptyfield
                        ? Text(
                            'من فضلك ادخل البيانات',
                            style: TextStyle(
                                fontFamily: 'hayah', color: Colors.red),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationPage()));
                        },
                        child: Center(
                          child: Text(
                            'الدخول كزائر',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 19,
                              color: const Color(0xffe33e71),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: GestureDetector(
                        onTap: () async {
                          if (phonecontroller.text.isNotEmpty &&
                              passwordcontroller.text.isNotEmpty) {
                            setState(() {
                              loginemptyfield = false;
                              loadinglogin = true;
                            });
                            bool rightdata = await UserService().login(
                                phone: '966' + phonecontroller.text,
                                password: passwordcontroller.text);
                            setState(() {
                              loadinglogin = false;
                            });
                            if (rightdata) {
                              setState(() {
                                wrongdata = false;
                              });
                              if(!userModel.verificationCode){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavigationPage()));
                              }
                              else{
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return WillPopScope(
                                      onWillPop: (){
                                        setState(() {
                                          userModel=null;
                                          Navigator.pop(context);
                                        });
                                      },
                                                                          child: StatefulBuilder(
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
                                      }),
                                    );
                                  });
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => NavigationPage()));
                            
                              }


                            }
                              else {
                              print('wrong');
                              setState(() {
                                wrongdata = true;
                              });
                            }
                          } else {
                            setState(() {
                              loginemptyfield = true;
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
                                    vertical: 16, horizontal: 0),
                                child: Center(
                                  child: loadinglogin
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
                            'لا يوجد حساب',
                            style: TextStyle(
                              fontFamily: 'hayah',
                              fontSize: 15,
                              color: const Color(0xff000000),
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
                              'انشاء حساب',
                              style: TextStyle(
                                fontFamily: 'hayah',
                                fontSize: 15,
                                color: pinktheme,
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
