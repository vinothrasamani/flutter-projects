import 'package:flutter/material.dart';
import 'package:mobile_store/model/products_model.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Hero(
        tag: product.id,
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          height: double.infinity,
          child: Image.network(
            product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
