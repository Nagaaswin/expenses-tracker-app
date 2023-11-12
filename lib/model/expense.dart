import 'package:expenses_tracker_app/enum/category.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); // constructor initializer
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
