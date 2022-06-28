import 'package:flutter/material.dart';
import 'package:sugoi/screens/account_screen.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "De'Sushi Membership",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("De'sushi"),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _createMainPages(),
        ),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  List<Widget> _createMainPages() {
    return const <Widget>[
      HomeScreen(),
      HistoryScreen(),
      AccountScreen(),
    ];
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Riwayat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Akun',
        )
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
