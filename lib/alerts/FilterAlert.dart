import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tppm_budget_tracker/date_dropdowns/DayDropDown.dart';
import 'package:tppm_budget_tracker/date_dropdowns/MonthDropDown.dart';

import '../category/CategoryDropDown.dart';
import '../main.dart';
import '../models/globals.dart';

createFilter(context) {
  final yearController = TextEditingController();
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
              "Add Filter",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: 400,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(3.0),
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
                            hintText: 'Year',
                            labelText: 'Year'),
                        controller: yearController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Add title
                      children: [
                        const Text('Day: '),
                        Container(width: 10),
                        const DayDropDown()],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Add title
                      children: const [
                        Text('Month: '),
                        MonthDropDown()],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //Add title
                      children: [
                        const Text('Category: '),
                        Container(width: 12),
                        const CategoryDropDown()],
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeWidget(),
                            ),
                          );
                          year = yearController.text;
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
            )
        );
        });
}
