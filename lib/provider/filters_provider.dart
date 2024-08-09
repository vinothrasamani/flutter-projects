import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods/provider/foods_provider.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersProviderNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersProviderNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegan: false,
          Filters.vegetarian: false,
        });

  // void setFiterItems(Map<Filters, bool> choosenFilters) {
  //   state = choosenFilters;
  // }

  void setFilters(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersProviderNotifier, Map<Filters, bool>>(
  (ref) {
    return FiltersProviderNotifier();
  },
);

final filteredFoodProvider = Provider((ref) {
  final activeFilters = ref.watch(filtersProvider);
  return ref.watch(foodProvider).where((item) {
    if (activeFilters[Filters.glutenFree]! && !item.isGlutenFree) {
      return false;
    }

    if (activeFilters[Filters.lactoseFree]! && !item.isLactoseFree) {
      return false;
    }

    if (activeFilters[Filters.vegan]! && !item.isVegan) {
      return false;
    }

    if (activeFilters[Filters.vegetarian]! && !item.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
