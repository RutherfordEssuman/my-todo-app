import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  Widget _buildTask(String task) {
    return ListTile(
      title: Text(task),
      trailing: IconButton(
        icon: const Icon(Icons.done),
        onPressed: () {
          setState(() {
            _tasks.remove(task);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: _tasks.map((task) => _buildTask(task)).toList(),
            ),
          ),
          AddTaskForm(_addTask),
        ],
      ),
    );
  }
}

class AddTaskForm extends StatefulWidget {
  final Function addTask;

  const AddTaskForm(this.addTask, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String _task = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.addTask(_task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a task';
            }
            return null;
          },
          onSaved: (newValue) => _task = newValue!,
          decoration: InputDecoration(
            labelText: 'Task',
            hintText: 'What do you need to do?',
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: _submit,
            ),
          ),
        ),
      ),
    );
  }
}
