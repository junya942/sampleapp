import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/screen/add_task_screen/add_task_screen.dart';
import 'package:sampleapp/screen/task_screen/task_item.dart';
import 'package:sampleapp/screen/view_model/task_view_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(builder: (context, taskViewModel, _) {
      if (taskViewModel.tasks.isEmpty) {
        return _emptyView();
      }
      return ListView.separated(
          itemBuilder: (context, index) {
            var task = taskViewModel.tasks[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  taskViewModel.deleteTask(index);
                } else {
                  taskViewModel.toggleDone(index, true);
                }
              },
              background: _buildDismissibleBackgroundContainer(false),
              secondaryBackground: _buildDismissibleBackgroundContainer(true),
              child: TaskItem(
                task: task,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      var task = taskViewModel.tasks[index];
                      taskViewModel.nameController.text = task.name;
                      taskViewModel.memoController.text = task.memo;
                      return AddTaskScreen(editTask: task);
                    }),
                  );
                },
                toggleDone: (value) {
                  taskViewModel.toggleDone(index, value);
                },
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(),
          itemCount: taskViewModel.tasks.length);
    });
  }

  Container _buildDismissibleBackgroundContainer(bool isSecond) {
    return Container(
      color: isSecond ? Colors.red : Colors.green,
      alignment: isSecond ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          isSecond ? 'Delete' : 'Done',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("You don't have a task!!"),
          SizedBox(height: 16),
          Text(
            'WellDone!!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ],
      ),
    );
  }
}
