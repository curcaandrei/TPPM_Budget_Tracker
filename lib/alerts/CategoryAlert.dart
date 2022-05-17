import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tppm_budget_tracker/models/Category.dart';

addCategoryAlert(context) {
  final categoryController = TextEditingController();
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
            "Add Category",
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
                          hintText: 'Enter category here',
                          labelText: 'Category'),
                          controller: categoryController,
                    ),
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
                      child: ElevatedButton(
                        onPressed: () async {
                          Category category = Category(categoryController.text);
                          var box = await Hive.openBox('categories');
                          if (!box.values.toList().contains(category.name)){
                            box.add(category.name);
                          }
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          // fixedSize: Size(250, 50),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
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