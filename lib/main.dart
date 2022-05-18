import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tppm_budget_tracker/alerts/ExpenseAlert.dart';

import 'alerts/CategoryAlert.dart';

void main() async {
  //print current path

  runApp(MyApp());
  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path + 'myapp/data');
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
  var _selectedIndex = 0;
  var items;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      Column(
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
      ),
      FutureBuilder<dynamic>(
          future: getExpenses(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              itemBuilder: (context2, index) {
                items = snapshot.data;
                final item = items[index];

                return ListTile(
                  title: Text(item['expense']),
                  subtitle: Text("Amount: " + item['amount'] + "€" + "     " + "Category: " + item['category']),
                  trailing: Text(item['date']['day'].toString() +
                      "/" +
                      item['date']['month'].toString() +
                      "/" +
                      item['date']['year'].toString()),
                );
              },
            );
          }),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Budget Tracker'),
        centerTitle: true,
      ),
      body: Center(
          child: _pages.elementAt(_selectedIndex)
      ),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List> getExpenses() async {
    var box = await Hive.openBox('expenses');
    return box.values.toList();
  }
}
