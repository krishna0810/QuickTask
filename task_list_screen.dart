import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'task_model.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  Future<void> fetchTasks() async {
    final query = QueryBuilder(ParseObject('tasks'));
    final response = await query.query();

    if (response.success && response.results != null) {
      setState(() {
        tasks = response.results!
            .map((e) => Task.fromParseObject(e))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.dueDate.toString()),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                // Update task completion status
              },
            ),
          );
        },
      ),
    );
  }
}
trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Checkbox(
      value: task.isCompleted,
      onChanged: (value) {
        // Update task completion status
      },
    ),
    IconButton(
      icon: Icon(Icons.edit),
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTaskScreen(
              taskId: task.id,
              currentTitle: task.title,
              currentDueDate: task.dueDate,
            ),
          ),
        );
        if (result == true) {
          fetchTasks(); // Refresh task list after editing
        }
      },
    ),
  ],
),
body: ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    final task = tasks[index];
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        title: Text(task.title),
        subtitle: Text('Due: ${task.dueDate.toLocal()}'.split(' ')[0]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Navigate to EditTaskScreen
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Delete task
              },
            ),
          ],
        ),
      ),
    );
  },
),
floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    ).then((value) {
      if (value == true) {
        fetchTasks(); // Refresh task list after adding a task
      }
    });
  },
  child: Icon(Icons.add),
),
