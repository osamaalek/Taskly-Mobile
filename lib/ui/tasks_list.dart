import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskly/model/task.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  final onToggle;
  final onGet;

  const TasksList(
      {Key? key,
      required this.tasks,
      required this.onToggle,
      required this.onGet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            // return _buildExpandableTile(index);
            return CheckboxListTile(
              title: Text(tasks[index].getName()),
              value: tasks[index].isCompleted(),
              onChanged: (_) => onToggle(tasks[index]),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/create'),
          child: const Icon(Icons.add)),
    );
  }
}
