import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tppm_budget_tracker/category/CategoryDropDown.dart';
import 'package:tppm_budget_tracker/models/globals.dart';

addExpenseAlert(context) {
  final expenseController = TextEditingController();
  final amountController = TextEditingController();
  String? selectedFc = "Other";
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title: const Text(
            "Add Expense",
            style: TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter expense here',
                          labelText: 'Expense'),
                          controller: expenseController,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter amount here',
                          labelText: 'Amount'),
                      controller: amountController,
                    ),
                  ),
                  Container(
                    //Add title
                    padding: const EdgeInsets.all(8.0),

                    child: const CategoryDropDown(),
                    alignment: Alignment.center,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        var box = await Hive.openBox('expenses');
                        DateTime now = new DateTime.now();
                        box.add({
                          'expense': expenseController.text,
                          'amount': amountController.text,
                          'category': global_category,
                          'date': {
                            'day': now.day,
                            'month': now.month,
                            'year': now.year
                          }
                        });
                        print(box.values.toList());

                        Navigator.of(context).pop();
                        global_category = "Other";
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        // fixedSize: Size(250, 50),
                      ),
                      child: const Text(
                        "Submit",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}