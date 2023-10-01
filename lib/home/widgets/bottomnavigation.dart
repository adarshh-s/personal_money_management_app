import 'package:flutter/material.dart';
import 'package:personal_money_managment_app/home/screen_home.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.getValueNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
            selectedItemColor: const Color.fromARGB(255, 43, 207, 18),
            unselectedItemColor: Colors.grey,
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.getValueNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'category',
              ),
            ]);
      },
    );
  }
}
