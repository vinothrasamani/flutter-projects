import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';
// import 'package:shopping_app/data/dummy_items.dart';
import 'package:shopping_app/models/grocery_model.dart';
import 'package:shopping_app/widgets/add_new_item.dart';
import 'package:http/http.dart' as http;

class ShoppingListHome extends StatefulWidget {
  const ShoppingListHome({super.key});

  @override
  State<ShoppingListHome> createState() => _ShoppingListHomeState();
}

class _ShoppingListHomeState extends State<ShoppingListHome> {
  List<GroceryModel> _groceryItems = [];
  bool _isloading = true;
  String? err;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https(
      'grocery-v49-default-rtdb.firebaseio.com',
      'grocery-list.json',
    );
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        err = 'Something went wrong, Try again later!';
      });
    }
    if (response.body == 'null') {
      setState(() {
        _isloading = false;
      });
      return;
    }

    Map<String, dynamic> listItems = json.decode(response.body);
    List<GroceryModel> loadedItems = [];
    for (final item in listItems.entries) {
      final category = categoryItems.entries
          .firstWhere(
              (val) => val.value.categoryTitle == item.value['category'])
          .value;
      loadedItems.add(
        GroceryModel(
          id: item.key,
          itemName: item.value['itemName'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItems;
      _isloading = false;
    });
  }

  void _addNew() async {
    final newItem = await Navigator.push<GroceryModel>(
      context,
      MaterialPageRoute(
        builder: (ctx) => const AddNewItem(),
      ),
    );

    if (newItem == null) return;
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryModel item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'grocery-v49-default-rtdb.firebaseio.com/h',
      'grocery-list/${item.id}.json',
    );
    final res = await http.delete(url);

    if (res.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.itemName} is Deleted..'),
      ),
    );
  }

  Widget content = const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.list_alt,
          size: 100,
        ),
        SizedBox(
          height: 20,
        ),
        Text('No items found in a List..'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_groceryItems[index].id),
            background: Container(
              color: Theme.of(context).colorScheme.errorContainer,
              child: const Icon(Icons.delete_outline_outlined),
            ),
            child: ListTile(
              leading: Container(
                margin: const EdgeInsets.all(5),
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _groceryItems[index].category.itemColor,
                ),
              ),
              title: Text(
                _groceryItems[index].itemName,
              ),
              trailing: Text(
                _groceryItems[index].quantity.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            onDismissed: (direction) {
              _removeItem(_groceryItems[index]);
            },
          );
        },
      );
    }

    if (_isloading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (err != null) {
      content = Center(
        child: Text(err!),
      );
      _isloading = false;
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.shopping_bag,
          size: 35,
        ),
        leadingWidth: 50,
        title: const Text(
          "Your Groceries",
        ),
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: _addNew,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
