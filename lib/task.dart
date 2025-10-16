import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String taskMessage;
  bool isDone;
  final DateTime createDate;
  Task({
    required this.taskMessage,
    required this.isDone,
    required this.createDate,
  });
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
