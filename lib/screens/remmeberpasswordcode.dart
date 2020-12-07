import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/screens/loginpage.dart';
import 'package:TheSpecialParty/screens/userporfile.dart';
import 'package:TheSpecialParty/services/userservice.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class RemmemberPasswordCode extends StatefulWidget {
  RemmemberPasswordCode({this.phone});

  String phone;
  @override
  _RemmemberPasswordCodeState createState() => _RemmemberPasswordCodeState();
}

class _RemmemberPasswordCodeState extends State<RemmemberPasswordCode> {
  bool codeforgetemptyfield = false;
  bool codeagainloading = false;
  bool wrongcode = false;
  bool codeenterloading = false;
  TextEditingController passwordcodecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              'نسيت كلمة المرور',
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
              padding:
                  const EdgeInsets.only(right: 25, left: 25, top: 5, bottom: 5),
              child: ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'تحقق الهاتف',
                        style: TextStyle(
                          fontFamily: 'hayah',
                          fontSize: 20,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'ادخل الكود المرسل لك علي جوالك',
                    style: TextStyle(
                      fontFamily: 'hayah',
                      fontSize: 16,
                      color: const Color(0xff919191),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: PinInputTextField(
                      controller: passwordcodecontroller,
                      pinLength: 4,
                      decoration: BoxLooseDecoration(
                        bgColorBuilder:
                            PinListenColorBuilder(Colors.white, Colors.white),
                        strokeColorBuilder:
                            PinListenColorBuilder(Colors.white, Colors.white),
                      ),
                    ),
                  ),
                  codeforgetemptyfield
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
                  wrongcode
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                'الكود غير صحيح',
                                style: TextStyle(
                                    fontFamily: 'hayah', color: Colors.red),
                              ),
                            ],
                          ))
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'لم يصلك كود التفعيل على الهاتف؟',
                      style: TextStyle(
                        fontFamily: 'hayah',
                        fontSize: 16,
                        color: const Color(0xff919191),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          codeagainloading = true;
                        });

                        await UserService()
                            .remmeberPaddword(phone: widget.phone);
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
                                      color: Color(0xFF656565).withOpacity(0.9),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(21))),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Center(
                                    child: Text('تم ارسال الكود بنجاح',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Sukarbold',
                                            fontSize: 14)),
                                  )),
                            ),
                          ),
                          context: context,
                        );

                        setState(() {
                          codeagainloading = false;
                        });
                      },
                      child: codeagainloading
                          ? SpinKitRing(color: pinktheme)
                          : Text(
                              'إرسال كود جديد',
                              style: TextStyle(
                                fontFamily: 'hayah',
                                fontSize: 15,
                                color: const Color(0xfffb4f68),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () async {
                        if (passwordcodecontroller.text.isEmpty) {
                          setState(() {
                            codeforgetemptyfield = true;
                            wrongcode = false;
                          });
                        } else {
                          setState(() {
                            codeforgetemptyfield = false;
                            codeenterloading = true;
                          });
                          var response = await UserService()
                              .remmemberpasswordcode(
                                password: passwordcodecontroller.text,
                                phone: widget.phone
                              );
                          if (response) {
                            setState(() {
                              wrongcode = false;
                              codeenterloading = false;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile()));
                          } else {
                            setState(() {
                              wrongcode = true;
                              codeenterloading = false;
                            });
                          }
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
                                  vertical: 20, horizontal: 0),
                              child: Center(
                                child: codeenterloading
                                    ? SpinKitRing(
                                        color: Colors.white,
                                        size: 25,
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
            )),
      ),
    );
  }
}
