import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/screens/remmeberpasswordcode.dart';
import 'package:TheSpecialParty/services/userservice.dart';
import 'package:easy_localization/easy_localization.dart';

class RemmeberPassword extends StatefulWidget {
  @override
  _RemmeberPasswordState createState() => _RemmeberPasswordState();
}

class _RemmeberPasswordState extends State<RemmeberPassword> {
  TextEditingController phonecontroller =TextEditingController();
      bool fieldempty=false;
      bool wrongphone=false;
      bool loading=false;

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
                       'استعادة كلمة المرور',
                        style: TextStyle(
                          fontFamily: 'hayah',
                          fontSize: 21,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Text(
                     'قم بادخال رقم الجوال',
                    style: TextStyle(
                      fontFamily: 'hayah',
                      fontSize: 16,
                      color: const Color(0xff919191),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: TextField(
                      maxLength: 9,
                      controller: phonecontroller,
                      style: TextStyle(color: Colors.black,
                      fontSize: 18),
                      cursorColor: pinktheme,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('images/ksasvg.svg'),
                        ),
                            suffixText: '(966+)',
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
                  fieldempty?Text('من فضلك ادخل البيانات',
                  style: TextStyle(
                    fontFamily: 'hayah',
                    color: Colors.red
                  ),
                  ):SizedBox(),
                  wrongphone?Text('رقم الهاتف غير صحيح',
                  style: TextStyle(
                    fontFamily: 'hayah',
                    color: Colors.red
                  ),
                  ):SizedBox(),
                
                
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: ()async{
                        if(phonecontroller.text.isEmpty)
                        {
                          setState(() {
                            fieldempty=true;
                            wrongphone=false;
                          });
                        }
                        else{
                          setState(() {
                            fieldempty=false;
                            loading=true;
                          });

                          bool rightphone=await UserService().remmeberPaddword(
                            phone:'966'+ phonecontroller.text
                          );
                         if(rightphone){
                           setState(() {
                             loading=false;
                             wrongphone=false;
                           });
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
                                            color: Color(0xFF656565)
                                                .withOpacity(0.9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(21))),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        child: Center(
                                          child: Text(
                                              'تم ارسال الكود',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Sukarbold',
                                                  fontSize: 14)),
                                        )),
                                  ),
                                ),
                                context: context,
                              );
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RemmemberPasswordCode(
                            phone: '966'+phonecontroller.text,
                          )));
                         }
                         else{
                           setState(() {
                             loading=false;
                             wrongphone=true;
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
                                  vertical: 17, horizontal: 0),
                              child: Center(
                                child: 
                                loading?
                                SpinKitRing(color: Colors.white,size: 25,):
                                Text(
                                'ارسال الكود',
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
