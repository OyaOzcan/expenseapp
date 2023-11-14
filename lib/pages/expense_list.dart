import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/widgets/expense_item.dart';
import 'package:expenseapp/widgets/chart.dart';


class ExpenseList extends StatefulWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final List<Expense> expenses = [
    Expense(
        name: "Yiyecek",
        price: 200.524,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        name: "Flutter Udemy Course",
        price: 200,
        date: DateTime.now(),
        category: Category.education),
      Expense(
      name: "Seyahat",
      price: 300,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ]; 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Chart(expenses: expenses),
            Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ExpenseItem(expenses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}