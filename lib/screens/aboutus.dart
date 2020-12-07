import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:TheSpecialParty/constants.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                'من نحن',
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
              child: ListView(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('images/aboutsvg.svg'),
                  ),
                  // Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 20),
                  //     child: Text('من نحن؟',
                  //     style: TextStyle(
                  //       fontFamily: 'hayah',
                  //       fontSize: 17,
                  //       color: Colors.blue,
                  //       decoration: TextDecoration.underline
                  //     ),
                  //     ),
                  //   ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text('منصة الحفلة المميزة تعتبر مؤسسة ملكيتها سعودية %100 ومرخصه من وزارة التجارة في بيع وتسويق الزهور والورود الطبيعية وتوصيلها للمنازل بأسهل الطرق وبوقت قياسي .تطبيق الحفلة المميزة اخذ على عاتقه مهمة إدخال الفرحة على قلوب الناس وتسهيل عملية شراء وايصال الزهور بسهولة ويسر .تطبيق الحفلة المميزة يقبل الدفع بعدة وسائل عن طريق البطاقات الائتمانية ومدى و أبل بي بالإضافة لخدمة الدفع عند التوصيل .',
                        style: TextStyle(
                                              fontFamily: 'GESSMED',
                      fontSize: 16,
                      color: const Color(0xff0c0101),
                      fontWeight: FontWeight.w500,
                      height: 1.875,
                        ),
                        ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text('تطبيق الحفلة المميزة قام بتدريب منسقي الورد لدينا لتلبية جميع متطلبات العملاء سواء كنت ترغب بإرسال الزهور للتعبير عن اعجابك واخلاصك لشخص عزيز أو الورد لصديق ترحيباً بولادة طفل أو الزهور لمريض شفاه الله أو تصميم مناسبات خاصة او احتفاليات وزيارات عائلية خاصة ، أو أن تبارك بيتا اشتراه شخص عزيز، ومنسقي الورد والتوصيل لدينا على استعداد دائماً لمساعدتك على مدار اليوم من الساعه 9 ص الى الساعة 1 فجراً ,  كما يسعد الدعم لدينا بالمساعدة واستقبال الشكاوى والاراء والمقترحات على مدار 24 ساعه يومياً عن طريق الايميل او الواتساب الموضح بالتطبيق . فقط تفضل بالطلب من خلال تطبيقنا ( الحفلة المميزة ) لنساعدك باختيار وتنسيق باقة تليق بذوقك. أضف رونقاً وجمالاً على مناسباتك مع مجموعتنا المنوعة من باقات الورد و البطاقات والتي تضفي على باقات الزهور رونقاً وجمالاً .  تم تأسيس تطبيق ( الحفلة المميزة ) كمنصة رائدة لعرض الزهور وبيعها مباشرة إلى العملاء في كافة أنحاء الرياض حالياً وقريباً لتشمل فروعنا بالمملكة تتخصص في بيع الزهور  وباقات الورد بكافة أشكالها حسب رغبة العميل مع العلم بأنه يتم يومياً تزويدنا بأجود الزهور والنباتات من أفضل المواقع المتخصصة  ونقوم بتنسيق الباقات وتصميمها حسب رغبة العميل وتسليمها في الموعد المحدد من العميل لإرضائه. تتسم خدمتنا بالجودة والسرعة. ولأن إرضاء العميل من أولوياتنا، يحرص طاقم العمل المحترف لدينا على تقديم تجربة تسوق لا مثيل لها.نتمنى أن نكون دائماً عند حسن ظنكم وأن نصل لمستوى رضاكم ..',
                        style: TextStyle(
                                               fontFamily: 'GESSMED',
                      fontSize: 16,
                      color: const Color(0xff0c0101),
                      fontWeight: FontWeight.w500,
                      height: 1.875,
                        ),
                        ),
                    ),
                
                ],
              ),
            )),
      ),
    );
  }
}
