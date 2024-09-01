import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_store/model/products_model.dart';

class ServicesController {
  String baseUrl = 'https://fakestoreapi.com/products';

  Future<dynamic> getData(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        var data = productsFromJson(response.body);
        debugPrint('Success..');
        return data;
      } else {
        debugPrint('Something went wrong. Try again later!');
      }
    } catch (err) {
      debugPrint('Error Happend! :${err.toString()}');
    }
  }
}
