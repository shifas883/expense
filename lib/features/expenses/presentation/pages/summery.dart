import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    final weeklyExpenses = provider.getWeeklySummary();
    final monthlyExpenses = provider.getMonthlySummary();

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.amber[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'Weekly Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.h,),
              ...weeklyExpenses.entries.map(
                (entry) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text('\$${entry.value.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.amber[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'Monthly Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.h,),
              ...monthlyExpenses.entries.map(
                (entry) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text('\$${entry.value.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
