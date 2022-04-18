import 'Category.dart';

class Expense {
  final int id;

  final List<Category> categories;

  final int day;

  final int month;

  final int year;

  Expense(this.id, this.categories, this.day, this.month, this.year);

}