import 'package:flutter/material.dart';
List<String> todoList = [];
class TodoListApp extends StatefulWidget {
  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('To-Do List')),
    body: ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text(todoList[index]));
      },
    ),
  );
}
}