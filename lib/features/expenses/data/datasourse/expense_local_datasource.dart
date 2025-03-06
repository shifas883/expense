import 'package:expense_tracker/features/expenses/domain/entitles/expense.dart';
import 'package:hive/hive.dart';

class ExpenseLocalDataSource {
  static const String _boxName = 'expenses';

  Future<void> addExpense(Expense expense) async {
    final box = await Hive.openBox<Expense>(_boxName);
    await box.put(expense.id, expense);
  }

  Future<List<Expense>> getExpenses() async {
    final box = await Hive.openBox<Expense>(_boxName);
    return box.values.toList();
  }

  Future<void> deleteExpense(String id) async {
    final box = await Hive.openBox<Expense>(_boxName);
    await box.delete(id);
  }
}