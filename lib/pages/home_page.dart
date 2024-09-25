import 'package:app1/components/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:app1/components/todo_file.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app1/data/models/todo_model.dart';
import 'package:app1/data/todo_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var todoDatabase = TodoDatabase();

  List<TodoModel> todoList = [];

  @override
  void initState() {
    todoList = todoDatabase.getTodos();
  }

  final _controller = TextEditingController();

  void onCheckedBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index].isCompleted = !todoList[index].isCompleted;
      todoDatabase.updateTodo(index, todoList[index]);
    });
  }

  void onCancelDaialog() {
    _controller.clear();
    Navigator.pop(context);
  }

  void onSaveTask() {
    setState(() {
      var newTask = TodoModel(taskName: _controller.text, isCompleted: false);
      todoList.add(newTask);
      todoDatabase.addTodo(newTask);
    });
    _controller.clear();
    Navigator.pop(context);
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: onSaveTask,
            onCancel: onCancelDaialog,
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
          actions: [IconButton(onPressed: () {
            Navigator.pushNamed(context, '/settingsPage');
          }, icon: Container(
            decoration: BoxDecoration(
              color:Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)
            )
            ,child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.settings),
            ),
          ))],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(todoList[index].taskName),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    todoList.removeAt(index);
                    todoDatabase.deleteTodo(index);
                  });
                },
                child: TodoTile(
                    taskName: todoList[index].taskName,
                    isCompleted: todoList[index].isCompleted,
                    onChanged: (value) => onCheckedBoxChanged(value, index)),
              );
            }));
  }
}
