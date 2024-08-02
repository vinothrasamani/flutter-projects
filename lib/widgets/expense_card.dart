import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.dataItem});

  final ExpenseModel dataItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataItem.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Rs.${dataItem.amount.toStringAsFixed(2)}",
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryRelatedIcon[dataItem.category]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      dataItem.formatedDate,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
