import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';

const todoListKey = "todo_list";
class TodoRepository{
  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List decodedJson = json.decode(jsonString) as List;
    return decodedJson.map((json) => Todo.fromJson(json)).toList();
  }

  void saveTodoList(List<Todo> todo){
    final String jsonString = json.encode(todo);
    sharedPreferences.setString(todoListKey, jsonString);
  }


}