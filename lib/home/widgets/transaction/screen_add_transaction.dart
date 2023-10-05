import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/db/category/category_db.dart';
import 'package:personal_money_managment_app/model/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finway"),
        backgroundColor: const Color.fromARGB(255, 43, 207, 18),
        centerTitle: true,
        toolbarHeight: 100,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //purpose
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "purpose"),
            ),
            const SizedBox(
              height: 20,
            ),
            //amount
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "amount"),
            ),
            //calendar
            TextButton.icon(
                style: ButtonStyle(
                    iconColor: MaterialStateColor.resolveWith((states) {
                  return const Color.fromARGB(255, 43, 207, 18);
                })),
                onPressed: () async {
                  final selectedDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDate.toString());
                  }
                  setState(() {
                    _selectedDate = selectedDateTemp;
                  });
                },
                icon: const Icon(Icons.calendar_today_rounded),
                label: Text(
                  _selectedDate == null
                      ? "select date"
                      : _selectedDate.toString(),
                  selectionColor: const Color.fromARGB(255, 43, 207, 18),
                )),
            //income or expense radio buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: CategoryType.income,
                        onChanged: (newValue) {}),
                    const Text(
                      "Income",
                      selectionColor: Color.fromARGB(255, 43, 207, 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        fillColor: MaterialStateColor.resolveWith((states) {
                          return const Color.fromARGB(255, 43, 207, 18);
                        }),
                        hoverColor: const Color.fromARGB(255, 43, 207, 18),
                        value: CategoryType.expense,
                        groupValue: CategoryType.income,
                        onChanged: (newValue) {}),
                    const Text(
                      "Expense",
                      selectionColor: Color.fromARGB(255, 43, 207, 18),
                    )
                  ],
                ),
              ],
            ),
            //catagory type

            DropdownButton(
                hint: const Text("Select Catagory"),
                items: CategoryDb().expenseCategoryListListener.value.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (selectedValue) {}),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  return const Color.fromARGB(255, 43, 207, 18);
                }),
              ),
              child: const Text("submit"),
            )
          ],
        ),
      )),
    );
  }
}
