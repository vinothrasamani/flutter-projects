// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

List<Model> modelFromJson(String str) =>
    List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

String modelToJson(List<Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
  String? id;
  String name;
  int age;
  String address;

  Model({
    this.id,
    required this.name,
    required this.age,
    required this.address,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "address": address,
      };
}
