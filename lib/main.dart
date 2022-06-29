import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sugoi/api/api.dart';
import 'package:sugoi/cubit/custome_cubit.dart';
import 'package:sugoi/models/customer.dart';
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
  final _api = Api();
  Customer? _customer;

  @override
  void initState() {
    super.initState();
    checkLogin();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomerCubit>(
          create: (BuildContext context) => CustomerCubit(_customer),
        ),
      ],
      child: MaterialApp(
        home: currentPage,
      ),
    );
  }

  Future<void> checkLogin() async {
    String? token = await _storage.read(key: "token");
    if (token == null) {
      return;
    }

    _customer = await _api.signInToken(token);
    if (_customer != null) {
      setState(() {
        currentPage = const MainScreen();
      });
    }
  }
}
