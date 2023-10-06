// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_managment_app/model/category_model.dart';

const categoryDbName = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getcategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(CategoryModel value);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static final CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> incomeCategoryListListner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDatabase = await Hive.openBox<CategoryModel>(categoryDbName);
    categoryDatabase.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getcategories() async {
    final categoryDatabase = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryDatabase.values.toList();
  }

  Future<void> refreshUI() async {
    incomeCategoryListListner.value.clear();
    expenseCategoryListListener.value.clear();
    final allCategories = await getcategories();
    await Future.forEach(
      allCategories,
      (CategoryModel category) => {
        if (category.type == CategoryType.income)
          {incomeCategoryListListner.value.add(category)}
        else
          {expenseCategoryListListener.value.add(category)}
      },
    );
    incomeCategoryListListner.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(CategoryModel catageory) async {
    final _categoryDatabase = await Hive.openBox<CategoryModel>(categoryDbName);
    await _categoryDatabase.delete(catageory.id);
    refreshUI();
  }
}
