import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_managment_app/model/category_model.dart';

const categoryDbName = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getcategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDb implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDatabase = await Hive.openBox<CategoryModel>(categoryDbName);
    categoryDatabase.add(value);
  }

  @override
  Future<List<CategoryModel>> getcategories() async {
    final categoryDatabase = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryDatabase.values.toList();
  }
}
