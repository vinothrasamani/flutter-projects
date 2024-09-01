import 'package:flutter/material.dart';
import 'package:mobile_store/model/products_model.dart';
import 'package:mobile_store/widgets/category_item.dart';
import 'package:mobile_store/widgets/image_viewer.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color fontColor = theme
        ? const Color.fromARGB(255, 235, 235, 235)
        : const Color.fromARGB(255, 47, 0, 109);

    TextStyle textStyle(double size, Color color) {
      return TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      );
    }

    double paddSize = width > 500
        ? width > 700
            ? width > 800
                ? width > 900
                    ? 70
                    : 50
                : 40
            : 30
        : 25;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ImageViewer(product: product),
                      ),
                    );
                  },
                  child: Hero(
                    tag: product.id,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      height: width > 500
                          ? width > 800
                              ? 380
                              : 340
                          : 300,
                      child: SafeArea(
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  minimum: const EdgeInsets.only(left: 20, top: 5),
                  child: IconButton.filled(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(paddSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    softWrap: true,
                    style: textStyle(20, fontColor).copyWith(
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${product.description[0].toUpperCase()}${product.description.substring(1)}',
                    style: TextStyle(
                      color: fontColor.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '\$ ${product.price}',
                      style: textStyle(20, Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '${product.rating.count} available users!',
                        style: textStyle(15, fontColor),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(Icons.star, color: fontColor, size: 18),
                          Text(
                            product.rating.rate.toString(),
                            style: textStyle(15, fontColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: paddSize, bottom: 10),
              child: Text(
                'Categories',
                style: textStyle(20, fontColor).copyWith(fontFamily: 'serif'),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Category.values.length,
                itemBuilder: (ctx, index) =>
                    CategoryItem(Category.values[index].name, index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
