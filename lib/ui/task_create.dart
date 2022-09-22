import 'package:flutter/material.dart';

class TaskCreate extends StatefulWidget {
  final onCreate;

  const TaskCreate({Key? key, @required this.onCreate}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaskCreateState();
  }
}

class TaskCreateState extends State<TaskCreate> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a task"),
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                  autofocus: true,
                  controller: controller,
                  decoration: const InputDecoration(
                      labelText: 'Enter name of your task')))),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () {
          widget.onCreate(controller.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
