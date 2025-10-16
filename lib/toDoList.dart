import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTask extends StatelessWidget {
  final String task;
  final bool isDone;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? deleteTask;
  final DateTime date;
  const ToDoTask({
    super.key,
    required this.task,
    required this.isDone,
    required this.onChanged,
    this.deleteTask,
    required this.date,
  });

  String showDate() {
    var result = '${date.hour}:${date.minute}';
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryFixedDim,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(showDate()),
              Row(
                children: [
                  Checkbox(
                    value: isDone,
                    onChanged: onChanged,
                    checkColor: Theme.of(context).colorScheme.onPrimary,
                    side: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimaryFixedVariant,
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
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
