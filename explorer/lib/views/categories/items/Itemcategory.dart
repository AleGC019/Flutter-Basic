import 'package:explorer/models/Category.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


class ItemCategory extends StatelessWidget {
  const ItemCategory({
    super.key,
    required this.category,
    required this.onSelectedCategory,
  });

  final Category category;

  final void Function() onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectedCategory,
      splashColor: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.7),
                category.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
              category.title,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
          )
      ),
    );
  }
}
