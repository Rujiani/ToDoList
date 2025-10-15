import 'package:flutter/material.dart';
import 'package:to_do/toDoList.dart';
import 'package:to_do/bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List toDoList = <dynamic>[];
  late TextEditingController _textController;

  void onChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void onPressed() {
    setState(() {
      var task = _textController.text.trim();
      if (task.isNotEmpty) {
        toDoList.add([task, false]);
        _textController.clear();
      }
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, index) {
          return ToDoTask(
            task: toDoList[index][0],
            isDone: toDoList[index][1],
            onChanged: (value) => onChanged(index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),
      bottomNavigationBar: BottomTextBar(
        textController: _textController,
        onPressed: onPressed,
      ),
    );
  }
}
