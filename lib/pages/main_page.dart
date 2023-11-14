import 'package:expenseapp/pages/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/widgets/new_expense.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ExpenseApp'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: const [
                  Color(0xFF6550F3),
                  Color(0xFFD05CD7),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            const ExpenseList(),
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors:[ Color(0xFF6550F3),
                  Color(0xFFD05CD7),]
                  ),
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                    context: context, builder: (ctx) => NewExpense());
                  },
                ),
              ),
            ),
          ],
        ),
      );
  }
}

