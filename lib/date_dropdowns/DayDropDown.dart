import 'package:flutter/material.dart';

import '../models/globals.dart';

class DayDropDown extends StatefulWidget {
  const DayDropDown({Key? key}) : super(key: key);

  @override
  State<DayDropDown> createState() => _DayDropDownState();
}

class _DayDropDownState extends State<DayDropDown> {
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
          day = newValue!;
          dropdownValue = newValue;
        });
      },
      items: <String>['Monday', 'Thursday', 'Wednesday', 'Tuesday', 'Friday', 'Saturday', 'Sunday', "None"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}