import 'package:flutter/material.dart';
import 'dart:math';

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
        body: IndexedStack(
          index: _selectedIndex,
          children: _createMainPages(),
        ),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  List<Widget> _createMainPages() {
    return <Widget>[
      const HomePage(),
      const Icon(
        Icons.camera,
        size: 150,
      ),
      const Icon(
        Icons.chat,
        size: 150,
      ),
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class Voucher {
  final String description;

  const Voucher({
    required this.description,
  });
}

class _HomePageState extends State<HomePage> {
  late Future<List<Voucher>> futureVouchers;

  @override
  void initState() {
    super.initState();
    futureVouchers = _fetchVouchers();
  }

  Future<List<Voucher>> _fetchVouchers() async {
    return Future.delayed(const Duration(seconds: 2), () {
      List<Voucher> vouchers = [];

      var rng = Random();
      final totalDummyVouchers = rng.nextInt(5) + 1;
      for (var i = 0; i < totalDummyVouchers; i++) {
        vouchers.add(Voucher(description: "test $i"));
      }

      return vouchers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Voucher>>(
        future: futureVouchers,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasError && snapshot.hasData) {
            List<Voucher> vouchers = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(8),
              children: vouchers.map(_createVoucherWidget).toList(),
            );
          }

          return const Center(
            child: Text("Something went wrong!"),
          );
        }
      ),
    );
  }

  Widget _createVoucherWidget(Voucher voucher) {
    return Card(
      color: Colors.amber[600],
      child: Center(child: Text(voucher.description)),
    );
  }
}
