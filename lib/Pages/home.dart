import 'package:coo_doctor/views/HomeView.dart';
import 'package:coo_doctor/views/MessagesView.dart';
import 'package:coo_doctor/views/ProtocolView.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    const ProtocolView(),
    const MessagesView(),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        /*
      appBar: AppBar(
        title: Text('Home '),
         backgroundColor: Colors.purple,
        centerTitle: true,
        ),
        */
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.purple,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Protocols',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: 'Feedback',
              ),
            ]));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
