import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            color: Theme.of(context).colorScheme.error.withOpacity(0.3),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseCard(
          dataItem: expenses[index],
        ),
      ),
    );
  }
}
