import 'package:expense_tracker/features/expenses/domain/entitles/expense.dart';
import 'package:expense_tracker/features/expenses/presentation/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/new_button.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Expense',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp
          ),),
        centerTitle: true,
        backgroundColor: Colors.amber[400],
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black.withOpacity(0.2), width: 1)
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLines: 5,
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black.withOpacity(0.2), width: 1)
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLines: 2,
                controller: amountController,
                  keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Amount",
                    border: InputBorder.none),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 20),
            ConfirmButton(
              onTap: () {
                final expense = Expense(
                  id:  Uuid().v4(),
                  description: descriptionController.text,
                  amount: double.parse(amountController.text),
                  date: DateTime.now(),
                );
                Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
                Navigator.pop(context);
              },
              text:'Add Expense',
            ),
          ],
        ),
      ),
    );
  }
}