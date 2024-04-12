import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealsTrait extends StatelessWidget {

  const MealsTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
