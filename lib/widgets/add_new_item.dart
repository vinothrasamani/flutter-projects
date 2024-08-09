import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';
// import 'package:shopping_app/data/dummy_items.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/models/categories_model.dart';
import 'package:shopping_app/models/grocery_model.dart';
// import 'package:shopping_app/models/grocery_model.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() {
    return _AddNewItemState();
  }
}

class _AddNewItemState extends State<AddNewItem> {
  bool _isSending = false;
  final _border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 220, 220, 220),
    ),
  );
  final _errBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 214, 74, 74),
    ),
  );

  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuatity = 1;
  var _selectedCategory = categoryItems[Categories.vegetables]!;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      //----------------firebase DB------------------
      final url = Uri.https(
        'grocery-v49-default-rtdb.firebaseio.com',
        'grocery-list.json',
      );
      final res = await http.post(
        url,
        headers: {'Content_Type': 'application/json'},
        body: json.encode({
          'itemName': _enteredName,
          'quantity': _enteredQuatity,
          'category': _selectedCategory.categoryTitle,
        }),
      );
      final Map<String, dynamic> decryptedRes = json.decode(res.body);

      if (!context.mounted) return;
      _isSending = false;
      Navigator.of(context).pop(
        GroceryModel(
          id: decryptedRes["name"],
          itemName: _enteredName,
          quantity: _enteredQuatity,
          category: _selectedCategory,
        ),
      );
      //----------------------------------------------
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(
                  label: const Text("Item Name"),
                  enabledBorder: _border,
                  focusedBorder: _border,
                  errorBorder: _errBorder,
                  focusedErrorBorder: _errBorder,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must enter something between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text("Quantity"),
                        enabledBorder: _border,
                        focusedBorder: _border,
                        errorBorder: _errBorder,
                        focusedErrorBorder: _errBorder,
                      ),
                      initialValue: '1',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must enter Quantity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuatity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        enabledBorder: _border,
                        focusedBorder: _border,
                      ),
                      items: [
                        for (final category in categoryItems.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  color: category.value.itemColor,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.categoryTitle),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _selectedCategory = val!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text("Reset"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    child: _isSending
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
