import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/main.dart';
import 'package:TheSpecialParty/models/favoritemode.dart';



String token = '';

class FavoriteService {
  Future postFavorite({int productid}) async {
    print('hi');
    Dio dio = Dio();
    String url = "$apiurl/client/favorite";
    final response = await dio.post(url,
        options: Options(headers: {
          'Accept': 'application/json',
           "Authorization": "Bearer ${userModel.accessToken}"
        }),
        data: {
          "product_id": productid,
        });
    print(response.data);

   if (response.statusCode == 200) {
      print('favoriteposted');

      
    }
    else{
      print('someerror');
      
    }
  }
   Future getFavorites() async {
    print('hi');
    Dio dio = Dio();
    String url = "$apiurl/client/favorite";
    final response = await dio.get(url,
        options: Options(headers: {
          'Accept': 'application/json',
           "Authorization": "Bearer ${userModel.accessToken}"
        }),
      );
    print(response.data);
    List<FavoriteData> tempfav=[];

   if (response.statusCode == 200) {
      print('favoriteposted');
      tempfav.clear();
      // var responseBody = json.decode(response.data)['favorites']['data'];
      print( response.data['favorites']['data']);
      List responseBody =response.data['favorites']['data'];
      for (int i = 0; i < responseBody.length; i++) {
         
          tempfav.add(FavoriteData.fromJson(responseBody[i]));
        
      }
      return tempfav;

      
    }
    else{
      print('someerror');
      
    }
  }
  

}
