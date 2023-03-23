import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List todoItems = [];
  String itemBeingEdited = '';
//Thêm một công việc mới
  void addTodoItem(String task, DateTime deadline) {
    if (task.length > 0) {
      setState(() => todoItems
          .add({'task': task, 'completed': false, 'deadline': deadline}));
    }
  }

//Xóa một công việc
  void removeTodoItem(int index) {
    setState(() => todoItems.removeAt(index));
  }

//Hiển thị một hộp thoại để xác nhận việc xóa
  void promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Xoá "${todoItems[index]['task']}" ?'), // Xác nhận xóa
            actions: [
              ElevatedButton(
                  child: const Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop()),
              ElevatedButton(
                child: const Text('DELETE'),
                onPressed: () {
                  removeTodoItem(index);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

//Hiển thị một hộp thoại để chỉnh sửa công việc
  void updateTodoItem(String newTask, DateTime deadline) {
    setState(() {
      todoItems[todoItems
              .indexWhere((element) => element['task'] == itemBeingEdited)]
          ['task'] = newTask; // Cập nhật công việc
      todoItems[todoItems.indexWhere((element) =>
              element['task'] == itemBeingEdited)] // Cập nhật deadline
          ['deadline'] = deadline;

      itemBeingEdited = '';
    });
  }

//Hiển thị một hộp thoại để chỉnh sửa công việc
  void toggleTodoItem(int index) {
    setState(() {
      todoItems[index]['completed'] = !todoItems[index]['completed'];
    });
  }

//Hiển thị một hộp thoại để chỉnh sửa công việc
  Widget buildTodoList() {
    double _currentSliderValue = 0;
    return ListView.builder(
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        DateTime deadline = todoItems[index]['deadline']; // Lấy deadline
        bool isDeadlinePassed =
            DateTime.now().isAfter(deadline); // Kiểm tra deadline
// Hiển thị công việc
        return Card(
          color: isDeadlinePassed
              ? Colors.red
              : null, // Nếu deadline đã qua thì hiển thị màu đỏ
          child: ListTile(
            title: Column(
              children: [
                Row(children: [
                  Expanded(
                    // Nếu công việc đã hoàn thành thì gạch chân và chuyển qua màu xanh
                    child: Text(
                      todoItems[index]['task'],
                      style: TextStyle(
                        decoration: todoItems[index]['completed']
                            ? TextDecoration.lineThrough
                            : null,
                        color:
                            todoItems[index]['completed'] ? Colors.green : null,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => promptRemoveTodoItem(index),
                  ),
                  Checkbox(
                    value: todoItems[index]['completed'],
                    onChanged: (value) => toggleTodoItem(index),
                  ),
                ]),
                Row(
                  children: [
                    // Tạo thanh slider
                    Expanded(
                      child: Slider(
                        value: _currentSliderValue,
                        max: 100,
                        divisions: 5,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            if (value == 100) {
                              todoItems[index]['completed'] = true;
                            }
                            _currentSliderValue = value;
                          });
                        },
                        semanticFormatterCallback: (double newValue) {
                          return '${newValue.round()}%';
                        },
                      ),
                    ),
                    Text(
                      deadline.toString(),
                      style: TextStyle(
                        color: isDeadlinePassed ? Colors.white : null,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _addDeadlineDialog(
                          index), // Hiển thị hộp thoại chỉnh sửa deadline
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

//Hiển thị một hộp thoại để chỉnh sửa công việc
  void _addTodoItemDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String newtask = '';
          DateTime deadline = DateTime.now();
          return AlertDialog(
            title: Text('Thêm mới 1 công việc'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    autofocus: true,
                   
                    decoration: InputDecoration(
                        // Hiển thị hộp nhập liệu
                        labelText: 'Tên công việc'),
                         keyboardType: TextInputType.text,
                    onChanged: (value) =>
                        newtask = value, // Lấy giá trị nhập vào
                  ),
                  SizedBox(height: 16),
                  Text('Deadline'),
                  SizedBox(height: 8),
                  // Hiển thị hộp chọn ngày
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: deadline,
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != deadline)
                        setState(() {
                          deadline = picked;
                        });
                    },
                    child: Text(
                      deadline.toString().substring(0), // Hiển thị ngày
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('ADD'),
                onPressed: () {
                  addTodoItem(newtask, deadline);
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

//Hiển thị một hộp thoại để chỉnh sửa công việc
  void _addDeadlineDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          DateTime deadline = todoItems[index]['deadline'];

          return AlertDialog(
            title: Text('Update Deadline'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(height: 16),
                  Text('Deadline'),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: deadline,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != deadline)
                        setState(() {
                          todoItems[index]['deadline'] = picked;
                        });
                    },
                    child: Text(
                      deadline.toString().substring(0, 10),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('UPDATE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: todoItems.isEmpty
          ? Center(
              child: Text('Cùng thêm công việc vào danh sách nhé!'),
            )
          : buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItemDialog,
        tooltip: 'Thêm mới công việc',
        child: Icon(Icons.add),
      ),
    );
  }
}
