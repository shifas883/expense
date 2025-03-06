import 'package:expense_tracker/features/expenses/domain/entitles/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';
import '../widgets/new_button.dart';

class EditExpensePage extends StatefulWidget {
  final Expense expense;

  const EditExpensePage({super.key, required this.expense});

  @override
  _EditExpensePageState createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  late TextEditingController descriptionController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController(
      text: widget.expense.description,
    );
    amountController = TextEditingController(
      text: widget.expense.amount.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Expense',
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
                final updatedExpense = Expense(
                  id: widget.expense.id,
                  description: descriptionController.text,
                  amount: double.parse(amountController.text),
                  date: widget.expense.date,
                );
                Provider.of<ExpenseProvider>(
                  context,
                  listen: false,
                ).editExpense(updatedExpense);
                Navigator.pop(context);
              },
              text:'Save Changes',
            ),
          ],
        ),
      ),
    );
  }
}
