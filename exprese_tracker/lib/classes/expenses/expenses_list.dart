import 'package:exprese_tracker/classes/expenses/widget/itemexpense.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {

  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;

  final void Function (Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(
              expenses[index]
          ),
          background: Container(
            color: Colors.red.withOpacity(0.75),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ItemExpense(
              expenses[index]
          ),
      ),
    );
  }
}
