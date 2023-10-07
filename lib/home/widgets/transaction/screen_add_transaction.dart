import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/db/category/category_db.dart';
import 'package:personal_money_managment_app/db/transaction/transaction_db.dart';
import 'package:personal_money_managment_app/model/category_model.dart';
import 'package:personal_money_managment_app/model/transaction_model.dart';

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
  String? _categoryID;
  final _purposeEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finway"),
        backgroundColor: const Color.fromARGB(255, 65, 27, 119),
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
              controller: _purposeEditingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "purpose"),
            ),
            const SizedBox(
              height: 20,
            ),
            //amount
            TextFormField(
              controller: _amountEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "amount"),
            ),
            //calendar
            TextButton.icon(
                style: ButtonStyle(
                    iconColor: MaterialStateColor.resolveWith((states) {
                  return const Color.fromARGB(255, 88, 41, 155);
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
                  } //else {
                  //print(_selectedDate.toString());
                  //}
                  setState(() {
                    _selectedDate = selectedDateTemp;
                  });
                },
                icon: const Icon(Icons.calendar_today_rounded),
                label: Text(
                  _selectedDate == null
                      ? "select date"
                      : _selectedDate.toString(),
                  selectionColor: const Color.fromARGB(255, 88, 41, 155),
                )),
            //income or expense radio buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        fillColor: MaterialStateColor.resolveWith((states) {
                          return const Color.fromARGB(255, 88, 41, 155);
                        }),
                        hoverColor: const Color.fromARGB(255, 88, 41, 155),
                        value: CategoryType.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _categoryID = null;
                          });
                        }),
                    const Text(
                      "Income",
                      selectionColor: Color.fromARGB(255, 88, 41, 155),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        fillColor: MaterialStateColor.resolveWith((states) {
                          return const Color.fromARGB(255, 88, 41, 155);
                        }),
                        hoverColor: const Color.fromARGB(255, 88, 41, 155),
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        }),
                    const Text(
                      "Expense",
                      selectionColor: Color.fromARGB(255, 88, 41, 155),
                    )
                  ],
                ),
              ],
            ),
            //catagory type

            DropdownButton(
              hint: const Text("Select Catagory"),
              value: _categoryID,
              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDb().incomeCategoryListListner
                      : CategoryDb().expenseCategoryListListener)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  onTap: () {
                    //print(e.toString());
                    _selectedCategoryModel = e;
                  },
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (selectedValue) {
                setState(() {
                  _categoryID = selectedValue;
                });
              },
              onTap: () {},
            ),
            ElevatedButton(
              onPressed: () {
                addTransaction();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) {
                  return const Color.fromARGB(255, 88, 41, 155);
                }),
              ),
              child: const Text("submit"),
            )
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final purposeText = _purposeEditingController.text;
    final amountText = _amountEditingController.text;
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }
    // _selectedDate
    //_selectedCategoryType
    //_categoryID
    final model = TransactionModel(
      purpose: purposeText,
      amount: parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );
    await TransactionDb.instance.addTransaction(model);
    Navigator.of(context).pop();
    _purposeEditingController.clear();
    _amountEditingController.clear();
    TransactionDb.instance.refreshUI();
  }
}
