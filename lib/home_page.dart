import 'package:flutter/material.dart';
import 'package:to_do/toDoList.dart';
import 'package:to_do/bottom_bar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/task.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List toDoList = <Task>[];
  late TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();
  int? _editingIndex;

  void onChanged(int index) {
    setState(() {
      toDoList[index].isDone = !toDoList[index].isDone;
    });
    _saveTasks();
  }

  void onPressed() {
    setState(() {
      var task = _textController.text.trim();
      if (task.isEmpty) {
        return;
      }

      if (_editingIndex != null) {
        toDoList[_editingIndex!].taskMessage = _textController.text;
        _editingIndex = null;
      } else {
        toDoList.add(
          Task(taskMessage: task, isDone: false, createDate: DateTime.now()),
        );
      }
    });
    _textController.clear();
    _saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      if (_editingIndex != null) {
        if (_editingIndex == index) {
          cancel();
        } else if (_editingIndex! > index) {
          _editingIndex = _editingIndex! - 1;
        }
      }
      toDoList.removeAt(index);
    });
    _saveTasks();
  }

  void editTask(int index) {
    setState(() {
      _textController.text = toDoList[index].taskMessage;
      _focusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.show');
      _editingIndex = index;
    });
    _saveTasks();
  }

  void cancel() {
    setState(() {
      if (_editingIndex != null) {
        _editingIndex = null;
        _textController.clear();
        _focusNode.unfocus();
      }
    });
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

  Future<bool> _onWillPop() async {
    if (_editingIndex != null) {
      cancel();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.title,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        body: ReorderableListView.builder(
          proxyDecorator: (child, index, animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                final double animValue = Curves.easeInOut.transform(
                  animation.value,
                );
                final double scale = lerpDouble(1, 1.03, animValue)!;
                return Transform.scale(scale: scale, child: child);
              },
              child: child,
            );
          },
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = toDoList.removeAt(oldIndex);
              toDoList.insert(newIndex, item);
            });
          },
          itemCount: toDoList.length,
          itemBuilder: (BuildContext context, index) {
            return ReorderableDragStartListener(
              key: ValueKey(toDoList[index]),
              enabled: false,
              index: index,
              child: ToDoTask(
                task: toDoList[index].taskMessage,
                isDone: toDoList[index].isDone,
                date: toDoList[index].createDate,
                editTask: (context) => editTask(index),
                onChanged: (value) => onChanged(index),
                deleteTask: (context) => deleteTask(index),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomTextBar(
          focusNode: _focusNode,
          textController: _textController,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
