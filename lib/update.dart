import 'package:flutter/material.dart';

import 'repository.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    Repository repository = Repository();

    final args = ModalRoute.of(context)!.settings.arguments as List;
    if (args[0].isNotEmpty) {
      titleController.text = args[0];
    }
    if (args[1].isNotEmpty) {
      descController.text = args[1];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Todo"),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).popAndPushNamed('/home'),
          child: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                label: Text("title"),
                border: OutlineInputBorder(),
              ),
              controller: titleController,
            ),
            const SizedBox(height: 14),
            TextField(
              maxLines: 3,
              minLines: 1,
              decoration: const InputDecoration(
                label: Text("description"),
                border: OutlineInputBorder(),
              ),
              controller: descController,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                bool response = await repository.putData(
                  int.parse(args[2]),
                  titleController.text,
                  descController.text,
                );
                if (response) {
                  if (context.mounted) {
                    Navigator.of(context).popAndPushNamed('/home');
                  }
                } else {
                  throw Exception('Failed to update todo');
                }
              },
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
