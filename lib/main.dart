import 'package:flutter/material.dart';

class Task {
  final String taskName;
  final String description;

  Task(this.taskName, this.description);
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: TodosScreen(
      tasks: List.generate(
        10,
        (i) => Task(
          'Task $i',
          'Task Description $i',
        ),
      ),
    ),
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Task> tasks;

  TodosScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].taskName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                  settings: RouteSettings(
                    arguments: tasks[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Safely access the arguments passed to this route
    final task = ModalRoute.of(context)?.settings.arguments as Task?;

    if (task == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('No task found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(task.taskName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(task.description),
      ),
    );
  }
}
