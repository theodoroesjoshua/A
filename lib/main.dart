import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

enum VoucherStatus {
  inactive,
  active,
  used,
  expired,
}

class Voucher {
  final String code;
  final DateTime start;
  final DateTime end;
  final String description;
  final VoucherStatus status;

  const Voucher({
    required this.code,
    required this.start,
    required this.end,
    required this.description,
    required this.status,
  });

  // Converts status to its string representation
  String getVoucherStatus() {
    switch(status) {
      case VoucherStatus.inactive:
        return "Belum Aktif";
      case VoucherStatus.active:
        return "Aktif";
      case VoucherStatus.used:
        return "Sudah Digunakan";
      case VoucherStatus.expired:
        return "Expired";
    }
  }
}

class _HomePageState extends State<HomePage> {
  final List<Voucher> _dummyVouchers = [
    Voucher(code: "ABCD123456789", start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 30)),
        description: "Voucher Rp. 50000", status: VoucherStatus.active),
    Voucher(code: "EFGH123456789", start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 30)),
        description: "Voucher Rp. 50000", status: VoucherStatus.inactive),
    Voucher(code: "IJKL123456789", start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 30)),
        description: "Voucher Rp. 50000", status: VoucherStatus.used),
    Voucher(code: "MNOP123456789", start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 30)),
        description: "Voucher Rp. 50000", status: VoucherStatus.expired),
    Voucher(code: "QRST123456789", start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 30)),
        description: "Voucher Rp. 50000", status: VoucherStatus.active),
  ];

  late Future<void> _initVoucherData;
  late List<Voucher> _vouchers;

  @override
  void initState() {
    super.initState();
    _initVoucherData = _initVouchers();
  }

  Future<void> _initVouchers() async {
    _vouchers = await _generateDummyVouchers();
  }

  Future<void> _refreshVouchers() async {
    final vouchers = await _generateDummyVouchers();
    setState(() {
      _vouchers = vouchers;
    });
  }

  Future<List<Voucher>> _generateDummyVouchers() async {
    return Future.delayed(const Duration(seconds: 2), () {
      List<Voucher> vouchers = [];

      var rng = Random();
      final totalDummyVouchers = rng.nextInt(5) + 1;
      _dummyVouchers.shuffle(rng);
      for (var i = 0; i < totalDummyVouchers; i++) {
        vouchers.add(_dummyVouchers[i]);
      }

      return vouchers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initVoucherData,
      builder: (context, snapshot) {
        // Loading vouchers
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Displaying vouchers
        if (!snapshot.hasError) {
          return RefreshIndicator(
            onRefresh: _refreshVouchers,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: _vouchers.map(_createVoucherWidget).toList(),
            ),
          );
        }

        // Error handling
        return const Center(
          child: Text("Something went wrong!"),
        );
      },
    );
  }

  Widget _createVoucherWidget(Voucher voucher) {
    double screenWidth = MediaQuery.of(context).size.width;
    DateFormat formatter = DateFormat("d MMMM yyyy");

    final smallTextStyle = TextStyle(
      color: Colors.grey[600],
      fontSize: screenWidth * 0.035,
    );

    return Card(
      color: Colors.white,
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    voucher.description,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: ListTile.divideTiles(
                  context: context,
                  tiles: <Widget>[
                    ListTile(
                      title: const Text("Kode Voucher:"),
                      subtitle: Text(voucher.code),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Berlaku Mulai: ${formatter.format(voucher.start)}",
                            style: smallTextStyle,
                          ),
                          Text(
                            "Berlaku Hingga: ${formatter.format(voucher.end)}",
                            style: smallTextStyle,
                          ),
                          RichText(
                            text: TextSpan(
                              style: smallTextStyle,
                              children: <TextSpan>[
                                const TextSpan(text: 'Status: '),
                                TextSpan(
                                  text: voucher.getVoucherStatus(),
                                  style: const TextStyle(fontWeight: FontWeight.bold)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).toList(),
              ),
            ),
          ],
        )
      ),
    );
  }
}
