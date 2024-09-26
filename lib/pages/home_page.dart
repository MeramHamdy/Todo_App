import 'package:app1/components/dialog_box.dart';
import 'package:app1/cubits/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:app1/components/todo_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app1/data/models/todo_model.dart';
import 'package:app1/data/todo_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  void onCancelDaialog(BuildContext context) {
    _controller.clear();
    Navigator.pop(context);
  }

  void onSaveTask(BuildContext context) {
    context.read<TodoCubit>().addTodo(_controller.text);
    _controller.clear();
    Navigator.pop(context);
  }

  void createNewTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: () => onSaveTask(context),
            onCancel:() => onCancelDaialog(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo App',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settingsPage');
                },
                icon: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.settings),
                  ),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createNewTask(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        body: BlocBuilder<TodoCubit, List<TodoModel>>(
            builder: (context, todoList) {
          return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(todoList[index].taskName),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<TodoCubit>().deleteTodo(index);
                  },
                  child: TodoTile(
                      taskName: todoList[index].taskName,
                      isCompleted: todoList[index].isCompleted,
                      onChanged: (value) =>
                          context.read<TodoCubit>().updateTodo(index)),
                );
              });
        }));
  }
}
