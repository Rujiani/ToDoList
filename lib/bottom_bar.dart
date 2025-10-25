import 'package:flutter/material.dart';

class BottomTextBar extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback? onPressed;
  final FocusNode focusNode;
  const BottomTextBar({
    super.key,
    required this.textController,
    this.onPressed,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: textController,
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Add new task',
                  fillColor: Theme.of(context).colorScheme.inversePrimary,
                  filled: true,
                ),
              ),
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.add_task),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
