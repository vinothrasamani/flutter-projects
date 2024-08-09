import 'package:shopping_app/models/categories_model.dart';

class GroceryModel {
  const GroceryModel({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String itemName;
  final int quantity;
  final CategoriesModel category;
}
