import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import '../models/productmodel.dart';

class Productservice {
  Future<GetCategoryDetails> getListOfProducts(int id, String link) async {
    String url = link == null ? "$apiurl/client/categories/$id" : link;
    final response = userModel == null
        ? await http.get(
            url,
            headers: {
              'Accept': 'application/json',
            },
          )
        : await http.get(
            url,
            headers: {
              'Accept': 'application/json',
              "Authorization": "Bearer ${userModel.accessToken}"
            },
          );

    print(json.decode(response.body));
    return GetCategoryDetails(
        products: AllProducts.fromJson(json.decode(response.body)['products']));
  }
}
