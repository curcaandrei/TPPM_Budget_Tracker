import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tppm_budget_tracker/alerts/ExpenseAlert.dart';
import 'package:tppm_budget_tracker/alerts/FilterAlert.dart';
import 'package:tppm_budget_tracker/models/globals.dart';

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
      Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  createFilter(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ), child: const Text('Add Filter'),
              )),
          Expanded(
              child:       FutureBuilder<dynamic>(
                  future: getExpenses(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                      itemBuilder: (context2, index) {
                        items = snapshot.data;
                        final item = items[index];
                        if( index == snapshot.data.length-1) {
                          filter_category = 'None';
                          day = 'None';
                          month = 'None';
                          year = '';
                        }

                        var subtitle = "Amount: " + item['amount'].toString() + "€" + "     " + "Category: " + item['category'].toString();
                        var date = item['date']['day'].toString() +
                            "/" +
                            item['date']['month'].toString() +
                            "/" +
                            item['date']['year'].toString();
                        if(item['expense'] == 'No expenses yet'){
                          subtitle = '';
                          date = '';
                        }
                        return ListTile(
                          title: Text(item['expense'].toString()),
                          subtitle:Text(subtitle),
                          trailing: Text(date),
                        );
                      },
                    );
                  }))
        ],
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Budget Tracker'),
        centerTitle: true,
      ),
      body: Center(
          child: _pages.elementAt(selectedIndex)
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
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<List> getExpenses() async {
    var box = await Hive.openBox('expenses');

    var categoriesBox = await Hive.openBox('categories');
    if (!categoriesBox.values.toList().contains('Other')) {
      categoriesBox.add('Other');
    }
    if (!categoriesBox.values.toList().contains('None')) {
      categoriesBox.add('None');
    }

    var result = box.values.toList();
    if( day != 'None') {
      result.removeWhere((item) =>
      item['date']['week_day'].toString() != day);
    }
    print('Day: ' + result.toString());
    if( month != 'None') {
      result.removeWhere((item) =>
      item['date']['month_name'].toString() != month);
    }
    if( year != '') {
      result.removeWhere((item) =>
      item['date']['year'].toString() != year);
    }
    print(filter_category);
    if( filter_category != 'None') {
      result.removeWhere((item) =>
      item['category'].toString() != filter_category);
    }
    if (result.isEmpty){
      result.add({
        'expense': 'No expenses yet',
        'amount': 0,
        'category': 'None',
        'date': {
          'day': 0,
          'month': 0,
          'year': 0,
          'week_day': 'None'
        }
      });
    }
    return result;
  }
}
