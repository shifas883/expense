import 'package:expense_tracker/features/expenses/presentation/pages/summery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';
import 'add_expense.dart';
import 'expense_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pocket Track',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp
        ),),
        surfaceTintColor: Colors.amber[400],
        centerTitle: true,
        backgroundColor: Colors.amber[400],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpenseSummary(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text('Expenses', style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                return ExpenseList(expenses: provider.expenses);
              },
            ),
          ),
          SizedBox(height: 10.h,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddExpensePage()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
