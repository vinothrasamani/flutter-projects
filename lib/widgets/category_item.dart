import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/model/products_model.dart';
import 'package:mobile_store/provider/products_provider.dart';
import 'package:mobile_store/view/filtered_items.dart';

class CategoryItem extends ConsumerWidget {
  const CategoryItem(this.title, this.index, {super.key});

  final String title;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(productsProvider);
    final filteredProductes = data
        .where(
            (item) => item.category.name.toLowerCase() == title.toLowerCase())
        .toList();
    final width = MediaQuery.of(context).size.width;

    int random() {
      return Random().nextInt(150);
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => FilteredItems(
                datas: filteredProductes, title: title.toLowerCase()),
          ),
        );
      },
      child: Container(
        width: width - 100,
        constraints: const BoxConstraints(maxWidth: 350),
        margin: EdgeInsets.only(
          top: 5,
          bottom: 20,
          left: 25,
          right: Category.values.length == index + 1 ? 25 : 0,
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, random(), random(), random()),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(blurRadius: 0.2, color: Color.fromARGB(255, 93, 93, 93)),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title[0] + title.toLowerCase().substring(1),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              '${filteredProductes.length.toString()} products available!',
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
