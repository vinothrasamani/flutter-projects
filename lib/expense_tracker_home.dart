import 'dart:convert';

import 'package:expense_tracker/widgets/add_new_expense_overlay.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseTrackerHome extends StatefulWidget {
  const ExpenseTrackerHome({super.key});
  @override
  State<ExpenseTrackerHome> createState() {
    return _ExpenseTrackerHomeState();
  }
}

class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
  List<ExpenseModel> _registeredExpenses = List.empty(growable: true);
  List<ExpenseModel> copied = List.empty(growable: true);
  DateTime _selectedDate = DateTime.now();
  var size;

  // ---------------------shared_preferences-----------------
  late SharedPreferences sp;

  getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    readExpenses();
  }

  saveExpenses() {
    List<String> expenseList = _registeredExpenses
        .map((expense) => jsonEncode(expense.toJson()))
        .toList();
    sp.setStringList('expensesBox', expenseList);
  }

  readExpenses() {
    List<String>? expenseList = sp.getStringList('expensesBox');
    if (expenseList != null) {
      _registeredExpenses = expenseList
          .map((expense) => ExpenseModel.fromJson(json.decode(expense)))
          .toList();
    }
    copied = _registeredExpenses;
    setState(() {});
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  double totalExpense() {
    double total = 0;
    for (var expense in _registeredExpenses) {
      if (expense.date.month == _selectedDate.month &&
          expense.date.year == _selectedDate.year) {
        total += expense.amount;
      }
    }
    return total;
  }

  //---------------------------------------------------------

  void addNewExpense(ExpenseModel newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
    saveExpenses();
  }

  void removeExpense(ExpenseModel newExpense) {
    final expenseIndex = _registeredExpenses.indexOf(newExpense);
    setState(() {
      _registeredExpenses.remove(newExpense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        content: Text(
          '${newExpense.title} Expense Deleted!',
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        action: SnackBarAction(
            label: 'Undo',
            backgroundColor:
                Theme.of(context).appBarTheme.backgroundColor!.withGreen(110),
            textColor: const Color.fromARGB(255, 255, 255, 255),
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, newExpense);
                saveExpenses();
              });
            }),
      ),
    );
    saveExpenses();
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddNewExpenseOverlay(
        onAddExpense: addNewExpense,
      ),
    );
  }

  void search(String? value) {
    if (value == null || value.isEmpty) {
      _registeredExpenses = copied;
    } else {
      _registeredExpenses = _registeredExpenses
          .where((expense) =>
              expense.title.toLowerCase().contains(value.toLowerCase()) ||
              expense.category
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  Future<void> pickYearMonth(BuildContext context) async {
    final now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedDate = picked;
    }
    setState(() {});
  }

  List<Widget> _widgets() => [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.timer_rounded,
                color: Colors.white,
                size: 16,
              ),
              Text(
                ' |  ${DateFormat('MMM yyyy').format(_selectedDate)}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        size.height > size.width
            ? const SizedBox(height: 10)
            : const SizedBox(width: 10),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              'Total Expenses = ₹${totalExpense()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 10),
            if (size.height > size.width) const Spacer(),
            GestureDetector(
              onTap: () {
                pickYearMonth(context);
              },
              child: const Icon(
                Icons.calendar_month,
                color: Colors.white,
              ),
            ),
            if (size.height < size.width) const SizedBox(width: 10),
          ],
        ),
      ];

  @override
  Widget build(context) {
    //---------------------using mediaquery to get the system infos.. mainly size------------------------------

    final sysWidth = MediaQuery.of(context).size.width;
    //----------------------------------------------------------------------------------------------------------

    final Widget selectedWidget;
    if (_registeredExpenses.isEmpty) {
      selectedWidget = const Center(
        child: Text('Expense list is empty!, Try add new Expenses.'),
      );
    } else {
      selectedWidget = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }

    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('VSD Expense Tracker'),
        actions: size.width > size.height ? _widgets() : [],
      ),
      body: sysWidth < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Theme.of(context)
                          .appBarTheme
                          .backgroundColor!
                          .withAlpha(220),
                      contentPadding: const EdgeInsets.all(1),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: search,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: selectedWidget,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: selectedWidget,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: size.height > size.width
          ? Container(
              padding: const EdgeInsets.all(15),
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _widgets(),
              ),
            )
          : null,
    );
  }
}
