import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sphoppinglist/models/groceryitem.dart';

import '../../data/categories.dart';
import '../../models/category.dart';

import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _enteredCategory = categories[Categories.vegetables]!;

  var _isSending = false;

  final _formKey = GlobalKey<FormState>();

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSending = true;
      });

      final url = Uri.https('flutter-proyect-81994-default-rtdb.firebaseio.com',
          'shopping-list.json');

      try{

        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(
            {
              'name': _enteredName,
              'quantity': _enteredQuantity,
              'category': _enteredCategory.title,
            },
          ),
        );

        //Error
        if (response.statusCode >= 400) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add item: ${response.body}'),
            ),
          );
          return;
        }

        //Success
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: const Text('Item added successfully'),
            ),
          );

          if (!context.mounted) {
            return;
          }

          Navigator.of(context).pop(GroceryItem(
            id: responseData['name'],
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _enteredCategory,
          ));
        }

        /*
      Navigator.of(context).pop(GroceryItem(
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _enteredCategory));
       */
      }catch (error){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add item'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Item',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Please enter a name, between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: TextFormField(
                        maxLength: 5,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        initialValue: '1',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Should be greater than 0';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        hint: const Text('Category'),
                        value: _enteredCategory,
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: category.value.color,
                                        width: 10,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    category.value.title,
                                    style: TextStyle(
                                      color: category.value.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _enteredCategory = value!;
                          });
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSending
                          ? null
                          : () {
                              _formKey.currentState!.reset();
                            },
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(

                      onPressed: _isSending
                          ? null
                          : () {
                              _saveItem();
                            },
                      child: _isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator())
                          : const Text('Save'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
