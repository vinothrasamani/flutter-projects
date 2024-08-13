import 'package:intl/intl.dart';

class ClassModel {
  const ClassModel({
    required this.classTitle,
    required this.date,
    required this.name,
    required this.homework,
    required this.imageUrl,
  });

  final String classTitle;
  final DateTime date;
  final String name;
  final bool homework;
  final String imageUrl;

  String get formatedDate {
    String formatedDate = DateFormat('EEE, hh:mm a').format(date);
    bool isToday = date.toString().substring(0, 10) ==
        DateTime.now().toString().substring(0, 10);
    String returnedDate =
        isToday ? 'Today, ${formatedDate.substring(5)}' : formatedDate;
    return returnedDate;
  }
}
