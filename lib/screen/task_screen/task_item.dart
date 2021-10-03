import 'package:flutter/material.dart';
import 'package:sampleapp/model/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final Function(bool) toggleDone;

  const TaskItem(
      {Key? key,
      required this.onTap,
      required this.task,
      required this.toggleDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(task.name, style: Theme.of(context).textTheme.headline1),
                  (task.memo.isEmpty)
                      ? Container()
                      : Column(
                          children: <Widget>[
                            const SizedBox(height: 4),
                            Text(
                              task.memo,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Checkbox(
              value: task.isDone,
              onChanged: (value) {
                print(value);
                toggleDone(value!);
              },
              activeColor: Colors.lightGreen,
            )
          ],
        ),
      ),
    );
  }
}
