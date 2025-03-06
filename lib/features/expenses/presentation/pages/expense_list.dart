import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../domain/entitles/expense.dart';
import '../providers/expense_provider.dart';
import 'edit_expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? const Center(child: Text('No expenses'))
        : ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 280.w,
                          child: Text(
                            expense.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          spacing: 30.w,
                          children: [
                            Text('\$${expense.amount.toStringAsFixed(2)}'),
                            Text(
                              expense.date.toLocal().toString().split('.')[0],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  PopupMenuButton<int>(
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: 1,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => EditExpensePage(expense: expense),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Edit"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            onTap: () {
                              Provider.of<ExpenseProvider>(
                                context,
                                listen: false,
                              ).deleteExpense(expense.id);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Delete"),
                              ],
                            ),
                          ),
                        ],
                    color: Colors.white,
                    elevation: 2,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10.h);
          },
        );
  }
}
