import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  String name;

  Category(this.name);
}