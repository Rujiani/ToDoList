// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  taskMessage: json['taskMessage'] as String,
  isDone: json['isDone'] as bool,
  createDate: DateTime.parse(json['createDate'] as String),
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'taskMessage': instance.taskMessage,
  'isDone': instance.isDone,
  'createDate': instance.createDate.toIso8601String(),
};
