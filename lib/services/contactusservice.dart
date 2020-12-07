// import 'dart:convert';
// import 'package:flowers/constants/constant.dart';
// import 'package:dio/dio.dart';

// class ContactUsService {
//  Future sendmessage(
//       {String phone, String name, String massage}) async {
//     print('hi');
// Dio dio = Dio();
//     String url = "$apiurl/contact_us";
//     final response = await dio.post(url, options: Options(headers: {
//         'Accept': 'application/json',
       
//       }),data: {
//       "name": name,
//       "phone": phone,
//       "massage": massage,
//     });
//     print(response.data);

//     if (response.statusCode == 200) {
//      print('sent');

      

//       return true;
//     } else {
     
//       return false;
//     }
//   }

// }