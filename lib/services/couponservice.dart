import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/couponmodel.dart';

String token = '';

class CouponCodeService {
  Future<CouponModel> checkCoupon({String coupon}) async {
    print('hi');
    Dio dio = Dio();
    String url = "$apiurl/client/checkCoupon";
    final response = await dio.post(url,
        options: Options(headers: {
          'Accept': 'application/json',
          "Authorization": "Bearer ${userModel.accessToken}"
        }),
        data: {
          "coupon": coupon,
        });
    print(response.data);

    if (response.data['coupon'] != null) {
      print('coupon is right');

      print(response.data['coupon']['value']);
    } else {
      print('here');
      print(json.encode(response.data));
    }
    return CouponModel.fromJson(response.data);
  }
}
