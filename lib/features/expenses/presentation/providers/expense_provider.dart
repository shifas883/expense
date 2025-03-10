import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/datasourse/expense_local_datasource.dart';
import '../../domain/entitles/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final ExpenseLocalDataSource _dataSource = ExpenseLocalDataSource();
  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    _expenses = await _dataSource.getExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _dataSource.addExpense(expense);
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    await _dataSource.deleteExpense(id);
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }
  Future<void> editExpense(Expense updatedExpense) async {
    await _dataSource.addExpense(updatedExpense);
    final index = _expenses.indexWhere((e) => e.id == updatedExpense.id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }

  Map<String, double> getWeeklySummary() {
    final Map<String, double> summary = {};
    for (var expense in _expenses) {
      String week = DateFormat('y MMMW').format(expense.date);
      summary[week] = (summary[week] ?? 0) + expense.amount;
    }
    return summary;
  }

  Map<String, double> getMonthlySummary() {
    final Map<String, double> summary = {};
    for (var expense in _expenses) {
      String month = DateFormat('y MMM').format(expense.date);
      summary[month] = (summary[month] ?? 0) + expense.amount;
    }
    return summary;
  }
}