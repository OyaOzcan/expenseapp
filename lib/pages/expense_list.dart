import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({Key? key}) : super(key: key);

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final List<Expense> expenses = [
    Expense(
      name: "Yiyecek",
      price: 200,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      name: "Flutter Udemy Course",
      price: 200,
      date: DateTime.now(),
      category: Category.education,
    ),
    Expense(
      name: "Seyahat",
      price: 300,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  Map<Category, double> categoryExpenses = {};

  @override
  void initState() {
    super.initState();
    calculateCategoryExpenses();
  }

  void calculateCategoryExpenses() {
    expenses.forEach((expense) {
      categoryExpenses.update(
        expense.category,
        (value) => value + expense.price,
        ifAbsent: () => expense.price,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Pie Chart
          AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                sections: generateSections(),
                borderData: FlBorderData(show: false),
                centerSpaceRadius: 40,
                sectionsSpace: 0,
                centerSpaceColor: Colors.white,
                pieTouchData: PieTouchData(touchCallback: null),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    leading: getCategoryIcon(expenses[index].category),
                    title: Text(
                      expenses[index].name,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${expenses[index].price.toString()}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 4.0), // Add some spacing
                        Text(
                          "Date: ${expenses[index].date.toLocal()}",
                          style: TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> generateSections() {
    List<PieChartSectionData> sections = [];
    double totalAmount = categoryExpenses.values.reduce((a, b) => a + b);

    categoryExpenses.forEach((category, amount) {
      double percentage = (amount / totalAmount) * 100;
      sections.add(
        PieChartSectionData(
          color: getCategoryColor(category),
          value: amount,
          title: '${percentage.toStringAsFixed(2)}%',
          radius: 50,
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        ),
      );
    });

    return sections;
  }

  Color getCategoryColor(Category category) {
    switch (category) {
      case Category.food:
        return Color.fromARGB(255, 101, 80, 243);
      case Category.education:
        return Color.fromARGB(255, 208, 92, 247);
      case Category.travel:
        return Color.fromARGB(255, 255, 146, 120);
      default:
        return Colors.grey;
    }
  }

  Icon getCategoryIcon(Category category) {
    switch (category) {
      case Category.food:
        return Icon(Icons.fastfood, color: getCategoryColor(category));
      case Category.education:
        return Icon(Icons.school, color: getCategoryColor(category));
      case Category.travel:
        return Icon(Icons.flight, color: getCategoryColor(category));
      default:
        return Icon(Icons.help, color: getCategoryColor(category));
    }
  }
}