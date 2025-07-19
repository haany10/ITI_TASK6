import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_assistant/globals.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TextEditingController taskController = TextEditingController();
  List<Map<String, dynamic>> tasks = [];

  String fullName = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  void _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = '${prefs.getString('firstName') ?? ''} ${prefs.getString('lastName') ?? ''}';
    });
  }

  void _addTask() {
    if (taskController.text.trim().isEmpty) return;
    setState(() {
      tasks.add({'task': taskController.text.trim(), 'completed': false});
      taskController.clear();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleComplete(int index) {
  setState(() {
    tasks[index]['completed'] = !tasks[index]['completed'];
  });

  if (tasks[index]['completed']) {
    addComTask(tasks[index]['task']);
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: const InputDecoration(labelText: "Enter new task"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _addTask, child: const Text("Add Task")),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      tasks[index]['task'],
                      style: TextStyle(
                        decoration: tasks[index]['completed'] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text("Created by: $fullName"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () => _toggleComplete(index), icon: const Icon(Icons.check, color: Colors.green)),
                        IconButton(onPressed: () => _deleteTask(index), icon: const Icon(Icons.delete, color: Colors.red)),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
