import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygene,
  other,
}

class CategoriesModel {
  const CategoriesModel({
    required this.categoryTitle,
    required this.itemColor,
  });

  final String categoryTitle;
  final Color itemColor;
}
