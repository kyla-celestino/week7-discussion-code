import 'dart:convert';

class Todo { //object
  final int userId;
  String? id; //pwedeng null kasi auto-generated
  String title;
  bool completed;

  Todo({ //constructor
    required this.userId,
    this.id,
    required this.title,
    required this.completed,
  });

  // Factory constructor to instantiate object from json format
  //fetch json file from cloud firestore
  //new constructor to convert the todo from cloud firestore to this code below
  //return array of json
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  //ginagawang iterable yung array na galing sa taas????????
  static List<Todo> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Todo>((dynamic d) => Todo.fromJson(d)).toList();
  }

  //convert to json para tanggapin ni cloud firestore
  Map<String, dynamic> toJson(Todo todo) {
    return {
      'userId': todo.userId,
      'title': todo.title,
      'completed': todo.completed,
    };
  }
}