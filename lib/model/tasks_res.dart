import 'package:taskly/model/task.dart';

class TasksRes {
  late List<Task> tasks;

  TasksRes({required this.tasks});

  factory TasksRes.fromJson(Map<String, dynamic> json){
    return TasksRes(tasks: json["tasks"]);
  }

}