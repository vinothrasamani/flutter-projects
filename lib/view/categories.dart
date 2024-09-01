import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile_store/model/products_model.dart';
import 'package:mobile_store/provider/products_provider.dart';
import 'package:mobile_store/widgets/item.dart';

class Categories extends ConsumerStatefulWidget {
  const Categories({
    super.key,
  });

  @override
  ConsumerState<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends ConsumerState<Categories> {
  List<Products> availableProducts = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    availableProducts = ref.watch(productsProvider);

    return availableProducts.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: availableProducts.length,
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
              return Item(product: availableProducts[index]);
            });
  }
}
