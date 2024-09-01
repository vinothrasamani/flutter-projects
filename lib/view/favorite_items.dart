import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/provider/favorites_provider.dart';
import 'package:mobile_store/widgets/favorite_list.dart';

class FavoriteItems extends ConsumerStatefulWidget {
  const FavoriteItems({super.key});

  @override
  ConsumerState<FavoriteItems> createState() => _ItemListState();
}

class _ItemListState extends ConsumerState<FavoriteItems> {
  @override
  Widget build(BuildContext context) {
    final favoriteItems = ref.watch(favoritesProvider);
    final width = MediaQuery.of(context).size.width;

    return favoriteItems.isNotEmpty
        ? ListView.builder(
            padding: width > 1000
                ? const EdgeInsets.symmetric(horizontal: 25, vertical: 5)
                : const EdgeInsets.all(5),
            itemCount: favoriteItems.length,
            itemBuilder: (ctx, index) => Dismissible(
              onDismissed: (direction) {
                ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(favoriteItems[index]);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    backgroundColor: Theme.of(context)
                        .appBarTheme
                        .backgroundColor!
                        .withOpacity(0.8),
                    content: Text(
                      '${favoriteItems[index].title} is removed from favorite!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              key: ValueKey(favoriteItems[index]),
              child: FavoriteList(
                product: favoriteItems[index],
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/favorite.png',
                  width: 250,
                ),
                const Text(
                  'Favorite list is empty! Try add something...',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ],
            ),
          );
  }
}
