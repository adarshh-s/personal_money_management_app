import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          return ListView.separated(
              padding: const EdgeInsets.all(15),
              //values
              itemBuilder: (ctx, index) {
                final values = newList[index];
                return Slidable(
                  key: Key(values.id!),
                  startActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDb.instance.deleteTransaction(values.id!);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'delete',
                    )
                  ]),
                  child: Card(
                    color: const Color.fromARGB(255, 88, 41, 155),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      textColor: Colors.white,
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: values.type == CategoryType.income
                            ? const Color.fromARGB(255, 36, 170, 40)
                            : const Color.fromARGB(255, 192, 41, 31),
                        foregroundColor: Colors.white,
                        child: Text(
                          parseDate(values.date),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      title: Text('₹ ${values.amount}'),
                      subtitle: Text(values.purpose),
                      trailing: Text(values.category.name),
                    ),
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
