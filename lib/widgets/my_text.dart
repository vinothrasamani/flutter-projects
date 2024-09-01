import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(
      {super.key,
      required this.iconData,
      required this.fontsize,
      required this.value,
      required this.label});

  final IconData iconData;
  final double fontsize;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color fontColor = theme
        ? const Color.fromARGB(255, 235, 235, 235)
        : const Color.fromARGB(255, 47, 0, 109);

    TextStyle style(double val) {
      return TextStyle(
          fontSize: val,
          fontWeight: FontWeight.bold,
          color: fontColor,
          fontFamily: 'serif');
    }

    return Container(
      padding: const EdgeInsets.all(10),
      width: width > 500
          ? width > 800
              ? width > 1000
                  ? width > 1200
                      ? width > 1380
                          ? width * 0.3
                          : width * 0.4
                      : width * 0.5
                  : width * 0.6
              : width * 0.7
          : width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 142, 142, 142),
          width: 2,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: fontColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: style(15).copyWith(
                    color: fontColor.withOpacity(0.6),
                    fontFamily: '',
                  ),
                ),
                Text(
                  value,
                  softWrap: true,
                  style: style(fontsize),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
