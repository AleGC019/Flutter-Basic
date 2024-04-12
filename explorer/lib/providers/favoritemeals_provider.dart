import 'package:explorer/models/Meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsProvider extends StateNotifier<List<Meal>>{

  FavoriteMealsProvider() : super([]);

  bool toggleFavorite(Meal meal){

    final mealsIsFavorite = state.contains(meal);

    if(mealsIsFavorite){
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }else{
      state = [...state, meal];
      return true;
    }
  }

}

final favoriteMealsProvider =
  StateNotifierProvider<FavoriteMealsProvider, List<Meal>>((ref){
    return FavoriteMealsProvider();
});
