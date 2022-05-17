import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({Key? key}) : super(key: key);

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    String? selectedFc = "Other";
    // return DropdownButton<String>(
    //   value: dropdownValue,
    //   elevation: 16,
    //
    //   alignment: Alignment.center,
    //   style: const TextStyle(color: Colors.deepPurple),
    //   underline: Container(
    //     height: 2,
    //     color: Colors.deepPurpleAccent,
    //   ),
    //   onChanged: (String? newValue) {
    //     setState(() {
    //       dropdownValue = newValue!;
    //     });
    //   }
      return FutureBuilder<List<DropdownMenuItem<String>>>(
          future: getCategories(),
          builder: (context, snapshot) {
            return DropdownButton<String>(
                hint: Text("Select"),
                value: selectedFc,
                onChanged: (newValue) {
                  setState(() {
                    selectedFc = newValue.toString();
                  });
                },
                items: snapshot.data?.map((fc) =>
                    DropdownMenuItem<String>(
                      child: fc.child,
                      value: fc.value,
                    )
                ).toList());
          });
  }


  Future<List<DropdownMenuItem<String>>> getCategories() async {
    var box = await Hive.openBox('categories');
    var categories = box.values.toList();
    print(categories);
    return categories.map((category) => DropdownMenuItem<String>(
      child: Text(category),
      value: category,
    )).toList();
  }
}