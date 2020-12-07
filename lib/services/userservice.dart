import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/UserModel.dart';
import 'package:TheSpecialParty/services/sharedprefrences.dart';

class UserService {

  Future verifyCode({BuildContext context, String code}) async {
    String url = "$apiurl/general/auth/verification";
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer ${userModel.accessToken}",
      },
      body: {
        "verification_code": code,
      },
    );

    print(json.decode(response.body));
    if (json.decode(response.body)["massage"] == "Successfully")
    {
      print('rightcode');
      await saveData(key: 'user', saved: json.encode(userModel));

    }
    else{
      print('wrongcode');
    }
      return json.decode(response.body);
  }

  Future login({
    BuildContext context,
    String phone,
    String password,
  }) async {
    String url = "$apiurl/general/auth/login";
    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        'phone': phone,
        'password': password,
        'mobile_token': '$userMobileToken'
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(json.decode(response.body));
      if(!userModel.verificationCode)
      {
        await saveData(key: 'user', saved: json.encode(userModel));
      }
      print('right');

      return true;
    } else {
      print('wrong');
      return false;
    }
  }

  Future registration({
    BuildContext context,
    String name,
    String phone,
    String password,
    String cofnirmpassword,
    // String email,
  }) async {
    String url = "$apiurl/general/auth/register";
    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        'name': name,
        // 'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': password,
        'mobile_token': '$userMobileToken'
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('right');
      userModel = UserModel.fromJson(json.decode(response.body));

      return 'true';
    } else {
      print('wrong');
      return json.decode(response.body);
    }
  }

  Future<bool> logout() async {
    String url = "$apiurl/general/auth/logout";
    bool result = false;
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userModel.accessToken}',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('right');

      result = true;
    } else {
      print('wrong');

      result = false;
    }
    return result;
  }

  Future remmeberPaddword({
    BuildContext context,
    String phone,
  }) async {
    String url = "$apiurl/general/auth/ForgetPassword";
    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        'phone': phone,
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('right');

      return true;
    } else {
      print('wrong');

      return false;
    }
  }

  Future remmemberpasswordcode(
      {BuildContext context,
      String phone,
      String password,
      String mobiletoken}) async {
    String url = "$apiurl/general/auth/ForgetPasswordVerification";
    final response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: {
        'phone': phone,
        'forget_password': password,
        'mobile_token': '$userMobileToken',
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('right');
      userModel = UserModel.fromJson(json.decode(response.body));
      await saveData(key: 'user', saved: json.encode(userModel));

      return true;
    } else {
      print('wrong');

      return false;
    }
  }

  Future getUserDATA() async {
    String url = "$apiurl/general/auth/user";
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer ${userModel.accessToken}"
      },
    );

    print(response.body);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      print('right');

      return json.decode(response.body)['user'];
    } else {
      print('wrong');
    }
  }

  Future updateUser({
    BuildContext context,
    String phone,
    String name,
  }) async {
    String url = "$apiurl/general/auth/UpdateUser";
    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer ${userModel.accessToken}"
      },
      body: {'name': name, 'phone': phone},
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('right');

      return true;
    } else {
      print('wrong');
      return false;
    }
  }

  Future changePassword({String password, String confirmpassowrd}) async {
    String url = "$apiurl/general/auth/ChangePassword";
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        "Authorization": "Bearer ${userModel.accessToken}"
      },
      body: {'password': password, 'password_confirmation': confirmpassowrd},
    );

    print(response.body);

    if (response.statusCode == 200) {
      print('right');

      return true;
    } else {
      print('wrong');
      return false;
    }
  }
}
