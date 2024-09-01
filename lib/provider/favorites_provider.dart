import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/model/products_model.dart';

class FavoritesProviderNotifier extends StateNotifier<List<Products>> {
  FavoritesProviderNotifier() : super([]);

  bool toggleFavorite(Products product) {
    if (state.contains(product)) {
      state = state.where((item) => product.id != item.id).toList();
      return false;
    } else {
      state = [...state, product];
      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesProviderNotifier, List<Products>>(
  (ref) => FavoritesProviderNotifier(),
);
