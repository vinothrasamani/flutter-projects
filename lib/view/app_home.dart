import 'package:flutter/material.dart';
import 'package:mobile_store/view/categories.dart';
import 'package:mobile_store/view/favorite_items.dart';
import 'package:mobile_store/view/profile.dart';
import 'package:mobile_store/widgets/bottom_navigation.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int currentIndex = 0;

  void updateCurrentIndex(int indexNo) {
    setState(() {
      currentIndex = indexNo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: Text(
          currentIndex == 0
              ? 'Products'
              : currentIndex == 1
                  ? 'Favorites'
                  : 'Profile',
        ),
        actions: width >= 500
            ? [
                BottomNavigation(
                  updateIndex: updateCurrentIndex,
                  currentIndex: currentIndex,
                ),
                const SizedBox(
                  width: 20,
                ),
              ]
            : [],
      ),
      body: currentIndex == 0
          ? const Categories()
          : currentIndex == 1
              ? const FavoriteItems()
              : const Profile(),
      bottomNavigationBar: width < 500
          ? BottomNavigation(
              updateIndex: updateCurrentIndex,
              currentIndex: currentIndex,
            )
          : null,
    );
  }
}
