import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelected});
  final void Function(String id) onSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context)
                      .appBarTheme
                      .backgroundColor!
                      .withOpacity(0.3),
                  Theme.of(context)
                      .appBarTheme
                      .backgroundColor!
                      .withOpacity(0.9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.ramen_dining,
                  size: 50,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Cooking Up!',
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: Text(
              'Foods',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelected('foods');
            },
          ),
          ListTile(
            leading: const Icon(Icons.filter_alt),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelected('filters');
            },
          ),
        ],
      ),
    );
  }
}
