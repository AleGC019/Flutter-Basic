import 'package:explorer/models/Meal.dart';
import 'package:explorer/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>>{
  FiltersNotifier() : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilters(Map<Filter, bool> chosenFilters){
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive){
    state = {
      ...state,
      filter: isActive,
    };
  }


}

final filtersProvider =
  StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier()
);

final filteredMealsProvider = Provider<List<Meal>>((ref){
  final meals = ref.watch(mealsProvider);
  final activefilters = ref.watch(filtersProvider);

  return meals.where((element) {
    if(activefilters[Filter.glutenFree]! && !element.isGlutenFree){
      return false;
    }
    if(activefilters[Filter.lactoseFree]! && !element.isLactoseFree){
      return false;
    }
    if(activefilters[Filter.vegan]! && !element.isVegan){
      return false;
    }
    if(activefilters[Filter.vegetarian]! && !element.isVegetarian){
      return false;
    }
    return true;
  }).toList();
});