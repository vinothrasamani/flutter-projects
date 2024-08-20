import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vsd_scheduler/controller/operations.dart';
import 'package:vsd_scheduler/model/schedule.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.item,
  });

  final Schedule item;

  @override
  State<ItemCard> createState() {
    return _ItemCardState();
  }
}

class _ItemCardState extends State<ItemCard> {
  bool check = false;
  @override
  void initState() {
    check = widget.item.ischecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int random() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return Random().nextInt(130);
      }
      return Random().nextInt(55) + 200;
    }

    return Card(
      clipBehavior: Clip.hardEdge,
      color: Color.fromARGB(255, random(), random(), random()),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  key: ValueKey(widget.item.id),
                  value: check,
                  onChanged: (val) async {
                    setState(() {
                      check = val!;
                    });
                    Map<String, dynamic> updatedField = {
                      'ischecked': val,
                    };
                    var res = await Operations()
                        .put('/events/${widget.item.id}', updatedField)
                        .catchError((err) => debugPrint(err));
                    if (res == null) {
                      debugPrint('failed');
                      return;
                    }
                    debugPrint('Success!');
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Spacer(),
                Text(widget.item.createdAt.split('T')[0]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
