import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sphoppinglist/data/categories.dart';

import '../../models/category.dart';
import '../../models/groceryitem.dart';
import '../newitem/new_item.dart';

import 'package:http/http.dart' as http;

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {

  List<GroceryItem> _groceryItems = [];

  var _isLoading = true;

  String? _isError;

  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() async {


    //Getting to data from the server
    final url = Uri.https('flutter-proyect-81994-default-rtdb.firebaseio.com',
        'shopping-list.json');


      final response = await http.get(url);

      if(response.statusCode >= 400) {
           setState(() {
             _isLoading = false;
             _isError = 'Failed to load groceries, fetch failed!';
           });
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_isError!),
           ),
          );
      }

      if(response.body == 'null'){
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final List<GroceryItem> loadedItems = [];

      final Map<String, dynamic> listData = json.decode(response.body);

      for (var element in listData.entries) {

        final defaultCategory = Category(title: 'Default', color: Colors.grey);

        final category = categories.entries
            .firstWhere((cat) => cat.value.title == element.value['category'],
            orElse: () => MapEntry(Categories.meat, defaultCategory))
            .value;


        loadedItems.add(
          GroceryItem(
            id: element.key,
            name: element.value['name'] ?? 'No name',
            quantity: element.value['quantity'] ?? 0,
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });

    }



  void _addItem(BuildContext context) async {

    final newItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (context) => const NewItem(),
    ));

    if(newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeExpense(GroceryItem grocery) async {

    final expenseIndex = _groceryItems.indexOf(grocery);

    setState(() {
      _groceryItems.remove(grocery);
    });

    final url = Uri.https('flutter-proyect-81994-default-rtdb.firebaseio.com',
        'shopping-list/${grocery.id}.json');

    final response = await http.delete(url);


    if(response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(expenseIndex, grocery);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove item: ${response.body}'),
        ),
      );
      return;
    }

    if(response.statusCode == 200) {

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 10),
          content: const Text(
            'Expense removed',
          ),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () async {

              setState(() {
                _isLoading = true;
              });

              final urlrestored = Uri.https('flutter-proyect-81994-default-rtdb.firebaseio.com',
                  'shopping-list.json');

              try {

                final response = await http.post(
                  urlrestored,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: json.encode(
                    {
                      'name': grocery.name,
                      'quantity': grocery.quantity,
                      'category': grocery.category.title,
                    },
                  ),
                );

                if(response.statusCode >= 400) {
                  _isError = 'Failed to add item';
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to add item'),
                    ),
                  );
                  return;
                }

                if(response.statusCode == 200) {
                  setState(() {
                    _isLoading = false;
                    _groceryItems.insert(expenseIndex, grocery);
                  });
                }

              } catch (error) {
                setState(() {
                  _isLoading = false;
                  _isError = 'Something went wrong, fetch failed!';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_isError!),
                  ),
                );
              }
            },
          ),
        ),
      );
    }




  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
      child: Text(
        'No Groceries Yet!',
        style: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );

    if (_groceryItems.isNotEmpty) {
      mainContent = ListView.builder(
            itemCount: _groceryItems.length,
            itemBuilder: (context, index) => Dismissible(
              key: ValueKey(_groceryItems[index]),
              background: Container(
                color: Colors.red.withOpacity(0.75),
              ),
              onDismissed: (direction) {
                _removeExpense(_groceryItems[index]);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  width: 300,
                  height: 75,
                  child: Card(
                    color: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _groceryItems[index].category.color,
                                          width: 10,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      _groceryItems[index].name,
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                )),
                            Text(
                              '${_groceryItems[index].quantity}x',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          );
    }

    if(_isLoading) {
      mainContent = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      );
    }

    if(_isError != null) {
      mainContent = Center(
        child: Text(
          _isError!,
          style: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Groceries',
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context);
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadItem(),
        child: mainContent,
      ),
    );
  }
}
