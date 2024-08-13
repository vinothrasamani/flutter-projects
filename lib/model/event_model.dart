import 'package:intl/intl.dart';

class EventModel {
  const EventModel({
    required this.eventName,
    required this.eventDate,
    required this.imageURL,
  });

  final String eventName;
  final DateTime eventDate;
  final String imageURL;

  String get formatedDate {
    String formatedDate = DateFormat('EEE, hh:mm a').format(eventDate);
    return '${eventDate.toString().substring(5, 7)} $formatedDate';
  }
}
