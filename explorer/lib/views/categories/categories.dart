import 'package:explorer/data/dummy_data.dart';
import 'package:explorer/views/mealsscreen/meals.dart';
import 'package:flutter/material.dart';
import 'package:explorer/views/categories/items/Itemcategory.dart';
import '../../models/Category.dart';
import '../../models/Meal.dart';

class CategoriesScreens extends StatefulWidget{

  const CategoriesScreens({
    super.key,
    required this.avaibleMeals,
  });

  final List<Meal> avaibleMeals;

  @override
  State<CategoriesScreens> createState() => _CategoriesScreensState();
}

class _CategoriesScreensState extends State<CategoriesScreens> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {

    print(category.id);
    final filtered = widget.avaibleMeals.where((meal) => meal.categories.contains(category.id)).toList();

    for (var element in filtered) {
      print(element.title);
    }

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MealsScreen(
        title: category.title,
        meals: filtered,
      ),
    ));

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            //for(final category in availableCategories)
            for (int i = 0; i < availableCategories.length; i++)
              FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        i / availableCategories.length,
                          (i + 1) / availableCategories.length,
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                child: ItemCategory(
                  category: availableCategories[i],
                  onSelectedCategory: () {
                    _selectCategory(context, availableCategories[i]);
                  },
                ),
              ),
            //availableCategories.map((category) => ItemCategory(category: category)).toList(),
          ],
        ),
        builder: (context, child) => SlideTransition(
            position: Tween(
                begin: const Offset(1.5, 0),
                end: const Offset(0, 0),
              ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ),
              ),
            child: child
        ),
    );
  }
}