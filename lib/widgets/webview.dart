import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/widgets/NavigationPage.dart';
import 'package:TheSpecialParty/widgets/customdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WView extends StatefulWidget {
  final String html;

  WView({
    this.html,
  });
  @override
  _WViewState createState() => _WViewState();
}

class _WViewState extends State<WView> {
  @override
  void initState() {
    // TODO: implement initState
    print('html link');
    print(widget.html.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (page) async {
        final String result =
            Uri.dataFromString(page).queryParameters['Result'];
        print('result is $result');
        if (result == 'Successful') {
          print('success');

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
                                return WillPopScope(
                                  onWillPop: (){

                                  },
                                                                  child: Material(
                                    color: Colors.white,
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
                                                  fontSize: 16,
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
                                  ),
                                );
                              });
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // List<Order> templist = [];

          // var productOrderOld = json.decode(await prefs.getString('myOrders'));
          // if (productOrderOld.length > 0) {
          //   for (var i = 0; i < productOrderOld.length; i++) {
          //     //  Order productOrder = Order.fromJson(productOrderOld[i]);
          //     templist.add(Order.fromJson(productOrderOld[i]));
          //   }
          // }
          // templist.addAll(visaList);
          // print('de el visa list');
          // print(visaList);
          // prefs.setString('myOrders', json.encode(templist));
          // visaList.clear();
          // // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SucessScreen()));
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       Future.delayed(Duration(seconds: 5), () {
          //         Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => Homepage()));
          //       });
          //       return Confirmation();
          //     });
          // setState(() {
          //   cart.clear();
          // });
        } else if (result == 'Failure') {
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
                                return WillPopScope(
                                  onWillPop: (){

                                  },
                                                                  child: Material(
                                    color: Colors.white,
                                    child: CustomAlertDialog(
                                      content: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text('لم يتم اكتمال الطلب',
                                                style: TextStyle(
                                                  fontFamily: 'hayah',
                                                  color: pinktheme,
                                                  fontSize: 16
                                                  
                                                ),
                                                ),
                                              ),
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
                                                  fontSize: 16,
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
                                  ),
                                );
                              });
          // // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FailScreen()));
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       Future.delayed(Duration(seconds: 5), () {
          //         Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => Homepage()));
          //       });
          //       return PaymentFailed();
          //     });
        }
      },
      initialUrl:
          Uri.dataFromString(widget.html, mimeType: 'text/html').toString(),
    );
  }
}
