import 'package:flutter/material.dart';
import 'package:myapp/presentation/screens/todo_screens/todo_screen.dart';
import 'package:myapp/presentation/screens/todo_screens/user_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> nevpages = [
    TodoScreen(),
    UserScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: nevpages[selectedIndex],
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here
          showModalBottomSheet(
            context: context,
            builder: (_) => AddTodoSheet(),
          );
        },
        child: Icon(Icons.add),
        heroTag: 'todoFab',  // Unique heroTag for the FAB on TodoScreen
      )
          : null, // Show FAB only on the TodoScreen
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.blue,
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(Icons.note, color: Colors.white),
              icon: Icon(Icons.note_outlined),
              label: "Notes"),
          NavigationDestination(
              selectedIcon: Icon(Icons.account_circle, color: Colors.white),
              icon: Icon(Icons.account_circle_outlined),
              label: "Profile"),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
