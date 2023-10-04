import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/db/category/category_db.dart';
import 'package:personal_money_managment_app/model/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (ctx, index) {
                final category = newlist[index];
                return Card(
                  color: const Color.fromARGB(255, 80, 232, 83),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    textColor: Colors.white,
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newlist.length);
        });
  }
}
