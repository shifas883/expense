import 'package:expense_tracker/features/expenses/domain/entitles/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme.dart';
import 'features/expenses/presentation/pages/home_page.dart';
import 'features/expenses/presentation/providers/expense_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the Expense adapter
  Hive.registerAdapter(ExpenseAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
    minTextAdapt: false,
    builder: (context, child) {
          return MultiProvider(
          providers: [
          ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );});
  }
}