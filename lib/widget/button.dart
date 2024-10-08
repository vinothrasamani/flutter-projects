import 'package:calculator/controller/calc_controller.dart';
import 'package:calculator/model/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  Button({
    super.key,
    required this.item,
  });
  final ButtonModel item;
  final CalcController controller = Get.put(CalcController());

  @override
  Widget build(BuildContext context) {
    final theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final val = item.val;
    List ops = ['%', '+', '-', '×', '÷'];

    Color btnColor(Color color) {
      if (color == const Color.fromARGB(255, 173, 213, 255)) {
        return const Color.fromARGB(255, 16, 131, 255);
      }
      if (color == const Color.fromARGB(255, 255, 195, 145)) {
        return const Color.fromARGB(255, 201, 90, 0);
      }
      return const Color.fromARGB(255, 127, 0, 211);
    }

    return FilledButton(
      onPressed: () {
        if (val.toLowerCase() == 'c') {
          controller.clear();
        } else if (val == '=') {
          controller.evaluate();
        } else if (val.toLowerCase() == 'del') {
          controller.delete();
        } else if (ops.contains(val)) {
          controller.addOperator(val);
        } else {
          controller.addNumber(val);
        }
      },
      style: FilledButton.styleFrom(
        backgroundColor: theme ? btnColor(item.color) : item.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        item.val,
        style: TextStyle(
            fontSize: item.size, color: theme ? Colors.white : Colors.black),
      ),
    );
  }
}
