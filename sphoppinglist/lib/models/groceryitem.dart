import 'package:uuid/uuid.dart';
import 'package:sphoppinglist/models/category.dart';

const uuid = Uuid();

class GroceryItem{

  GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final Category category;

}
