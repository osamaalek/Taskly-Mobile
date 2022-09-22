import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:taskly/app/constants.dart';
import 'package:taskly/model/login_res.dart';
import 'package:taskly/model/task.dart';
import 'package:taskly/ui/login.dart';
import 'package:taskly/ui/signup.dart';
import 'package:taskly/ui/task_create.dart';
import 'package:taskly/ui/tasks_list.dart';
import 'package:taskly/util/toast_util.dart';

class TasklyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Taskly();
  }
}

class Taskly extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TasklyState();
  }
}

class TasklyState extends State<Taskly> {
  List<Task> tasks = <Task>[];
  bool isEnable = true;
  final storage = const FlutterSecureStorage();

  Future<void> getAllTasks() async {
    var url = Uri.http(Constants.url, '/api/tasks');
    String? token = await storage.read(key: Constants.token);
    try {
      final response = await http
          .get(url, headers: {"Authorization": "Bearer " + token.toString()});

      Iterable data = json.decode(response.body);
      log(" data tasks is " + data.toString());

      if (response.statusCode == 200) {
        setState(() {
          tasks = List<Task>.from(data.map((e) => Task.fromJson(e)));
        });
        log("tasks is " + tasks.toString());
      }
    } on Exception {
      ToastUtil.showToast(
          'Please check your internet and try again', ToastUtil.error);
      return;
    }
  }

  Future<void> onTaskCreated(String name) async {
    var url = Uri.http(Constants.url, '/api/tasks');
    String? token = await storage.read(key: Constants.token);
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer " + token.toString()
          },
          body: jsonEncode(<String, String>{"content": name}));

      final data = json.decode(response.body);
      log(response.body);
      if (response.statusCode == 201) {
        ToastUtil.showToast(
            'Your task is created successfully', ToastUtil.success);
        setState(() {
          tasks.add(
              Task(name: name, id: Task.fromJson(data).id, completed: false));
        });
      } else {
        ToastUtil.showToast('Sorry, something is wrong', ToastUtil.error);
      }
    } on Exception {
      ToastUtil.showToast(
          'Please check your internet and try again', ToastUtil.error);
    }
  }

  Future<void> onTaskToggled(Task task) async {
    String? token = await storage.read(key: Constants.token);
    final url = Uri.http(Constants.url, '/api/tasks/' + task.id);
    try {
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer " + token.toString()
          },
          body: jsonEncode({'completed': !task.completed}));
      if (response.statusCode == 200) {
        ToastUtil.showToast('Done', ToastUtil.success);
        setState(() {
          task.setCompleted(!task.isCompleted());
        });
      } else {
        ToastUtil.showToast('Sorry,something is wrong', ToastUtil.error);
      }
    } on Exception {
      ToastUtil.showToast(
          'Please check your internet and try again', ToastUtil.error);
    }
  }

  Future<void> onLogin(
      String username, String password, BuildContext context) async {
    if (!isValid(username, password)) return;

    var url = Uri.http(Constants.url, '/api/login');
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'username': username, 'password': password}));
      final data = json.decode(response.body);
      if (response.statusCode == 200 && data != null) {
        await storage.write(
            key: Constants.token, value: LoginRes.fromJson(data).token);
        Navigator.popAndPushNamed(context, '/list');
        getAllTasks();
      } else if (response.statusCode == 401) {
        ToastUtil.showToast(
            'Please check your username and password', ToastUtil.error);
      }
    } on Exception {
      ToastUtil.showToast(
          'Please check your internet and try again', ToastUtil.error);
    }
    setState(() {
      isEnable = true;
    });
  }

  Future<void> onSignup(
      String username, String password, BuildContext context) async {
    if (!isValid(username, password)) return;
    var url = Uri.http(Constants.url, '/api/singup');
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'username': username, 'password': password}));

      if (response.statusCode == 201) {
        ToastUtil.showToast(
            'Your account is created successfully', ToastUtil.success);
        Navigator.popAndPushNamed(context, '/');
      } else {
        ToastUtil.showToast('Please use another username', ToastUtil.worning);
      }
    } on Exception {
      ToastUtil.showToast(
          'Please check your internet and try again', ToastUtil.worning);
    }
    setState(() {
      isEnable = true;
    });
  }

  bool isValid(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      ToastUtil.showToast('Please fill all fields', ToastUtil.error);
      return false;
    } else if (password.length < 8) {
      ToastUtil.showToast(
          'The password should be longer than 7 characters', ToastUtil.error);
      return false;
    }
    setState(() {
      isEnable = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO app',
      initialRoute: '/',
      routes: {
        '/': (context) => Login(
              onLogin: onLogin,
              isEnable: isEnable,
            ),
        '/signup': (context) => Signup(
              onSignup: onSignup,
              isEnable: isEnable,
            ),
        '/list': (context) => TasksList(
            tasks: tasks, onToggle: onTaskToggled, onGet: getAllTasks),
        '/create': (context) => TaskCreate(
              onCreate: onTaskCreated,
            ),
      },
    );
  }
}
