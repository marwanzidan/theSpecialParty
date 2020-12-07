import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:TheSpecialParty/constants.dart';
import '../models/categorymodel.dart';


class CategoryService{




 Future<List<Categorymodel>> getListOfCategories() async {
      String url = "$apiurl/client/categories"; 
      final response = await http.get(url,headers: {
        'Accept' : 'application/json'
      });
       List<Categorymodel> tempList = [];


      if(response.statusCode == 200){
        print('hey cat');
        List responseBody = json.decode(response.body)['categories'];
        for(int i = 0; i < responseBody.length; i++){
          tempList.add(Categorymodel.fromJson(responseBody[i]));
        }
      }
      print(tempList);
      print(response.body);
      
     return tempList;
  }
  



}