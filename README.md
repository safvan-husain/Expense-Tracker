# Expense Tracker

A new Flutter project.

## Running instruction

1. ensure flutter, android sdk is installed and added to env path.
2. connect mobile device that have enabled usb debugging.
3. run - flutter run from root directory, or the best, use Flutter VS Code extention, and run "run without debugging"

## note

1. swipe left Expense Tile to edit, swipe right to delete.

## Report

Effectively used Clean Architecture, dependency injection which helped to do unit test effectively, Used Bloc to sperate logic, state and UI, 
combined with GetX, able to use navigation and other dependencies within bloc without BuildContext, Used SQLite (sqflite dart package) to store the data, 
created seprate DataBaseHelper function to manage database quires,

used Sizer dart package to effectively sizing Widget based on mobile size.

used single Loading indicator which can be managed from everywhere.

Implemented Daily Reminder for daily notification

written unit test for each use case with mocked repository, ensuring respective methods are calling from repository and nothing else, written unit test for each DataModel json sterilization,
