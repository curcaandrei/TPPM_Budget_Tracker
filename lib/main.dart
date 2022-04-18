import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tppm_budget_tracker/alerts/ExpenseAlert.dart';

import 'alerts/CategoryAlert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeWidget());
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var buttonText = 'Click Me!';
  int number = 0;
  int number2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Budget Tracker'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(15),
              child: ElevatedButton.icon(
                onPressed: () {
                  addExpenseAlert(context);
                },
                label: const Text('Add expense'),
                icon: const Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 50,
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF44336),
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
              )),
          Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton.icon(
                onPressed: () {
                  addCategoryAlert(context);
                },
                label: const Text('Add category'),
                icon: const Icon(
                  Icons.category,
                  color: Colors.white,
                  size: 50,
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFA26360),
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
              ))
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Expenses',
          ),
        ],
      ),
    );
  }
}