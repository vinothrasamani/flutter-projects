import 'package:flutter/material.dart';
import 'package:note_book/chart/chart_bar.dart';
import 'package:note_book/models/note_model.dart';

class Chart extends StatelessWidget {
  const Chart(this.noteItem, {super.key});
  final List<NoteModel> noteItem;

  List<Bucket> get buckets {
    return [
      Bucket(noteItem, month: 1),
      Bucket(noteItem, month: 2),
      Bucket(noteItem, month: 3),
      Bucket(noteItem, month: 4),
      Bucket(noteItem, month: 5),
      Bucket(noteItem, month: 6),
      Bucket(noteItem, month: 7),
      Bucket(noteItem, month: 8),
      Bucket(noteItem, month: 9),
      Bucket(noteItem, month: 10),
      Bucket(noteItem, month: 11),
      Bucket(noteItem, month: 12),
    ];
  }

  double get maxMounth {
    double total = 0;
    for (final j in buckets) {
      if (j.count > total) {
        total = j.count;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).cardTheme.color!.withOpacity(0.3),
            Theme.of(context).primaryColor.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      width: double.infinity,
      height: width < 600 ? 200 : double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < buckets.length; i++)
                  ChartBar(
                    fill: buckets[i].count == 0
                        ? 0
                        : buckets[i].count / maxMounth,
                    month: i,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              for (int i = 1; i <= 12; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      i.toString(),
                      style: TextStyle(
                        fontSize: i > 9 ? 10 : 15,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
