import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/createordermodel.dart';
import 'package:TheSpecialParty/models/getallordersmode.dart';
import 'package:TheSpecialParty/models/getorderdetailsmodel.dart';
import 'package:TheSpecialParty/screens/shoppingcart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  Future<String> postOrders(
      {CreateOrderModel createOrderModel, BuildContext context}) async {
    Dio dio = Dio();
    bool done = false;
    String url = "$apiurl/client/orders";

    final response = await dio.post(
      url,
      options: Options(headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer ${userModel.accessToken}"
      }),
      data: createOrderModel,
    );

    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      done = true;
      totalprice = 0;
      cart.clear();
      print('ordercreated');
      print(response.data['html']);
      return response.data['html'];
    } else {
      print('faliure');
      done = false;
    
    }
    
  }

  Future<ShowOrderDetails> getOrderdetails({int id}) async {
    Dio dio = Dio();

    String url = "$apiurl/client/orders/$id/show";

    final response = await dio.get(
      url,
      options: Options(headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer ${userModel.accessToken}"
      }),
    );
    var tempOrders = {};
    print(userModel.accessToken);
    print(response.data['order']);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseBody = response.data['order'];
      print(responseBody);
      tempOrders = responseBody;
    } else {
      print('faliure');
      print(json.encode(response.data));
    }
    List x = response.data['order']['products'];
    for (var i = 0; i < x.length; i++) {
      print(x[i]);
    }
    return ShowOrderDetails.fromJson(response.data);
  }
}
