import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_app/model/event_model.dart';

class FavoritesProviderNotifier extends StateNotifier<List<EventModel>> {
  FavoritesProviderNotifier() : super([]);

  bool toggleFavorite(EventModel item) {
    if (state.contains(item)) {
      state = state.where((card) => card.eventName != item.eventName).toList();
      return false;
    } else {
      state = [...state, item];
      return true;
    }
  }
}

final favoriteProvider =
    StateNotifierProvider<FavoritesProviderNotifier, List<EventModel>>((ref) {
  return FavoritesProviderNotifier();
});
