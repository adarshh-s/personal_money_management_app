import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/categories/expense_category_list.dart';
import 'package:personal_money_managment_app/categories/income_category_list.dart';
import 'package:personal_money_managment_app/db/category/category_db.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    CategoryDb().refreshUI();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
            controller: tabController,
            labelColor: const Color.fromARGB(255, 0, 0, 0),
            indicatorColor: const Color.fromARGB(255, 88, 41, 155),
            dividerColor: const Color.fromARGB(255, 9, 9, 9),
            unselectedLabelColor: const Color.fromARGB(255, 205, 201, 201),
            tabs: const <Widget>[
              Tab(text: 'Income'),
              Tab(text: 'Expense'),
            ]),
        Expanded(
          child: TabBarView(
              controller: tabController,
              children: const [IncomeCategoryList(), ExpenseCategoryList()]),
        )
      ],
    );
  }
}
