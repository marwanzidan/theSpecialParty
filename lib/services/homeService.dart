import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/models/HomeModel.dart';

bool homeloading = false;

class HomeService {
  Future<Map> homeget() async {
    print('hi');
    print('zzzzz');

    String url = "$apiurl/general";

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
    });
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List sliders = json.decode(response.body)['sliders'];
      Map socialmedialinks = json.decode(response.body)['setting'];
      print('inhome');
    } else {
      print('failed');
    }
    return json.decode(response.body);
  }
}
