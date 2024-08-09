import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods/models/food_details_model.dart';
import 'package:foods/provider/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodDetailsScreen extends ConsumerWidget {
  const FoodDetailsScreen({
    super.key,
    required this.foodItem,
  });
  final FoodDetailsModel foodItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredFoods = ref.watch(favoriteFoodsProvider);

    final isAvailable = filteredFoods.contains(foodItem);

    return Scaffold(
      appBar: AppBar(
        title: Text(foodItem.foodTitle),
        actions: [
          IconButton(
            onPressed: () {
              final isAdded = ref
                  .read(favoriteFoodsProvider.notifier)
                  .toggleFavoriteStatus(foodItem);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  content: Text(
                    isAdded
                        ? "${foodItem.foodTitle} is added to your favorites.."
                        : "${foodItem.foodTitle} is removed from your favorites..",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                key: ValueKey(isAvailable),
                Icons.favorite_outlined,
                color: isAvailable
                    ? const Color.fromARGB(255, 199, 0, 0)
                    : const Color.fromARGB(255, 224, 224, 224),
              ),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: foodItem.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(foodItem.imageURL),
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .appBarTheme
                      .foregroundColor!
                      .withGreen(80),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            for (final ingredient in foodItem.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Text(
                  '~  $ingredient',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Steps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .appBarTheme
                      .foregroundColor!
                      .withGreen(80),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            for (final step in foodItem.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Text(
                  '=>  $step',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
