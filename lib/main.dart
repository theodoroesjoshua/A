import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final _storage = const FlutterSecureStorage();

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
    String? token = await _storage.read(key: "token");
    if (token != "Yehezkiel") {
      return;     // Not logged in
    }

    setState(() {
      currentPage = const MainScreen();
    });
  }
}
