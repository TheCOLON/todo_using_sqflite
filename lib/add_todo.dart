import 'package:flutter/material.dart';
import 'package:todo_written_exam/homepage.dart';
import 'dbHelper.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  DbHelper dbHelper = DbHelper();
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add To Do'),
      ),
      body: Form(
          key: formKey,
          child: ListView(padding: const EdgeInsets.all(20), children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 100,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 100,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                int response = await dbHelper.insert('todo', {
                  "title": titleController.text,
                  "description": descriptionController.text
                });

                if (response > 0) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ));
                }
              },
              child: const Text('Add Note'),
            ),
          ])),
    );
  }
}
