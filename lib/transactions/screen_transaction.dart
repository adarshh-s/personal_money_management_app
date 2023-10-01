import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(15),
        itemBuilder: (ctx, index) {
          return Card(
            color: const Color.fromARGB(255, 80, 232, 83),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const ListTile(
              textColor: Colors.white,
              leading: CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 135, 223, 137),
                foregroundColor: Colors.white,
                child: Text(
                  '30\nsep',
                  textAlign: TextAlign.center,
                ),
              ),
              title: Text('₹ 10000'),
              subtitle: Text('travel'),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 5);
  }
}
