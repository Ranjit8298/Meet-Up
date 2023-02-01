import 'package:flutter/material.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({super.key});

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
   
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Tab')),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
          // type: BottomNavigationBarType.shifting,
          // currentIndex: _selectedIndex,
          // selectedItemColor: Colors.black,
          // iconSize: 40,
          // onTap: _onItemTapped,
          // elevation: 5
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed
          // elevation: 5,
          // backgroundColor: Colors.redAccent,
          ),
    );
  }
}