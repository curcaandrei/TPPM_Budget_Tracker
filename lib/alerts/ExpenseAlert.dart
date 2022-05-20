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
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text("Choose Date"),
                        )
                      ],
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
                        DateTime now = selectedDate;
                        var weekDay = '';
                        if(now.weekday == 1) {
                          weekDay = 'Monday';
                        } else if(now.weekday == 2) {
                          weekDay = 'Tuesday';
                        } else if(now.weekday == 3) {
                          weekDay = 'Wednesday';
                        } else if(now.weekday == 4) {
                          weekDay = 'Thursday';
                        } else if(now.weekday == 5) {
                          weekDay = 'Friday';
                        } else if(now.weekday == 6) {
                          weekDay = 'Saturday';
                        } else if(now.weekday == 7) {
                          weekDay = 'Sunday';
                        }

                        var monthName = '';
                        switch(now.month){
                          case 1:
                            monthName = 'January';
                            break;
                          case 2:
                            monthName = 'February';
                            break;
                          case 3:
                            monthName = 'March';
                            break;
                          case 4:
                            monthName = 'April';
                            break;
                          case 5:
                            monthName = 'May';
                            break;
                          case 6:
                            monthName = 'June';
                            break;
                          case 7:
                            monthName = 'July';
                            break;
                          case 8:
                            monthName = 'August';
                            break;
                          case 9:
                            monthName = 'September';
                            break;
                          case 10:
                            monthName = 'October';
                            break;
                          case 11:
                            monthName = 'November';
                            break;
                          case 12:
                            monthName = 'December';
                            break;
                        }
                        box.add({
                          'expense': expenseController.text,
                          'amount': amountController.text,
                          'category': global_category,
                          'date': {
                            'day': selectedDate.day,
                            'month': selectedDate.month,
                            'year': selectedDate.year,
                            'week_day': weekDay,
                            'month_name': monthName,
                          }
                        });
                        selectedDate = DateTime.now();
                        Navigator.of(context).pop();
                        global_category = "Other";
                        day = 'None';
                        month = 'None';
                        year = '';
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

_selectDate(BuildContext context) async {
  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2010),
    lastDate: DateTime(2025),
  );
  selectedDate = selected!;
}