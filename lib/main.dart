import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/Database/Habit_Database.dart';
import 'package:minimal_habit_tracker/Provider/ThemeProvider.dart';
import 'package:provider/provider.dart';

import 'View/Screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HabitDatabase(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        routes: {
          '/': (context) => const HomePage(),
        },
      ),
    );
  }
}
