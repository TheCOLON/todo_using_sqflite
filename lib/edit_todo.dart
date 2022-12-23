import 'package:flutter/material.dart';
import 'package:todo_written_exam/homepage.dart';
import 'dbHelper.dart';

class EditTodo extends StatefulWidget {
  final id;
  final title;
  final description;
  const EditTodo({super.key, this.id, this.title, this.description});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  var formKey = GlobalKey<FormState>();
  DbHelper dbHelper = DbHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Page'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                int response = await dbHelper.update(
                    'todo',
                    {
                      "title": titleController.text,
                      "description": descriptionController.text
                    },
                    "id = ${widget.id}");

                if (response > 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ));
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
