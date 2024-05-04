import 'package:flutter/material.dart';
import 'package:flutter_rest_api/repository.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    Repository repository = Repository();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
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
                bool response = await repository.postData(
                  titleController.text,
                  descController.text,
                );
                if (response) {
                  if (context.mounted) {
                    Navigator.of(context).popAndPushNamed('/home');
                  }
                } else {
                  throw Exception('Failed to create todo.');
                }
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
