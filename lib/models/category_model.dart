import 'package:flutter/material.dart';

class CategoryModel {
  const CategoryModel(
      {required this.id,
      required this.title,
      this.color = const Color.fromARGB(255, 157, 178, 0)});

  final String id;
  final String title;
  final Color color;
}
