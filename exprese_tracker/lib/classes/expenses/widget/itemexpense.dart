import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/expense.dart';

class ItemExpense extends StatelessWidget {
  const ItemExpense(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              expense.title,
              textAlign: TextAlign.start,
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Monto: \$${expense.amount.toStringAsFixed(2)}',
                      style:GoogleFonts.lato(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          priorityIcons[expense.priority],
                          size: 15,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          expense.priority.toString().split('.').last,
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 15,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          expense.formattedDate,
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          categoryIcons[expense.category],
                          size: 15,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          expense.category.toString().split('.').last,
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}