import 'dart:convert';

import 'package:expense_tracker/widgets/add_new_expense_overlay.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';
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
  // List<ExpenseModel> _registeredExpenses = [];

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
    setState(() {});
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
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

  @override
  Widget build(context) {
    //---------------------using mediaquery to get the system infos.. mainly width------------------------------

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('VSD Expense Tracker'),
        // actions: [
        //   IconButton.filledTonal(
        //     onPressed: _openAddExpenseOverlay,
        //     icon: const Icon(Icons.add),
        //   ),
        // ],
      ),
      body: sysWidth < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
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
    );
  }
}
