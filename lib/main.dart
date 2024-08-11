import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:expense_tracker/core/notification/notification_controller.dart';
import 'package:expense_tracker/core/theme.dart';
import 'package:expense_tracker/features/expense_tracking/data/data_source/expense_local_data_source.dart';
import 'package:expense_tracker/features/expense_tracking/data/repository/expense_repository.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/create_new_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/create_new_expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/delete_expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/edit_expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_all_category.dart';
import 'package:expense_tracker/features/expense_tracking/domain/use_case/get_expense_history.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/create_expense/bloc/create_expense_cubit.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/bloc/expense_bloc.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/view_expenses/expense_page.dart';
import 'package:expense_tracker/features/expense_tracking/presentation/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initNotification();
  NotificationController.notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();

  await NotificationController.scheduleNotification();

  Get.put(DatabaseHelper(await DatabaseHelper.init()));
  ExpenseRepository repository =
      ExpenseRepository(ExpenseLocalDataSource(DatabaseHelper.instance));
  Get.put(CreateExpenseCubit(
    editExpense: EditExpense(expenseRepository: repository),
    createNewCategory: CreateNewCategory(repository),
    createNewExpense: CreateNewExpense(expenseRepository: repository),
    getAllCategory: GetAllCategory(expenseRepository: repository),
  ));
  Get.put(ExpenseCubit(
    deleteExpense: DeleteExpense(expenseRepository: repository),
    getAllExpenses: GetAllExpenses(expenseRepository: repository),
  ));
  ExpenseCubit.instance.loadExpenseHistory();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => CreateExpenseCubit.instance,
      ),
      BlocProvider(
        create: (context) => ExpenseCubit.instance,
      ),
    ],
    child: const MyApp(),
  ));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return OrientationBuilder(builder: (context, orientation) {
        SizerUtil.setScreenSize(constrains, orientation);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.dark,
          builder: (context, child) {
            // loading overlay act as single loading indicator usable by all pages by managing state using [ExpenseCubit]
            return LoadingOverlay(child: child!);
          },
          // home: HomeScreen(),
          home: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: const HomeScreen(),
          ),
        );
      });
    });
  }
}
