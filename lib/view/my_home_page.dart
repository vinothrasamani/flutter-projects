import 'package:calculator/data/button_data.dart';
import 'package:calculator/widget/button.dart';
import 'package:calculator/widget/display.dart';
import 'package:flutter/material.dart';

class Myhomepage extends StatelessWidget {
  const Myhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('VSD Calculator'),
        backgroundColor: theme
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: Column(
            children: [
              Display(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  reverse: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: buttonData.length,
                  itemBuilder: (context, index) => Button(
                    item: buttonData[index],
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
