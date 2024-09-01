import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_store/model/products_model.dart';
import 'package:mobile_store/view/category_details.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context) {
    Color fontColor = const Color.fromARGB(255, 47, 0, 109);

    TextStyle style(double size, Color color) {
      return TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      );
    }

    int random() {
      return Random().nextInt(30) + 180;
    }

    return LayoutBuilder(
      builder: (contex, constraints) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => CategoryDetails(product: product),
            ),
          );
        },
        child: Card(
          color: Color.fromARGB(255, random(), random(), random()),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Image.network(
                    product.image,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth - 120,
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: fontColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth - 120,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '\$ ${product.price}',
                              style: style(18, Colors.white),
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: fontColor,
                            ),
                            label: Text(
                              product.rating.rate.toString(),
                              style: style(16, fontColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
