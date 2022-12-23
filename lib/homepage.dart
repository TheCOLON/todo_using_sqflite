import 'package:flutter/material.dart';
import 'package:todo_written_exam/add_todo.dart';
import 'package:todo_written_exam/edit_todo.dart';
import 'dbHelper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DbHelper dbHelper = DbHelper();
  List todo = [];

  Future<void> read() async {
    List<Map> response = await dbHelper.read('todo');
    todo.addAll(response);
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TODO USING SQFLITE'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: todo.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            tileColor: Colors.lightBlue[200],
            leading: SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(child: Text('${index + 1}')),
            ),
            title: Text(todo[index]['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            subtitle: Text(todo[index]['description']),
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == 'edit') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditTodo()));
                } else if (value == 'delete') {
                  int response =
                      dbHelper.delete('todo', "id = ${todo[index]['id']}");
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(child: Text('Edit'), value: 'edit'),
                const PopupMenuItem<String>(
                    child: Text('Delete'), value: 'delete'),
              ],
            ),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTodo(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
