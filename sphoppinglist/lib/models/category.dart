import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Categories {
  fruit,
  vegetables,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class Category{

  Category({
    required this.title,
    this.color = Colors.white,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final Color color;

}