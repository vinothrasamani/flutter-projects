import 'package:flutter/material.dart';
import 'package:foods/models/food_details_model.dart';
import 'package:foods/screens/food_details_screen.dart';
import 'package:foods/widgets/food_item.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({
    super.key,
    required this.foods,
    this.title,
  });
  final String? title;
  final List<FoodDetailsModel> foods;

  void _selectedItem(BuildContext context, FoodDetailsModel item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodDetailsScreen(
          foodItem: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: foods.length,
      itemBuilder: (ctx, index) => FoodItem(
        foodItem: foods[index],
        selectedItem: () {
          _selectedItem(context, foods[index]);
        },
      ),
    );

    if (foods.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lunch_dining,
              size: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'No item are available now!',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Try something different..',
              style: TextStyle(
                color: Theme.of(context)
                    .appBarTheme
                    .foregroundColor!
                    .withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
