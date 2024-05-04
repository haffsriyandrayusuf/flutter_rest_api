import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Todo {
  final int id;
  final String title;
  final String desc;

  Todo({
    required this.id,
    required this.title,
    required this.desc,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  late Future<List<Todo>> futureTodos;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  Future<List<Todo>> fetchTodos() async {
    final response = await http
        .get(Uri.parse('https://6635b332415f4e1a5e252945.mockapi.io/todo'));
    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return List<Todo>.from(json.map((todo) => Todo.fromJson(todo)));
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> createTodo() async {
    final response = await http.post(
      Uri.parse('https://6635b332415f4e1a5e252945.mockapi.io/todo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': titleController.text,
        'desc': descController.text,
      }),
    );
    if (response.statusCode == 201) {
      setState(() {
        futureTodos = fetchTodos();
      });
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<void> updateTodo(int id) async {
    final response = await http.put(
      Uri.parse('https://6635b332415f4e1a5e252945.mockapi.io/todo/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': titleController.text,
        'desc': descController.text,
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        futureTodos = fetchTodos();
      });
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('https://6635b332415f4e1a5e252945.mockapi.io/todo/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        futureTodos = fetchTodos();
      });
    } else {
      throw Exception('Failed to delete todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: 'Enter description',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: createTodo,
                child: const Text('Create Todo'),
              ),
              ElevatedButton(
                onPressed: () => updateTodo(1), // Update the todo with id=1
                child: const Text('Update Todo'),
              ),
              ElevatedButton(
                onPressed: () => deleteTodo(1), // Delete the todo with id=1
                child: const Text('Delete Todo'),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Todo>>(
              future: futureTodos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].desc),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: TodoListScreen(),
  ));
}
