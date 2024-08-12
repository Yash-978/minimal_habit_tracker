import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimal_habit_tracker/Model/appSettings.dart';

// import 'package:minimal_habit_tracker/Model/appSettings.g.dart';
import 'package:minimal_habit_tracker/Model/habit_model.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /*
   Setup

  */
  /*INITIALIZE - DATABASE*/
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

// Save first date of app startup (for heatmap)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchData = DateTime.now();
      await isar.writeTxn(
        () => isar.appSettings.put(settings),
      );
    }
  }

// Get first date of startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchData;
  }

/*
  CRUD OPERATION
*/
// List of habits
  final List<Habit> currentHabit = [];

// Create = add new habit
  Future<void> AddHabit(String habitName) async {
    //create new habit
    final newHabit = Habit()..name = habitName;
    //save to database
    await isar.writeTxn(
      () => isar.habits.put(newHabit),
    );
    //re-read from Database
    ReadHabits();
  }

// Read = read saved habit from database
  Future<void> ReadHabits() async {
    //fetch all habits from database
    List<Habit> fetchedHabits = await isar.habits.where().findAll();
    //give this to current habits
    currentHabit.clear();
    currentHabit.addAll(fetchedHabits);
    //updateUi
    notifyListeners();
  }

// update = check habit on and off
  Future<void> UpdateHabitComplition(int id, bool isCompleted) async {
    //find the specific habit
    final habit = await isar.habits.get(id);
    //update completion status
    if (habit != null) {
      await isar.writeTxn(
        () async {
          // if habit completed => add the current data to the completeDays list
          if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
            //today
            final today = DateTime.now();
            //   add the current date if it's not already in the list
            habit.completedDays.add(
              DateTime(today.year, today.month, today.day),
            );
          }
          //if habit is not completed => remove the current date from the list
          else {
            //remove the current date if the habit is marked as not completed
            habit.completedDays.removeWhere(
              (date) =>
                  date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day,
            );
          }
          //save the updated habits back to the database
          await isar.habits.put(habit);
        },
      );
    }
    //re- read from database
    ReadHabits();
  }

// update = edit habit name
  Future<void> UpdateHabitName(int id, String newName) async {
    //find specific habit
    final habit = await isar.habits.get(id);

    //update the habit name
    if (habit != null) {
      //update name
      await isar.writeTxn(
        () async {
          habit.name = newName;
          //save updated habit back to the database
          await isar.habits.put(habit);
        },
      );
      ReadHabits();
    }
    //re- read from database
  }

// delete = delete habit
  Future<void> DeleteHabit(int id) async {
    //perform the delete
    await isar.writeTxn(
      () async {
        await isar.habits.delete(id);
      },
    );
    ReadHabits();
  }
}
