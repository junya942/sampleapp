import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/screen/view_model/task_view_model.dart';
import 'package:sampleapp/screen/task_screen/task_screen.dart';
import 'package:sampleapp/screen/add_task_screen/add_task_screen.dart';

void main() {
  print('Welcome Ymatatsu Todo App !!!');
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App TODO',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: TaskScreen.id,
      routes: {
        TaskScreen.id: (context) => TaskScreen(),
        AddTaskScreen.id: (context) => AddTaskScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('こんにちは'),
      ),
    );
  }
}
