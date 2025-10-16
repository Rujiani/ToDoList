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
    var result = '';
    if (date.day < DateTime.now().day) {
      result += '  ${date.day}.${date.month}';
    }
    if (date.year < DateTime.now().year) {
      result += '.${date.year}';
    }
    return '${date.hour}:${(date.minute > 9) ? '${date.minute}' : '0${date.minute}'}$result';
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
      ),
    );
  }
}
