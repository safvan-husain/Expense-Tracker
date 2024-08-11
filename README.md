# Expense Tracker

A new Flutter project.

## Running instruction

1. ensure flutter, android sdk is installed and added to env path.
2. connect mobile device that have enabled usb debugging.
3. run - flutter run from root directory, or the best, use Flutter VS Code extention, and run "run without debugging"

## Report

Effectivly used Clean Archtecture, dependency injection which helped to do unit test effectivly,
Used Bloc to sperate logic, state and UI, compined with GetX, able to use navigation and other dependecies within bloc without BuildContext,
Used SQLite (sqflite dart package) to store the data, created seprate DataBaseHelper function to manage database quries,

used Sizer dart package to effectivly sizing Widget based on mobile size.

used singel Loading indicator which can be managed from everywhere.

Implimented Daily Reminder for daily notification

written unit test for each use case with mocked repository, ensuring respective methods are calling from repositoy and nothing else,
written unit test for each DataModel json serilization,
