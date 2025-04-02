import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class AddNewExpenseOverlay extends StatefulWidget {
  const AddNewExpenseOverlay({super.key, required this.onAddExpense});

  final void Function(ExpenseModel newModel) onAddExpense;

  @override
  State<AddNewExpenseOverlay> createState() {
    return _AddNewExpenseOverlay();
  }
}

class _AddNewExpenseOverlay extends State<AddNewExpenseOverlay> {
  // var _titleValue;
  // void _enteredTitle(String title) {
  //   _titleValue = title;
  // }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  Category _selectedCategory = Category.food;

  void _currentDatePicker() async {
    final now = DateTime.now();
    final firstYear = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstYear,
      lastDate: now,
      helpText: "Pick a date to track!",
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final amountValue = double.tryParse(_amountController.text);
    final isAmountValue = amountValue == null || amountValue <= 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountValue ||
        _selectedDate == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          content: const Text(
            'Please provide all the information that are required here..',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Ok',
              ),
            ),
          ],
        ),
      );
      return;
    }
    Navigator.pop(context);
    widget.onAddExpense(ExpenseModel(
        title: _titleController.text,
        amount: amountValue,
        date: _selectedDate!,
        category: _selectedCategory));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constaraints) {
      final deviceWidth = constaraints.maxWidth;
      bool isConditionMet = deviceWidth < 600;

      final title = TextField(
        controller: _titleController,
        maxLength: 50,
        decoration: const InputDecoration(
          labelText: 'Title',
        ),
      );

      final amount = Expanded(
        child: TextField(
          controller: _amountController,
          maxLength: 12,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixText: 'Rs.',
            labelText: 'Amount',
          ),
        ),
      );

      final datePlace = Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _selectedDate == null
                  ? "selected Date"
                  : formatter.format(_selectedDate!),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton.filledTonal(
              onPressed: _currentDatePicker,
              icon: const Icon(Icons.calendar_month_rounded),
            ),
          ],
        ),
      );

      final option = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardTheme.color,
        ),
        child: DropdownButton(
          isExpanded: true,
          value: _selectedCategory,
          items: Category.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.name,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
      );

      return SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 20),
            child: Column(
              children: [
                Text(
                  'Add New Expense',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                isConditionMet
                    ? title
                    : Row(
                        children: [
                          Expanded(child: title),
                          const SizedBox(
                            width: 10,
                          ),
                          amount,
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    isConditionMet ? amount : option,
                    const SizedBox(
                      width: 20,
                    ),
                    datePlace,
                  ],
                ),
                const SizedBox(height: 15),
                isConditionMet ? option : const SizedBox(),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text(
                        'Add New',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
