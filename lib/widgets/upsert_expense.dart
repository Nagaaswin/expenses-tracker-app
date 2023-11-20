import 'package:expenses_tracker_app/enums/category.dart';
import 'package:expenses_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class UpsertExpense extends StatefulWidget {
  const UpsertExpense({super.key, required this.upsertExpense, this.expense});

  final void Function(Expense expense) upsertExpense;
  final Expense? expense;

  @override
  State<UpsertExpense> createState() {
    return _UpsertExpenseState();
  }
}

class _UpsertExpenseState extends State<UpsertExpense> {
  final _titleController = TextEditingController();
  final _expenseAmountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void initState() {
    Expense? expense = widget.expense;
    if (null != expense) {
      _titleController.text = expense.title;
      _expenseAmountController.text = expense.amount.toString();
      _selectedDate = expense.date;
      _selectedCategory = expense.category;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keyBoardInsets = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardInsets + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _expenseAmountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          prefixText: '\$ ', label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? "No date selected"
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    style:
                        TextButton.styleFrom(foregroundColor: Colors.redAccent),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expenses'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _presentDatePicker() async {
    final initialDate =
        widget.expense == null ? DateTime.now() : widget.expense!.date;
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    Expense? expense = widget.expense;
    final enteredAmount = double.tryParse(_expenseAmountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
      return;
    }
    if (expense != null) {
      expense.title = _titleController.text;
      expense.amount = enteredAmount;
      expense.date = _selectedDate!;
      expense.category = _selectedCategory;
    } else {
      expense = Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory);
    }
    widget.upsertExpense(expense);
    Navigator.pop(context);
  }
}
