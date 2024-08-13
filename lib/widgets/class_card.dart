import 'package:flutter/material.dart';
import 'package:study_app/model/class_model.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({super.key, required this.item});

  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    TextStyle style(double n) {
      return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: n,
      );
    }

    final Color color =
        Theme.of(context).colorScheme.onSecondary.withOpacity(0.8);

    return Card(
      color: const Color.fromARGB(255, 227, 255, 216),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          left: 26,
          right: 12,
          top: 12,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  child: IconButton.filledTonal(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      backgroundColor: color,
                    ),
                    padding: const EdgeInsets.all(10),
                    icon: Image.asset(
                      'assets/images/calculator.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 6,
                    bottom: 6,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'HomeWork',
                        style: style(15),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        item.homework
                            ? Icons.check_circle
                            : Icons.do_not_disturb_on_rounded,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              item.classTitle,
              style: style(20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              item.formatedDate,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    item.imageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  item.name,
                  style: style(18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
