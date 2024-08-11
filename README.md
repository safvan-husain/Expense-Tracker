# Expense Tracker

A new Flutter project.

## Running instruction

1. ensure flutter, android sdk is installed and added to env path.
2. connect mobile device that have enabled usb debugging.
3. run - flutter run from root directory, or the best, use Flutter VS Code extention, and run "run without debugging"

## note

1. swipe left Expense Tile to edit, swipe right to delete.

## Report

1. Effectively used Clean Architecture and dependency injection, which helped to do unit test effectively,
2. Used Bloc to sperate logic, state and UI, combined with GetX, able to use navigation and other dependencies within bloc without BuildContext,
3. Used SQLite (sqflite dart package) to store the data, created seprate DataBaseHelper function to manage database quires,
4. used Sizer dart package to effectively sizing Widget based on mobile size.
5. used single Loading indicator which can be managed from everywhere.
6. Implemented Daily Reminder for daily notification
7. used animation for Summary circle, expense tile which can be deleted by swiping it
8. written unit test for each use case with mocked repository, ensuring respective methods are calling from repository and nothing else, written unit test for each Data model for ensuring json sterilization works fine,
