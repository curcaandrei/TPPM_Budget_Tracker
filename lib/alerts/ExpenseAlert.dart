import 'package:flutter/material.dart';
import 'package:tppm_budget_tracker/category/CategoryDropDown.dart';

addExpenseAlert(context) {
  String dropdownValue = 'One';
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
                    child: const TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter expense here',
                          labelText: 'Expense'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter amount here',
                          labelText: 'Amount'),
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
                      onPressed: () {
                        Navigator.of(context).pop();
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