import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum DependentCategory {
  sports,
  food,
  entertainment,
  travel,
  shopping,
  healthCare,
  home,
  work,
  love,
  books,
  friends,
  relatives,
  society,
  nature,
  history,
  technology,
  belives,
  others,
}

const categoryIcon = {
  DependentCategory.sports: Icons.sports_basketball,
  DependentCategory.food: Icons.lunch_dining,
  DependentCategory.entertainment: Icons.movie,
  DependentCategory.travel: Icons.time_to_leave,
  DependentCategory.shopping: Icons.shopify,
  DependentCategory.healthCare: Icons.health_and_safety,
  DependentCategory.home: Icons.home,
  DependentCategory.work: Icons.work,
  DependentCategory.love: Icons.monitor_heart_outlined,
  DependentCategory.books: Icons.book,
  DependentCategory.friends: Icons.emoji_people,
  DependentCategory.relatives: Icons.person_sharp,
  DependentCategory.society: Icons.location_city,
  DependentCategory.nature: Icons.nature,
  DependentCategory.history: Icons.history,
  DependentCategory.technology: Icons.computer,
  DependentCategory.belives: Icons.thumbs_up_down,
  DependentCategory.others: Icons.note_alt_sharp,
};

class NoteModel {
  final String noteTitle;
  final String noteContent;
  final DateTime date;
  final String id;
  final DependentCategory category;

  NoteModel(
      {required this.noteTitle,
      required this.noteContent,
      required this.date,
      required this.category})
      : id = uuid.v4();

  String get formatedDate {
    return formatter.format(date);
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        noteTitle: json["title"],
        noteContent: json["content"],
        date: DateTime.parse(json["date"]),
        category: DependentCategory.values[json["category"]],
      );

  Map<String, dynamic> toJson() => {
        "title": noteTitle,
        "content": noteContent,
        "date": date.toString(),
        "category": category.index,
      };
}

class Bucket {
  Bucket(List<NoteModel> allNotes, {required this.month})
      : notes = allNotes.where((item) {
          String m = item.formatedDate.split('/')[0];
          bool condition = double.tryParse(m) == month;
          return condition;
        }).toList();
  final double month;
  final List<NoteModel> notes;

  double get count {
    double sum = 0;
    // ignore: unused_local_variable
    for (final i in notes) {
      sum += 1;
    }
    return sum;
  }
}
