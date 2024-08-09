import 'package:flutter/material.dart';
import 'package:foods/data/data_instances.dart';
import 'package:foods/models/category_model.dart';
import 'package:foods/models/food_details_model.dart';
import 'package:foods/screens/food_list_screen.dart';
import 'package:foods/widgets/category_grid_items.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availableFoods});
  final List<FoodDetailsModel> availableFoods;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(
        milliseconds: 300,
      ),
      vsync: this,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, CategoryModel category) {
    final matchedItems = widget.availableFoods
        .where((item) => item.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FoodListScreen(
          foods: matchedItems,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 3 / 2,
        ),
        children: [
          for (final category in availableCategory)
            CategoryGridItems(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.2, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        ),
        child: child,
      ),
    );
  }
}
