import 'dart:io';

import 'package:expense_tracker/features/expense_tracking/data/models/category_model.dart';
import 'package:expense_tracker/features/expense_tracking/data/models/expense_model.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense_tracking/domain/entity/expense_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static String categoryTable = "Categories";
  static String expensesTable = "Expenses";
  // final MyDataBase db;
  final Database _db;
  DatabaseHelper(this._db);

  static Future<Database> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "expense.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static void _onCreate(Database db, int version) async {
    // When creating the db, create the table for expenses.
    await db.execute(
        'CREATE TABLE $expensesTable (id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'category INTEGER,'
        'description TEXT,'
        ' date INTEGER,'
        ' money INTEGER,'
        ' FOREIGN KEY (category) REFERENCES $categoryTable (id)'
        ')');
    // table for storing categories.
    await db.execute(
        'CREATE TABLE $categoryTable (id INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' title TEXT,'
        ' color INTEGER'
        ')');
  }

//instance provider.
  static DatabaseHelper get instance => Get.find<DatabaseHelper>();

  Future<Expense> insertExpense(Expense expense) async {
    print("inserting expense");
    int id = await _db.insert(expensesTable, expense.toMap());
    print("id is $id");
    return expense;
  }

  Future<ExpenseCategory> insertCategory(CategoryModel category) async {
    int id = await _db.insert(categoryTable, category.toMap());
    return CategoryModel(color: category.color, title: category.title, id: id);
  }

  Future<List<ExpenseCategory>> getAllCategory() async {
    var result = await _db.query(categoryTable);
    return result.map((row) => CategoryModel.fromMap(row)).toList();
  }

  Future<List<Expense>> getAllExpenses() async {
    List<Expense> expenses = [];
    List<ExpenseCategory> categoriesResponse = await getAllCategory();
    var result = await _db.query(expensesTable);
    if (result.isNotEmpty) {
      for (Map<String, Object?> element in result) {
        print(element);
        expenses.add(ExpenseModel.fromMap(element, (id) {
          var data = categoriesResponse
              .where((element) => element.id == id)
              .toList()
              .first;
          return CategoryModel(
              color: data.color, title: data.title, id: data.id);
        }));
      }
    }
    return expenses;
  }

  Future<void> deleteExpense(int id) async {
    await _db.delete(expensesTable, where: "id = ?", whereArgs: [id]);
  }

  Future<Expense> editExpenseData(Expense expense) async {
    await _db.update(expensesTable, expense.toMap(),
        where: "id = ?", whereArgs: [expense.id]);
    return expense;
  }
}
