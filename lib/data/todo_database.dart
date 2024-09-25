import 'package:hive_flutter/hive_flutter.dart';
import 'models/todo_model.dart';

class TodoDatabase{

  final _myBox = Hive.box<TodoModel>('todo_box');

  void addTodo(TodoModel todoModel){
    _myBox.add(todoModel);
  }

  List<TodoModel> getTodos(){
    return _myBox.isNotEmpty? _myBox.values.toList(): [];
  }

  void deleteTodo(int index){
    _myBox.deleteAt(index);
  }

  void updateTodo(int index, TodoModel todoModel){
    _myBox.putAt(index, todoModel);
  }

}