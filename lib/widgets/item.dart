import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_store/model/products_model.dart';
import 'package:mobile_store/provider/favorites_provider.dart';
import 'package:mobile_store/view/category_details.dart';

class Item extends ConsumerWidget {
  const Item({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(product);

    void passDetails() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CategoryDetails(product: product),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: passDetails,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [BoxShadow(spreadRadius: 0.2)],
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.topCenter,
              children: [
                Hero(
                  tag: product.id,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: FadeInImage(
                      placeholder: const AssetImage(
                          'assets/images/preloading_image.png'),
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: IconButton.filled(
                            onPressed: () {
                              ref
                                  .read(favoritesProvider.notifier)
                                  .toggleFavorite(product);
                            },
                            style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: Icon(
                              key: ValueKey(isFavorite),
                              Icons.favorite,
                              color: isFavorite
                                  ? const Color.fromARGB(255, 255, 83, 83)
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      color: const Color.fromARGB(183, 0, 0, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth - 55,
                            child: Text(
                              product.title,
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14,
                          ),
                          Text(
                            product.rating.rate.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
