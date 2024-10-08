import 'package:calculator/model/button_model.dart';
import 'package:flutter/material.dart';

Color color1 = const Color.fromARGB(255, 229, 190, 255);
Color color2 = const Color.fromARGB(255, 173, 213, 255);
Color color3 = const Color.fromARGB(255, 255, 195, 145);

final buttonData = [
  ButtonModel(val: '0', color: color1, size: 18),
  ButtonModel(val: '00', color: color1, size: 22),
  ButtonModel(val: '.', color: color1, size: 18),
  ButtonModel(val: '=', color: color3, size: 22),
  ButtonModel(val: '3', color: color1, size: 18),
  ButtonModel(val: '2', color: color1, size: 18),
  ButtonModel(val: '1', color: color1, size: 18),
  ButtonModel(val: '÷', color: color2, size: 22),
  ButtonModel(val: '6', color: color1, size: 18),
  ButtonModel(val: '5', color: color1, size: 18),
  ButtonModel(val: '4', color: color1, size: 18),
  ButtonModel(val: '×', color: color2, size: 22),
  ButtonModel(val: '9', color: color1, size: 18),
  ButtonModel(val: '8', color: color1, size: 18),
  ButtonModel(val: '7', color: color1, size: 18),
  ButtonModel(val: '-', color: color2, size: 22),
  ButtonModel(val: 'C', color: color3, size: 18),
  ButtonModel(val: 'DEL', color: color3, size: 18),
  ButtonModel(val: '%', color: color2, size: 22),
  ButtonModel(val: '+', color: color2, size: 22),
];
