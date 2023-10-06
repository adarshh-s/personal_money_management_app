import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_managment_app/db/category/category_db.dart';
import 'package:personal_money_managment_app/db/transaction/transaction_db.dart';
import 'package:personal_money_managment_app/model/category_model.dart';
import 'package:personal_money_managment_app/model/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refreshUI();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          print("ValueListenableBuilder rebuild"); //debug
          if (newList.isEmpty) {
            print("Transaction list is empty"); // Debug print
            return const Text("No transactions available");
          }
          return ListView.separated(
              padding: const EdgeInsets.all(15),
              //values
              itemBuilder: (ctx, index) {
                final values = newList[index];
                return Card(
                  color: const Color.fromARGB(255, 80, 232, 83),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    textColor: Colors.white,
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundColor: values.type == CategoryType.income
                          ? Colors.green
                          : Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        parseDate(values.date),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    title: Text('₹ ${values.amount}'),
                    subtitle: Text(values.category.name),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length);
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final splitDate = _date.split(' ');
    return '${splitDate.last}\n${splitDate.first}';
  }
}
