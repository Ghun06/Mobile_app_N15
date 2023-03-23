import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/ToDoList.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ToDoList()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: const Text('Manager Works'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Text(
                'Manager Works',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Công việc'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ToDoList()));
              },
            ),
            ListTile(
              title: const Text('Học tập'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ToDoList()));
              },
            ),
            ListTile(
              title: const Text('Giải trí'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ToDoList()));
              },
            ),
            ListTile(
              title: const Text('Khác'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ToDoList()));
              },
            ),
            ListTile(
              title: const Text('Thông tin về app'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          const Text(
            'Quản lý thư mục của bạn',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 160),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // căn giữa
                  children: [
                    // Tạo button với icon
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ToDoList()));
                      },
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text('Công việc'),
                      // chỉnh size elvatedbutton
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 150),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ToDoList()));
                      },
                      icon: const Icon(Icons.book),
                      label: const Text('Học'),
                      // chỉnh size elvatedbutton
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 150),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ToDoList()));
                      },
                      icon: const Icon(Icons.audiotrack),
                      label: const Text('Giải trí'),
                      // chỉnh size elvatedbutton
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 150),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ToDoList()));
                      },
                      icon: const Icon(Icons.difference),
                      label: const Text('Khác '),
                      // chỉnh size elvatedbutton
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 150),
                      ),
                    ),
                  ],
                ),
              ])
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Công việc',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            label: 'Giải trí',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'học',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.difference),
            label: 'Khác',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
