import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// class HabitTile extends StatelessWidget {
//   final bool isCompleted;
//   final String text;
//   final void Function(bool?)? onChanged;
//   final void Function(BuildContext)? editHabit;
//   final void Function(BuildContext)? deleteHabit;
//
//   const HabitTile({
//     super.key,
//     required this.isCompleted,
//     required this.text,
//     required this.onChanged,
//     required this.editHabit,
//     required this.deleteHabit,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       endActionPane: const ActionPane(
//         motion: StretchMotion(),
//         children: [
//           SlidableAction(
//             onPressed: editHabit,
//             backgroundColor: Colors.grey.shade800,
//             icon: Icons.settings,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           SlidableAction(
//             onPressed: deleteHabit,
//             backgroundColor: Colors.grey.shade800,
//             icon: Icons.settings,
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ],
//       ),
//       child: GestureDetector(
//         onTap: () {
//           //toggle completion status
//           if (onChanged != null) {
//             onChanged!(!isCompleted);
//           }
//         },
//         child: Container(
//           padding: EdgeInsets.all(12),
//           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: isCompleted
//                 ? Colors.green
//                 : Theme.of(context).colorScheme.secondary,
//           ),
//           child: ListTile(
//             title: Text(text),
//             leading: Checkbox(
//               activeColor: Colors.green,
//               onChanged: onChanged,
//               value: isCompleted,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class HabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const HabitTile(
      {super.key,
        required this.isCompleted,
        required this.text,
        required this.onChanged,
        required this.editHabit,
        required this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // edit option
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.grey[800]!,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(10),
            ),

            // delete option
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isCompleted
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary,
            ),
            child: ListTile(
              title: Text(
                text,
                style: TextStyle(
                  color: isCompleted
                      ? Colors.white
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              leading: Checkbox(
                value: isCompleted,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}