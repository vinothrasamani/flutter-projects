import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods/models/food_details_model.dart';

class FavoritesNotifier extends StateNotifier<List<FoodDetailsModel>> {
  FavoritesNotifier() : super([]);

  bool toggleFavoriteStatus(FoodDetailsModel food) {
    final isAvailable = state.contains(food);

    if (isAvailable) {
      state = state.where((item) => item.id != food.id).toList();
      return false;
    } else {
      state = [...state, food];
      return true;
    }
  }
}

final favoriteFoodsProvider =
    StateNotifierProvider<FavoritesNotifier, List<FoodDetailsModel>>((ref) {
  return FavoritesNotifier();
});
