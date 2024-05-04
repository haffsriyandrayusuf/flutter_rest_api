import 'package:flutter/material.dart';

import 'repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future futureTodo;
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    futureTodo = repository.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Center(
        child: FutureBuilder(
          future: futureTodo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Or any other loading indicator
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final listTodo = snapshot.data!;
              return ListView.separated(
                itemCount: listTodo.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final todo = listTodo[index];
                  return Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () => Navigator.of(context).popAndPushNamed(
                            '/update-todo',
                            arguments: [
                              todo.title,
                              todo.desc,
                              todo.id,
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todo.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(todo.desc),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                title: const Text("Warning!"),
                                content: const Text("Are you sure delte data?"),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    onPressed: () async {
                                      bool response =
                                          await repository.deleteData(todo.id);
                                      if (response) {
                                        if (context.mounted) {
                                          setState(() {
                                            futureTodo = repository.getData();
                                          });
                                          Navigator.of(context).pop();
                                        }
                                      } else {
                                        throw Exception('Failed to load todo');
                                      }
                                      // repository.getData();
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete_outline_rounded),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        splashColor: Colors.transparent,
        hoverElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          Navigator.of(context).popAndPushNamed('/add-todo');
        },
        label: const Text("Tambah Data"),
      ),
    );
  }
}
