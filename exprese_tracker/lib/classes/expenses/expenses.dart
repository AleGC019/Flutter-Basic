import 'package:exprese_tracker/classes/expenses/expenses_list.dart';
import 'package:exprese_tracker/classes/expenses/widget/addingexpense.dart';
import 'package:exprese_tracker/classes/expenses/widget/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/expense.dart';


class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState(){
    return _ExpensesState();
  }

}

class _ExpensesState extends State<Expenses>{

  var _orderPriority = Priority.HIGH;

  //Dummy expenses
  final List<Expense> _expenses = [
    Expense(
      title: 'Lincense for Apple',
      amount: 100.00,
      date: DateTime.now(),
      category: CategoryEx.WORK,
      priority: Priority.HIGH,
    ),
    Expense(
      title: 'Hamburguer',
      amount: 5.00,
      date: DateTime.now(),
      category: CategoryEx.FOOD,
      priority: Priority.HIGH,
    ),
    Expense(
      title: 'Gasolina',
      amount: 20.00,
      date: DateTime.now(),
      category: CategoryEx.TRANSPORT,
      priority: Priority.LOW,
    ),
  ];

  void _openAddExpenseForm(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => AddingExpense(
        onAddExpense: _addExpense
        ),
      );
  }

  void _addExpense(Expense newExpense){
    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
          content: const Text(
            'Expense removed',
          ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              _expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _changeOrder(){
    setState(() {
      _expensesSorted;
    });
  }

  List<Expense> get _expensesSorted {
    final sortedExpenses = List.of(_expenses);
    sortedExpenses.sort((a, b) {
      if (_orderPriority == Priority.HIGH) {
        // If orderPriority is HIGH, sort in descending order of priority
        return b.priority.index.compareTo(a.priority.index);
      } else if (_orderPriority == Priority.MEDIUM) {
        // If orderPriority is MEDIUM, sort in such a way that medium priority expenses come first
        if (a.priority == Priority.MEDIUM && b.priority != Priority.MEDIUM) {
          return -1;
        } else if (b.priority == Priority.MEDIUM && a.priority != Priority.MEDIUM) {
          return 1;
        } else {
          return a.priority.index.compareTo(b.priority.index);
        }
      } else {
        // If orderPriority is LOW, sort in such a way that low priority expenses come first
        if (a.priority == Priority.LOW && b.priority != Priority.LOW) {
          return -1;
        } else if (b.priority == Priority.LOW && a.priority != Priority.LOW) {
          return 1;
        } else {
          return a.priority.index.compareTo(b.priority.index);
        }
      }
    });
    return sortedExpenses;
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No expenses found yet',
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if(_expenses.isNotEmpty){
      mainContent = ExpensesList(
        key: ObjectKey(_expenses),
        expenses: _expensesSorted,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Expenses tracker',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chart(expenses: _expenses),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Ordernar por prioridad:',
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      DropdownButton(
                        alignment: Alignment.center,
                        value: _orderPriority,
                        items: Priority.values.map(
                              (prioridad) => DropdownMenuItem(
                            value: prioridad,
                            child: Text(
                              textAlign: TextAlign.center,
                              prioridad.toString().split('.').last.toUpperCase(),
                              style: GoogleFonts.lato(
                                fontSize: 13,
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
                            _orderPriority = value;
                            _changeOrder();
                          });
                        },
                      ),
                    ],
                  ),
                )
              ),
              const SizedBox(height: 10),
              Expanded(
                child: mainContent,
              ),
            ],
          )
        ),
      ),
    );
  }
}