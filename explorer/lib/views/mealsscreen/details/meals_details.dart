import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:explorer/providers/favoritemeals_provider.dart';

import '../../../models/Meal.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,

  });

  final Meal meal;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritemeals = ref.watch(favoriteMealsProvider);

    final isfavorite = favoritemeals.contains(meal);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            meal.title,
          ),
          actions: [
            IconButton(
              onPressed: () {
                final wasAdded = ref.read(favoriteMealsProvider.notifier).toggleFavorite(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(wasAdded ? 'Añadido a favoritos' : 'Eliminado de favoritos'),
                ));
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                    child: child,
                  );
                },
                child: Icon(
                  Icons.star,
                  color: isfavorite ? Colors.amber : Colors.white,
                  key: ValueKey(isfavorite),
                ),
              )
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                  tag: meal.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      meal.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Ingredients',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              for (final ingredients in meal.ingredients)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ingredients,
                        softWrap: true,
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pasos de preparación',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              for (final steps in meal.steps)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    textAlign: TextAlign.justify,
                    steps,
                    softWrap: true,
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}

/*
Expanded(
                child: ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (context, index) => Text(
                    " - ${meal.steps[index]}",
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
*/
