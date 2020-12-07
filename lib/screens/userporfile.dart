import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/getorderdetailsmodel.dart';
import 'package:TheSpecialParty/screens/registrationpage.dart';
import 'package:TheSpecialParty/services/sharedprefrences.dart';
import 'package:TheSpecialParty/services/userservice.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';

class UserProfile extends StatefulWidget {
  UserProfile({this.remmeberpassword});

  bool remmeberpassword;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map userdata = {};
  String name = '';
  bool loading=false;
  bool emptydata=false;
  String errormessg='';

  getUserData() async {
setState(() {
  loading=true;
});

    var user = await UserService().getUserDATA();
    setState(() {
      userdata=user;
    });
    setState(() {
        namecontroller=TextEditingController(text: userdata['name'].toString());
        phonecontroller=TextEditingController(text: userdata['phone'].toString());
        loading=false;
     });

  
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   homeloading = true;
    // });
    // setState(() {
    //   homeloading=true;
    // });
    // if(userModel!=null){
    //   namecontroller = TextEditingController(text: userModel.user.name);
    // phonecontroller = TextEditingController(text: userModel.user.phone);
    // }
    
    getUserData();
    
     
 
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
                'الملف الشخصي',
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
                  right: 25, left: 25, top: 10, bottom: 10),
              child:
              
              userModel==null?
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: ListView(
                 children: [
                   Column(
                     children: [
                        Text('انت لست مسجلا',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'hayah'
                    ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
                      },
                                        child: Text('قم بالتسجيل',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'hayah',
                        color: pinktheme
                      ),
                      ),
                    )
                     ],
                   )
                 ],
             ),
               ):

               loading?
               SpinKitRing(color: pinktheme):
               ListView(children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image(image: AssetImage('images/logoprofile.png'))),
                Material(
                  elevation: 2,
                  child: TextField(
                    controller: namecontroller,
                    cursorColor: pinktheme,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 5),
                          child: Text(
                            'الاسم :',
                            style: TextStyle(
                                fontFamily: 'hayah',
                                fontSize: 15,
                                color: pinktheme),
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: pinktheme,
                        ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Material(
                    elevation: 2,
                    child: TextField(
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      controller: phonecontroller,
                      cursorColor: pinktheme,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 5),
                            child: Text(
                              'رقم الجوال :',
                              style: TextStyle(
                                  fontFamily: 'hayah',
                                  fontSize: 15,
                                  color: pinktheme),
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: pinktheme,
                          ),
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
                ),
                Material(
                  elevation: 2,
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: true,
                    cursorColor: pinktheme,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 5),
                          child: Text(
                            'كلمة المرور :',
                            style: TextStyle(
                                fontFamily: 'hayah',
                                fontSize: 15,
                                color: pinktheme),
                          ),
                        ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Material(
                    elevation: 2,
                    child: TextField(
                      controller: confirmpasswordcontroller,
                      obscureText: true,
                      cursorColor: pinktheme,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 5),
                            child: Text(
                              'تأكيد كلمة المرور  :',
                              style: TextStyle(
                                  fontFamily: 'hayah',
                                  fontSize: 15,
                                  color: pinktheme),
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: pinktheme,
                          ),
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
                ),
                emptydata?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('من فضلك ادخل البيانات',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'hayah'

                  ),
                  ),
                ):SizedBox(),
                errormessg.isNotEmpty?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(errormessg,
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'hayah'

                  ),
                  ),
                ):SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () async {
                     if(namecontroller.text.isNotEmpty&&
                     phonecontroller.text.isNotEmpty&&
                     passwordcontroller.text.isNotEmpty&&
                     confirmpasswordcontroller.text.isNotEmpty
                     ){
                        setState(() {
                        loading=true;
                        emptydata=false;
                        
                      });
                      

                      
                      bool updated=await UserService().updateUser(
                        name: namecontroller.text,
                        phone: phonecontroller.text
                      );
                      
                      bool changepassword=await UserService().changePassword(
                        password: passwordcontroller.text,
                        confirmpassowrd: confirmpasswordcontroller.text

                      );

                      setState(() {
                        loading=false;
                      });
                      if(updated){
                        if(changepassword){
                          setState(() {
                            errormessg='';
                          });
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
                                                            'تم تحديث البيانات بنجاح',
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
                                            setState(() {
                                              userModel.user.phone=phonecontroller.text;
                                              
                                            });
                                            await saveData(key: 'user', saved: json.encode(userModel));
                          Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context)=>NavigationPage())
                          );


                        }
                        else{
                          setState(() {
                            errormessg='تأكيد كلمة المرور ليست متطابقة مع كلمة المرور';
                          });
                        }

                      }
                      else{
                        setState(() {
                          errormessg='صيغة الهاتف غير صحيحة';
                        });

                      }

                      


                     }
                     else{
                       setState(() {
                         emptydata=true;
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
                                vertical: 10, horizontal: 0),
                            child: Center(
                              child: 
                              loading?
                              SpinKitRing(color: Colors.white):
                              Text(
                                'حفظ التعديلات',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'hayah'),
                              ),
                            ))),
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}
