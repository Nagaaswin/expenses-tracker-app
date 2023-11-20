import 'package:expenses_tracker_app/enums/category.dart';
import 'package:expenses_tracker_app/widgets/chart/chart.dart';
import 'package:expenses_tracker_app/widgets/expenses_list/expense_list.dart';
import 'package:expenses_tracker_app/widgets/upsert_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'sample',
        amount: 20.4,
        date: DateTime.now(),
        category: Category.work)
  ];

  void _upsertExpense(Expense expense) {
    setState(() {
      if (!_registeredExpenses.contains(expense)) {
        _registeredExpenses.add(expense);
      }
    });
  }

  void _removeExpense(Expense expense) {
    int indexOfExpense = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Removed!!'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(indexOfExpense, expense);
              });
            }),
      ),
    );
  }

  void openUpsertExpenseOverlay(Expense? expense) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) =>
          UpsertExpense(upsertExpense: _upsertExpense, expense: expense),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget contentToBeDisplayed = const Center(
      child: Text('No Expenses Found!! Start adding some expenses'),
    );
    if (_registeredExpenses.isNotEmpty) {
      contentToBeDisplayed = ExpensesList(
          expenses: _registeredExpenses,
          removeExpense: _removeExpense,
          upsertExpenseOverlay: openUpsertExpenseOverlay);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              openUpsertExpenseOverlay(null);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: contentToBeDisplayed),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: contentToBeDisplayed),
              ],
            ),
    );
  }
}
