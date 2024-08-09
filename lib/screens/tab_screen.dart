import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:foods/data/data_instances.dart';
// import 'package:foods/models/food_details_model.dart';
import 'package:foods/provider/favorites_provider.dart';
import 'package:foods/provider/filters_provider.dart';
// import 'package:foods/provider/foods_provider.dart';
import 'package:foods/screens/category_screen.dart';
import 'package:foods/screens/filter_screen.dart';
import 'package:foods/screens/food_list_screen.dart';
import 'package:foods/widgets/main_drawer.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPgaeIndex = 0;

  void _setPage(String id) async {
    Navigator.pop(context);
    if (id == 'filters') {
      await Navigator.push<Map<Filters, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  void _selectedPge(int index) {
    setState(() {
      _selectedPgaeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableFilteredItems = ref.watch(filteredFoodProvider);

    Widget activeScreen = CategoryScreen(
      availableFoods: availableFilteredItems,
    );
    String activePageTitle = 'Pick your Category';

    if (_selectedPgaeIndex == 1) {
      final favorites = ref.watch(favoriteFoodsProvider);
      activeScreen = FoodListScreen(
        foods: favorites,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPgaeIndex,
        selectedItemColor:
            Theme.of(context).appBarTheme.backgroundColor!.withGreen(150),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: _selectedPge,
      ),
      drawer: MainDrawer(
        onSelected: _setPage,
      ),
    );
  }
}
