import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.btnName,
    this.color = const Color.fromARGB(255, 0, 6, 116),
    required this.func,
    required this.icon,
  });

  final String btnName;
  final Future<dynamic> Function() func;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: func,
          style: FilledButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          icon: Icon(icon),
          label: Text(
            btnName,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
