import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _expenseAmountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          TextField(
            controller: _expenseAmountController,
            maxLength: 10,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(label: Text('Amount')),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_expenseAmountController.text);
                },
                child: const Text('Save Expenses'),
              ),
              const Spacer(),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(foregroundColor: Colors.redAccent),
                onPressed: () {
                  print('Closing modal');
                },
                child: const Text('Cancel'),
              )
            ],
          )
        ],
      ),
    );
  }
}
