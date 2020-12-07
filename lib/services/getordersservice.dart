import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/UserModel.dart';
import 'package:TheSpecialParty/models/getallordersmode.dart';
import 'package:TheSpecialParty/models/getorderdetailsmodel.dart';
import '../models/productmodel.dart';

class GetOrderService {
  Future<GetOrdersModel> getListOfOrders({String link}) async {
    print(userModel.accessToken);
    String url = link == null ? "$apiurl/client/orders" : link;
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      "Authorization": "Bearer ${userModel.accessToken}"
    });
    return GetOrdersModel.fromJson(json.decode(response.body));
  }
//   getorderdetails(
//    {int id}
//  ) async {

//     String url = "$apiurl/client/orders/$id/show";
//     final response =
//         await http.get(url, headers: {'Accept': 'application/json',
//                "Authorization":
//             "Bearer ${userModel.accessToken}"
//         });
//         var tempList ;

//   print(response.body);

//     if (response.statusCode == 200) {
//       print('right');

//       var responseBody = json.decode(response.body)['order'];
//       tempList=responseBody;
//      print(responseBody);

//      print(tempList);

//   }
//   return tempList;

// }
}
