import 'package:flutter/material.dart';
import 'package:mobile_store/model/products_model.dart';
import 'package:mobile_store/view/app_home.dart';
import 'package:mobile_store/widgets/item.dart';

class FilteredItems extends StatelessWidget {
  const FilteredItems({super.key, required this.datas, required this.title});

  final List<Products> datas;
  final String title;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('${title[0].toUpperCase()}${title.substring(1)}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const AppHome(),
                ),
              );
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: datas.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width > 550
                ? width > 800
                    ? width > 1050
                        ? width > 1280
                            ? 6
                            : 5
                        : 4
                    : 3
                : 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemBuilder: (ctx, index) {
            return Item(product: datas[index]);
          }),
    );
  }
}
