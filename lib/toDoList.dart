import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTask extends StatelessWidget {
  final String task;
  final bool isDone;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? deleteTask;
  final Function(BuildContext?)? editTask;
  final DateTime date;
  const ToDoTask({
    super.key,
    required this.task,
    required this.isDone,
    required this.onChanged,
    this.deleteTask,
    required this.date,
    this.editTask,
  });

  String showDate() {
    var result = '';
    if (date.day < DateTime.now().day) {
      result += ' ${date.day}.${date.month}';
    }
    if (date.year < DateTime.now().year) {
      result += '.${date.year}';
    }
    return '${date.hour}:${(date.minute > 9) ? '${date.minute}' : '0${date.minute}'}$result';
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: editTask,
            icon: Icons.edit,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.onSecondaryFixedVariant,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
            autoClose: true,
          ),
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete,
            backgroundColor: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        color: Theme.of(context).colorScheme.primaryFixedDim,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isDone,
                  onChanged: onChanged,
                  checkColor: Theme.of(context).colorScheme.onPrimary,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                    width: 1.5,
                  ),
                ),
                Flexible(
                  child: Text(
                    task,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationThickness: 2,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: Text(
                'Created at:  ${showDate()}',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
