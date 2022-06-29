import 'package:flutter/material.dart';
import 'package:sugoi/screens/sign_in_screen.dart';

import 'screens/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Widget currentPage = const SignInScreen();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }

  Future<void> checkLogin() async {
    // TODO: Check Login credentials using flutter secure storage
    if (false) {
      setState(() {
        currentPage = const MainScreen();
      });
    }
  }
}
