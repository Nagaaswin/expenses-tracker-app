import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../enums/category.dart';

const Uuid uuid = Uuid();

final formatter = DateFormat.yMd();

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); // constructor initializer
  String id;
  String title;
  double amount;
  DateTime date;
  Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket(this.expenses, this.category);
  final List<Expense> expenses;
  final Category category;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
