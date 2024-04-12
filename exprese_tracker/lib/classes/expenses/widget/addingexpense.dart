import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../models/expense.dart';


class AddingExpense extends StatefulWidget {

  const AddingExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<AddingExpense> createState(){
    return _AddingExpenseState();
  }
}

class _AddingExpenseState extends State<AddingExpense>{

  DateTime? _selectedDate;

  CategoryEx _selectedCategory = CategoryEx.FOOD;

  Priority _selectedPriority = Priority.HIGH;

  final _title = TextEditingController();
  final _amount = TextEditingController();

  Future<void> _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(9999),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _sumbitData(){
    final enteredAmount = double.tryParse(_amount.text);
    final validamount = enteredAmount == null || enteredAmount <= 0;

    if(_title.text.trim().isEmpty || validamount || _selectedDate == null){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter a valid title and amount, or select a date'),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
      );
      return;
    }
    //add expense
    final newExpense = Expense(
      title: _title.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
      priority: _selectedPriority,
    );
    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  void dispose(){
    _title.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints){

      final width = constraints.maxWidth;

      return Padding(
          padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, keyboardSpace + 16.0),
          child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /*
                    if(width >= 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Expanded(
                            child: TextField(
                              controller: _title,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                labelText: 'Title',
                              ),
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                              controller: _amount,
                              decoration: const InputDecoration(
                                prefixText: '\$',
                                labelText: 'Amount',
                              ),
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                        ),

                      ],)
                    */
                    TextField(
                      controller: _title,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextField(
                      controller: _amount,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        labelText: 'Amount',
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Text(
                            _selectedDate == null
                                ? 'No hay fecha elegida'
                                : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(
                              Icons.date_range
                          ),
                          color: _selectedDate == null ? Colors.red : Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Categoria: ',
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                          DropdownButton(
                            value: _selectedCategory,
                            items: CategoryEx.values.map(
                                  (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.toString().split('.').last.toUpperCase(),
                                  style: GoogleFonts.lato(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ).toList(),
                            onChanged: (value){
                              if(value == null){
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        ]
                    ),
                    const SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Prioridad: ',
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              )
                          ),
                          DropdownButton(
                            value: _selectedPriority,
                            items: Priority.values.map(
                                  (prioridad) => DropdownMenuItem(
                                value: prioridad,
                                child: Text(
                                  prioridad.toString().split('.').last.toUpperCase(),
                                  style: GoogleFonts.lato(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ).toList(),
                            onChanged: (value){
                              if(value == null){
                                return;
                              }
                              setState(() {
                                _selectedPriority = value;
                              });
                            },
                          ),
                        ]
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'Cancel ingreso',
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: (){
                              _sumbitData();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              'Agregar ingreso',
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                        ),
                      ],
                    )
                  ],
                ),
              )
          )
      );
    });

  }
}