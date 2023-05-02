import 'package:flutter/material.dart';
import 'package:week7_networking_discussion/api/firebase_todo_api.dart';
// import 'package:week7_networking_discussion/api/todo_api.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;

  //array of todos from cloud firestore
  late Stream<QuerySnapshot> _todosStream;

  //yung may check
  Todo? _selectedTodo;

  //constructor
  TodoListProvider() {
    //coconnect lang sa firebase
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todos => _todosStream;
  Todo get selected => _selectedTodo!;


  //pang toggle ng mga sineselect
  changeSelectedTodo(Todo item) {
    _selectedTodo = item;
  }

  void fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);
    notifyListeners();
  }

  void editTodo(int index, String newTitle) {
    // _todoList[index].title = newTitle;
    print("Edit");
    notifyListeners();
  }

  void deleteTodo() async {
    String message = await firebaseService.deleteTodo(_selectedTodo!.id);
    print(message);
    notifyListeners();
  }

  void toggleStatus(int index, bool status) {
    // _todoList[index].completed = status;
    print("Toggle Status");
    notifyListeners();
  }
}