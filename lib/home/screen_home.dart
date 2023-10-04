import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/categories/catagory_add%20_popup.dart';
import 'package:personal_money_managment_app/categories/screen_category.dart';
import 'package:personal_money_managment_app/home/widgets/bottomnavigation.dart';
import 'package:personal_money_managment_app/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> getValueNotifier = ValueNotifier(0);
  final pages = const [ScreenTransactions(), ScreenCategory()];

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
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: getValueNotifier,
              builder: (BuildContext ctx, int updatedIndex, _) {
                return pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (getValueNotifier.value == 0) {
            print("add transaction");
          } else {
            print("add category");
            showCatageoryAddPopup(context);
          }
        },
        backgroundColor: const Color.fromARGB(255, 43, 207, 18),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
