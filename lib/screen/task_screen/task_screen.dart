import 'package:flutter/material.dart';
import 'package:sampleapp/screen/add_task_screen/add_task_screen.dart';
import 'package:sampleapp/screen/task_screen/task_list_view.dart';

import 'task_list_view.dart';

class TaskScreen extends StatelessWidget {
  static String id = 'task_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AddTaskScreen.id);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Container(
        child: TaskListView(),
      ),
    );
  }
}
