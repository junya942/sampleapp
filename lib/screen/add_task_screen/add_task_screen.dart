import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/model/task.dart';
import 'package:sampleapp/screen/view_model/task_view_model.dart';

class AddTaskScreen extends StatelessWidget {
  static String id = 'add_task_screen';
  final Task? editTask;
  const AddTaskScreen({Key? key, this.editTask}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, viewModel, _) {
        return WillPopScope(
          onWillPop: () async {
            viewModel.clear();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(_isEdit() ? 'Save Task' : 'Add Task'),
            ),
            body: ListView(
              children: <Widget>[
                _buildInputField(
                  context,
                  title: 'todo',
                  textEditingController: viewModel.nameController,
                  errorText:
                      viewModel.validateName ? viewModel.strValidateName : '',
                  didChanged: (_) {
                    viewModel.updateValidateName();
                  },
                ),
                _buildInputField(
                  context,
                  title: 'Memo',
                  textEditingController: viewModel.memoController,
                  errorText: '',
                  didChanged: (_) {
                    viewModel.updateValidateName();
                  },
                ),
                _buildAddButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isEdit() {
    return editTask != null;
  }

  void tapAddButton(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    viewModel.setValidateName(true);
    if (viewModel.validateTaskName()) {
      _isEdit() ? viewModel.updateTask(editTask!) : viewModel.addTask();
      Navigator.of(context).pop();
    }
  }

  Widget _buildInputField(BuildContext context,
      {required String title,
      required TextEditingController textEditingController,
      required String errorText,
      required Function(String) didChanged}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(errorText: errorText),
            onChanged: (value) {
              didChanged(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RaisedButton(
        onPressed: () => tapAddButton(context),
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            _isEdit() ? 'Save' : 'Add',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
