import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  food,
  travel,
  entertainment,
  accomodation,
  shopping,
  healthCare,
}

const categoryRelatedIcon = {
  Category.food: Icons.lunch_dining_rounded,
  Category.accomodation: Icons.home_rounded,
  Category.entertainment: Icons.emoji_emotions_rounded,
  Category.healthCare: Icons.health_and_safety_rounded,
  Category.shopping: Icons.shopping_bag_rounded,
  Category.travel: Icons.time_to_leave_rounded,
};

class ExpenseModel {
  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return formatter.format(date);
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        title: json["title"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
        category: Category.values[json["category"]],
      );

  Map<Object, dynamic> toJson() => {
        "title": title,
        "amount": amount,
        "date": date.toString(),
        "category": category.index,
      };
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses =
            allExpenses.where((item) => item.category == category).toList();

  final Category category;
  final List<ExpenseModel> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final singleExpense in expenses) {
      sum += singleExpense.amount;
    }

    return sum;
  }
}
