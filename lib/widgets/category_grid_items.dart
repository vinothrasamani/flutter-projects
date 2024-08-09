import 'package:flutter/material.dart';
import 'package:foods/models/category_model.dart';

class CategoryGridItems extends StatelessWidget {
  const CategoryGridItems({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final CategoryModel category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      borderRadius: BorderRadius.circular(10),
      splashColor:
          Theme.of(context).appBarTheme.foregroundColor!.withOpacity(0.4),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ),
      ),
    );
  }
}
