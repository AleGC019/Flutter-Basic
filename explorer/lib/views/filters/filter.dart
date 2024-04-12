import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:explorer/providers/filters_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final activefilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
          children: [
            SwitchListTile(
              title: const Text('Gluten-free'),
              subtitle: const Text('Only include gluten-free meals.'),
              value: activefilters[Filter.glutenFree]!,
              onChanged: (newValue) {
                ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, newValue);
              },
              contentPadding: const EdgeInsets.all(30),
            ),
            SwitchListTile(
              title: const Text('Lactose-free'),
              subtitle: const Text('Only include lactose-free meals.'),
              value: activefilters[Filter.lactoseFree]!,
              onChanged: (newValue) {
                ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, newValue);
              },
              contentPadding: const EdgeInsets.all(30),
            ),
            SwitchListTile(
              title: const Text('Vegetarian'),
              subtitle: const Text('Only include vegetarian meals.'),
              value: activefilters[Filter.vegetarian]!,
              onChanged: (newValue) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, newValue);
              },
              contentPadding: const EdgeInsets.all(20),
            ),
            SwitchListTile(
              title: const Text('Vegan'),
              subtitle: const Text('Only include vegan meals.'),
              value: activefilters[Filter.vegan]!,
              onChanged: (newValue) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegan, newValue);
              },
              contentPadding: const EdgeInsets.all(20),
            ),
          ],
      )
    );
  }
}