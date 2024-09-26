import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app1/data/models/todo_model.dart';
import 'package:hive/hive.dart';
class TodoCubit extends Cubit<List<TodoModel>>{

  final Box<TodoModel> _todoBox;

  TodoCubit(this._todoBox) : super([]){
    loadTodos();
  }

  void loadTodos(){
    if(_todoBox.isNotEmpty){
      emit(_todoBox.values.toList());
    }

  }
  void addTodo(String title){
    final newTask = TodoModel(taskName: title, isCompleted: false);
    _todoBox.add(newTask);
    emit([...state,newTask]);

  }
  void updateTodo(int index){
    state[index].isCompleted = ! state[index].isCompleted;
    _todoBox.putAt(index, state[index]);
    emit([...state]);
  }
  void deleteTodo(int index){
    _todoBox.deleteAt(index);
    emit([...state]..removeAt(index));
  }

}