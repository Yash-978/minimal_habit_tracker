//given habit list of completed days
//is the habit completed today

import '../Model/habit_model.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (date) =>
        date.year == today.year &&
        date.month == date.month &&
        date.day == date.day,
  );
}
//prepare heat map data set
Map <DateTime,int>prepareHeatMapDataset(List<Habit>habits)

{
  Map <DateTime,int >dataset={};
  for (var habit in habits)
    {
      for (var date in habit.completedDays)
        {
          //normalize date to avoid time mismatch
          final normalizedData=DateTime(date.year,date.month,date.day );
          //if the date is already exists in the dataset,increment its count
          if (dataset.containsKey(normalizedData))
            {
              dataset[normalizedData]=dataset[normalizedData]!+1;
            }
          else
            {
              //else initialize it with count of 1
              dataset[normalizedData]=1;
            }


        }
    }
  return dataset;

}
