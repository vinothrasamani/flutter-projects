import 'dart:convert';

List<Schedule> scheduleFromJson(String str) =>
    List<Schedule>.from(json.decode(str).map((x) => Schedule.fromJson(x)));

String scheduleToJson(List<Schedule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Schedule {
  String? id;
  String createdAt;
  String title;
  bool ischecked;

  Schedule({
    this.id,
    required this.createdAt,
    required this.title,
    required this.ischecked,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        createdAt: json["createdAt"],
        title: json["title"],
        ischecked: json["ischecked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "title": title,
        "ischecked": ischecked,
      };
}
