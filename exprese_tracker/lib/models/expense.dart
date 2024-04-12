import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum CategoryEx{
  PERSONAL,
  FOOD,
  TRANSPORT,
  WORK
}

enum Priority{
  LOW,
  MEDIUM,
  HIGH
}

const categoryIcons = {
  CategoryEx.PERSONAL: Icons.person,
  CategoryEx.FOOD: Icons.fastfood,
  CategoryEx.TRANSPORT: Icons.directions_car,
  CategoryEx.WORK: Icons.work
};

const priorityIcons = {
  Priority.LOW: Icons.low_priority,
  Priority.MEDIUM: Icons.density_medium,
  Priority.HIGH: Icons.priority_high
};

class Expense{

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.priority
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryEx category;
  final Priority priority;

  //Format date
  String get formattedDate{
    return formatter.format(date);
  }

}

class ExpenseBucket{

  ExpenseBucket({
    required this.category,
    required this.expenses
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((element) => element.category == category).toList();

  final CategoryEx category;
  final List<Expense> expenses;

  double get totalExpenses{
    double suma = 0;

    for(final expense in expenses){
      suma += expense.amount;
    }

    return suma;
  }
}

