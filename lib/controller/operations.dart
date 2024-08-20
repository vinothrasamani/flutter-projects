import 'dart:convert';

import 'package:http/http.dart' as http;

class Operations {
  String baseUrl = 'https://66bd98af74dfc195586cfaaf.mockapi.io/api/vsd';
  var client = http.Client();

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var header = {
      'Authorization': 'Bearer sfie328370df83498df=',
      'api_key': 'ief873fj38uf38uf83u83989d7684',
    };
    var response = await client.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) return response.body;
  }

  Future<dynamic> post(String api, dynamic obj) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(obj);
    var header = {
      'Authorization': 'Bearer sfie328370df83498df=',
      "Content-Type": "Application/json",
      'api_key': 'ief873fj38uf38uf83u83989d7684',
    };
    var response = await client.post(
      url,
      body: payload,
      headers: header,
    );
    if (response.statusCode == 201) return response.body;
  }

  Future<dynamic> put(String api, dynamic obj) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(obj);
    var header = {
      'Authorization': 'Bearer sfie328370df83498df=',
      "Content-Type": "Application/json",
      'api_key': 'ief873fj38uf38uf83u83989d7684',
    };
    var response = await client.put(
      url,
      body: payload,
      headers: header,
    );
    if (response.statusCode == 200) return response.body;
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var header = {
      'Authorization': 'Bearer sfie328370df83498df=',
      'api_key': 'ief873fj38uf38uf83u83989d7684',
    };
    var response = await client.delete(
      url,
      headers: header,
    );
    if (response.statusCode == 200) return response.body;
  }
}
