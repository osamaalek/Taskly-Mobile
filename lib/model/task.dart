class Task {

  String id;
  String name;
  bool completed;

  Task({required this.id,required this.name,required this.completed});

  setId(id) => this.id = id;

  getName() => name;
  setName(name) => this.name = name;

  isCompleted() => completed;
  setCompleted(completed) => this.completed = completed;

  factory Task.fromJson(Map<dynamic,dynamic> json) {
    return Task(id: json['_id'], name: json['content'], completed: json['completed']);
}

}