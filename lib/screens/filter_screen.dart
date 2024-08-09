import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods/provider/filters_provider.dart';
// import 'package:foods/screens/tab_screen.dart';
// import 'package:foods/widgets/main_drawer.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filter Options'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filters.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filters.glutenFree, isChecked);
            },
            title: const Text(
              'Gluten-free',
            ),
            subtitle: const Text(
              'Only include gluten-free foods',
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 20,
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filters.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filters.lactoseFree, isChecked);
            },
            title: const Text(
              'Lactose-free',
            ),
            subtitle: const Text(
              'Only include lactose-free foods',
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 20,
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filters.vegan, isChecked);
            },
            title: const Text(
              'Vegan',
            ),
            subtitle: const Text(
              'Only include Vegan foods',
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 20,
            ),
          ),
          SwitchListTile(
            value: activeFilters[Filters.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilters(Filters.vegetarian, isChecked);
            },
            title: const Text(
              'Vegetarian',
            ),
            subtitle: const Text(
              'Only include vegetarian foods',
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(
              left: 30,
              right: 20,
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
