import 'package:flutter/material.dart';
import 'package:to_do/toDoList.dart';
import 'package:to_do/bottom_bar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List toDoList = <Task>[];
  late TextEditingController _textController;

  void onChanged(int index) {
    setState(() {
      toDoList[index].isDone = !toDoList[index].isDone;
    });
    _saveTasks();
  }

  void onPressed() {
    setState(() {
      var task = _textController.text.trim();
      if (task.isNotEmpty) {
        toDoList.add(
          Task(taskMessage: task, isDone: false, createDate: DateTime.now()),
        );
        _textController.clear();
      }
    });
    _saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
    _saveTasks();
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _loadTasks();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(toDoList.map((e) => e.toJson()).toList());
    await prefs.setString('tasks', encoded);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('tasks');
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString) as List;
      setState(() {
        toDoList = decoded.map((e) => Task.fromJson(e)).toList();
      });
    }
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
            task: toDoList[index].taskMessage,
            isDone: toDoList[index].isDone,
            date: toDoList[index].createDate,
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
