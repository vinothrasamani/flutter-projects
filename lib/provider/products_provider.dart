import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/controller/services_controller.dart';
import 'package:mobile_store/model/products_model.dart';

class ProductsProviderNotifier extends StateNotifier<List<Products>> {
  ProductsProviderNotifier() : super([]);
  void loadProducts() async {
    state = await ServicesController().getData('');
  }
}

final productsProvider =
    StateNotifierProvider<ProductsProviderNotifier, List<Products>>(
  (ref) => ProductsProviderNotifier(),
);
