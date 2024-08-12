import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/Database/Habit_Database.dart';
import 'package:minimal_habit_tracker/Model/habit_model.dart';
import 'package:minimal_habit_tracker/Provider/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../Component/habit_Tile.dart';
import '../../Component/heat_map.dart';
import '../../Utils/habit_util.dart';

var txtHabit = TextEditingController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void initState() {
  @override
  void initState() {
    super.initState();
    //read existing habits on app startup

    Provider.of<HabitDatabase>(context, listen: false).ReadHabits();
  }

  void CreateNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: txtHabit,
          decoration: const InputDecoration(hintText: 'Create a New Habit'),
        ),
        actions: [
          // MaterialBanner(content: content, actions: actions)
          // MaterialButton(
          //   onPressed: () {
          //     //get the new habit name
          //     String newHabitName = txtHabit.text;
          //     //save to db
          //     context.read<HabitDatabase>().AddHabit(newHabitName);
          //     //save to db
          //     Navigator.pop(context);
          //     //clear controller
          //     txtHabit.clear();
          //   },
          //   child: Text('Save'),
          // ),
          // MaterialButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //     txtHabit.clear();
          //   },
          //   child: Text('Cancel'),
          // ),
          ElevatedButton(
            onPressed: () {
              //get the new habit name
              String newHabitName = txtHabit.text;
              //save to db
              context.read<HabitDatabase>().AddHabit(newHabitName);
              //save to db
              Navigator.pop(context);
              //clear controller
              txtHabit.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: const Size(100, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: .75),
            ), // Button ka text
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              txtHabit.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: const Size(100, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: .75),
            ), // Button ka text
          ),
        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    //update Habit Completion status
    if (value != null) {
      context.read<HabitDatabase>().UpdateHabitComplition(habit.id, value);
    }
  }

  //edit Habit box
  void editHabitBox(Habit habit) {
    //see the controller's text to the habits current name
    txtHabit.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: txtHabit,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              //get the new habit name
              String newHabitName = txtHabit.text;
              //save to db
              context
                  .read<HabitDatabase>()
                  .UpdateHabitName(habit.id, newHabitName);
              //save to db
              Navigator.pop(context);
              //clear controller
              txtHabit.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: const Size(100, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: .75),
            ), // Button ka text
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              txtHabit.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: const Size(100, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: .75),
            ), // Button ka text
          ),
        ],
      ),
    );
  }

  //delete habit box
  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure want to delete ?'),
        actions: [
          //delete button
          ElevatedButton(
            onPressed: () {
              //save to db
              context.read<HabitDatabase>().DeleteHabit(habit.id);
              //save to db
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: const Size(100, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: .75),
            ), // Button ka text
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              txtHabit.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              minimumSize: const Size(100, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: .75),
            ), // Button ka text
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProviderTrue =
        Provider.of<ThemeProvider>(context, listen: true);
    ThemeProvider themeProviderFalse =
        Provider.of<ThemeProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          onPressed: CreateNewHabit,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Habits'),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Switch.adaptive(
                value: themeProviderTrue.isDarkMode,
                onChanged: (value) => themeProviderFalse.toggleTheme(),
              ),
            ),
            // ToggleSwitch(changeOnTap:  themeProviderTrue.isDarkMode,
            //   minWidth: 60.0,
            //   minHeight: 40.0,
            //   initialLabelIndex: 0,
            //   cornerRadius: 20.0,
            //   activeFgColor: Colors.white,
            //   inactiveBgColor: Colors.grey,
            //   inactiveFgColor: Colors.white,
            //   totalSwitches: 2,
            //   icons: [
            //     // FontAwesomeIcons.lightbulb,
            //     // FontAwesomeIcons.solidLightbulb,
            //     Icons.dark_mode,
            //     Icons.sunny,
            //   ],
            //   iconSize: 30.0,
            //   activeBgColors: [
            //     [Colors.black45, Colors.black26],
            //     [Colors.yellow, Colors.orange]
            //   ],
            //   animate: true,
            //   // with just animate set to true, default curve = Curves.easeIn
            //   curve: Curves.bounceInOut,
            //   // animate must be set to true when using custom curve
            //   onToggle: (index) {
            //     print('switched to: $index');
            //     themeProviderFalse.toggleTheme();
            //   },
            // ),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Switch(
              value: themeProviderTrue.isDarkMode,
              onChanged: (value) => themeProviderFalse.toggleTheme(),
            ),
          ),
        ),
        body: ListView(
          children: [
            // Heatmap
            buildHabitMap(),
            // HeatList
            buildHabitList(),
          ],
        ),
      ),
    );
  }

  Widget buildHabitList() {
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();
    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabit;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        //get each individual habit
        final habit = currentHabits[index];
        //   check if the habit is the completed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        return HabitTile(
          text: habit.name,
          isCompleted: isCompletedToday,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
        );
      },
    );
  }

  Widget buildHabitMap() {
    //habit database
    final habitDatabase = context.watch<HabitDatabase>();
    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabit;
    //return heat map ui

    return FutureBuilder(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        //once the data is available => build heatmap
        if (snapshot.hasData) {
          return MyHeatMap(
            startDate: snapshot.data!,
            datasets: prepareHeatMapDataset(currentHabits),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
