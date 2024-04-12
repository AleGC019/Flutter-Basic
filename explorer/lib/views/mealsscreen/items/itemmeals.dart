import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../models/Meal.dart';
import 'meals_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;

  final void Function(BuildContext context, Meal meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: InkWell(
          onTap: () {
            onSelectMeal(context, meal);
          },
          child: Stack(
            children: [
              Hero(
                  tag: meal.id,
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                        meal.imageUrl
                    ),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        style: GoogleFonts.lato(
                          fontSize: 17.5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MealsTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min',
                          ),
                          MealsTrait(
                            icon: Icons.work,
                            label: meal.complexity.toString().split('.')[1].toUpperCase(),
                          ),
                          MealsTrait(
                            icon: Icons.attach_money,
                            label: meal.affordability.toString().split('.')[1].toUpperCase(),
                          ),

                        ],
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        ));
  }
}
