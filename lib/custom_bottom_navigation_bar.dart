import 'package:flutter/material.dart';
import 'package:poss/home_page.dart';

class Custom_Navigation_BarPage extends StatefulWidget {
  const Custom_Navigation_BarPage({Key? key}) : super(key: key);

  @override
  State<Custom_Navigation_BarPage> createState() => _Custom_Navigation_BarPageState();
}

class _Custom_Navigation_BarPageState extends State<Custom_Navigation_BarPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(name: "",),
    Text(
      'Category',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 11, 129, 207),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Color.fromARGB(255, 1, 53, 9),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

}
