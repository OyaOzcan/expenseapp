import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenseapp/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime selectedDate = DateTime.now();
  late Category selectedCategory = Category.food; // Default category

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _nameController,
          maxLength: 50,
          decoration: const InputDecoration(labelText: "Expense Name"),
        ),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Amount", prefixText: "₺"),
        ),
        IconButton(
          onPressed: () {
            _selectDate(context);
          },
          icon: const Icon(Icons.calendar_today),
        ),
        const Text("Select Date"),
        Text(
          'Date: ${DateFormat.yMd().format(selectedDate)}',
        ),
        const SizedBox(height: 20),
        DropdownButton<Category>(
          value: selectedCategory,
          onChanged: (Category? newValue) {
            if (newValue != null) {
              setState(() {
                selectedCategory = newValue;
              });
            }
          },
          items: Category.values.map<DropdownMenuItem<Category>>((Category category) {
            return DropdownMenuItem<Category>(
              value: category,
              child: Text(category.toString().split('.').last),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Expense newExpense = Expense(
              name: _nameController.text,
              price: double.parse(_amountController.text),
              date: selectedDate,
              category: selectedCategory,
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
