import 'package:flutter/material.dart';
import 'package:explorer/models/Meal.dart';
import 'package:google_fonts/google_fonts.dart';

import 'items/itemmeals.dart';
import 'details/meals_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;


  void selectMeal(BuildContext context, Meal meal){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MealDetailScreen(
        meal: meal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContentMeals = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (context, meal){
          selectMeal(context, meal);
        },
      ),
    );

    if(meals.isEmpty){
      mainContentMeals = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No meals found yet',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
      );
    }

    if(title == null){
      return mainContentMeals;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title!
        ),
      ),
      body: mainContentMeals,
    );
  }
}