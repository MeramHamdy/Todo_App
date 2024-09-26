import 'package:app1/cubits/todo_cubit.dart';
import 'package:app1/data/models/todo_model.dart';
import 'package:app1/pages/home_page.dart';
import 'package:app1/pages/settings_page.dart';
import 'package:app1/themes/themes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  final myBox = await Hive.openBox<TodoModel>('todo_box');
  runApp(ChangeNotifierProvider(
    create: (context) => ThemesProvider(),
    child: MyApp(
      todoBox: myBox,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final Box<TodoModel> todoBox;

  MyApp({required this.todoBox});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemesProvider>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoCubit(todoBox),
        child: const HomePage(),
      ),
      routes: {'/settingsPage': (context) => SettingsPage()},
    );
  }
}
