import 'package:get/get.dart';

class CalcController extends GetxController {
  var display = '0'.obs;
  var ans = '0'.obs;
  bool isOpen = true;

  void addNumber(String num) {
    if (display.value == '0') {
      display.value = num;
    } else {
      display.value += num;
    }
  }

  void addOperator(String operator) {
    if (!display.value.endsWith(operator)) {
      display.value += ' $operator ';
    }
  }

  void clear() {
    display.value = '0';
    ans.value = '0';
  }

  void delete() {
    if (display.value.isEmpty || display.value.length == 1) {
      display.value = '0';
    } else {
      display.value = display.value.substring(0, display.value.length - 1);
    }
  }

  void evaluate() {
    try {
      final expression =
          display.value.replaceAll('×', '*').replaceAll('÷', '/');
      final result = double.parse(evalExpression(expression));
      display.value = result.toString();
      ans.value = display.value;
    } catch (e) {
      ans.value = 'Error';
    }
  }

  String evalExpression(String expr) {
    List<String> tokens = expr.split(' ');
    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      double nextNum = double.parse(tokens[i + 1]);
      if (operator == '+') result += nextNum;
      if (operator == '-') result -= nextNum;
      if (operator == '*') result *= nextNum;
      if (operator == '/') result /= nextNum;
      if (operator == '%') result %= nextNum;
    }
    return result.toString();
  }
}
