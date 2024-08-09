import 'package:flutter/material.dart';
import 'package:shopping_app/models/categories_model.dart';

const categoryItems = {
  Categories.vegetables: CategoriesModel(
    categoryTitle: 'vegetables',
    itemColor: Color.fromARGB(255, 2, 160, 12),
  ),
  Categories.fruit: CategoriesModel(
    categoryTitle: 'fruit',
    itemColor: Color.fromARGB(255, 2, 160, 126),
  ),
  Categories.meat: CategoriesModel(
    categoryTitle: 'meat',
    itemColor: Color.fromARGB(255, 160, 131, 2),
  ),
  Categories.dairy: CategoriesModel(
    categoryTitle: 'dairy',
    itemColor: Color.fromARGB(255, 157, 2, 160),
  ),
  Categories.carbs: CategoriesModel(
    categoryTitle: 'carbs',
    itemColor: Color.fromARGB(255, 3, 8, 152),
  ),
  Categories.convenience: CategoriesModel(
    categoryTitle: 'convenience',
    itemColor: Color.fromARGB(255, 2, 115, 160),
  ),
  Categories.hygene: CategoriesModel(
    categoryTitle: 'hygene',
    itemColor: Color.fromARGB(255, 160, 2, 136),
  ),
  Categories.sweets: CategoriesModel(
    categoryTitle: 'sweets',
    itemColor: Color.fromARGB(255, 130, 195, 0),
  ),
  Categories.spices: CategoriesModel(
    categoryTitle: 'spices',
    itemColor: Color.fromARGB(255, 160, 2, 99),
  ),
  Categories.other: CategoriesModel(
    categoryTitle: 'other',
    itemColor: Color.fromARGB(255, 160, 57, 2),
  ),
};
