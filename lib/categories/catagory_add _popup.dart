// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/db/category/category_db.dart';
import 'package:personal_money_managment_app/model/category_model.dart';

ValueNotifier<CategoryType> selectCatagoryNotifier =
    ValueNotifier(CategoryType.income);
final _nameEditingController = TextEditingController();

Future<void> showCatageoryAddPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Center(child: Text("Add catageory")),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "catageory name",
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: ElevatedButton(
                onPressed: () {
                  final name = _nameEditingController.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final _type = selectCatagoryNotifier.value;
                  final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: _type);
                  CategoryDb().insertCategory(category);
                  Navigator.of(ctx).pop();
                  _nameEditingController.clear();
                },
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                    fixedSize: MaterialStatePropertyAll(Size(20, 20))),
                child: const Text("add"),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectCatagoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio(
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectCatagoryNotifier.value = value;
                    selectCatagoryNotifier.notifyListeners();
                  });
            }),
        Text(title)
      ],
    );
  }
}
