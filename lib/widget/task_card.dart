import 'package:flutter/material.dart';
import 'package:progress_tracker/model/data_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.myColor,
    required this.info,
  });

  final DataModel info;
  final Color myColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: myColor,
      child: ListTile(
        title: Text(info.taskName),
        trailing: Text(
          '${info.duration} Hrs',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
