import 'package:flutter/material.dart';
import 'package:tppm_budget_tracker/models/globals.dart';

class MonthDropDown extends StatefulWidget {
  const MonthDropDown({Key? key}) : super(key: key);

  @override
  State<MonthDropDown> createState() => _MonthDropDownState();
}

class _MonthDropDownState extends State<MonthDropDown> {
  String dropdownValue = 'None';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,

      alignment: Alignment.center,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          month = newValue!;
          dropdownValue = newValue;
        });
      },
      items: <String>['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December', 'None']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}