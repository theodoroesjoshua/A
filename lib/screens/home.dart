import 'package:flutter/material.dart';

import '../common_widgets/voucher_widget.dart';
import '../models/voucher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Voucher> _dummyVouchers = [
    Voucher(code: "IJKL123456789",
        start: DateTime.now().subtract(const Duration(days: 29)),
        end: DateTime.now().add(const Duration(days: 1)),
        description: "Voucher Rp. 50000",
        status: VoucherStatus.active),
    Voucher(code: "MNOP123456789",
        start: DateTime.now().subtract(const Duration(days: 20)),
        end: DateTime.now().add(const Duration(days: 10)),
        description: "Voucher Rp. 50000",
        status: VoucherStatus.active),
    Voucher(code: "QRST123456789",
        start: DateTime.now().subtract(const Duration(days: 5)),
        end: DateTime.now().add(const Duration(days: 25)),
        description: "Voucher Rp. 50000",
        status: VoucherStatus.active),
    Voucher(code: "ABCD123456789",
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 30)),
        description: "Voucher Rp. 50000",
        status: VoucherStatus.active),
    Voucher(code: "EFGH123456789",
        start: DateTime.now().add(const Duration(days: 1)),
        end: DateTime.now().add(const Duration(days: 31)),
        description: "Voucher Rp. 50000",
        status: VoucherStatus.inactive),
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
      return _dummyVouchers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initVoucherData,
      builder: (context, snapshot) {
        // Loading vouchers
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        // Displaying vouchers
        if (!snapshot.hasError) {
          return _createMainWidget();
        }

        // Error handling
        return const Center(child: Text("Something went wrong!"));
      },
    );
  }

  int get _numberOfActiveVouchers => _vouchers
      .where((item) => item.status == VoucherStatus.active).length;

  Widget _createMainWidget() {
    final topWidget = _createTopWidget();
    final voucherWidgets = _vouchers.map(
      (item) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: VoucherWidget(voucher: item),
      )
    ).toList();

    final scrollableWidgets = <Widget>[];
    scrollableWidgets.add(topWidget);
    scrollableWidgets.addAll(voucherWidgets);

    return RefreshIndicator(
      onRefresh: _refreshVouchers,
      child: ListView(
        children: scrollableWidgets,
      ),
    );
  }

  Widget _createTopWidget() {
    final screenWidth = MediaQuery.of(context).size.width;
    final bigTextStyle = TextStyle(
      color: Colors.white,
      fontSize: screenWidth * 0.07,
      fontWeight: FontWeight.bold,
    );

    final normalTextStyle = TextStyle(
      color: Colors.white,
      fontSize: screenWidth * 0.06,
    );

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        )
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          Text("0898 1111 222", style: bigTextStyle),
          const SizedBox(height: 30),
          Text("$_numberOfActiveVouchers Voucher", style: normalTextStyle),
          Text("Siap Digunakan", style: normalTextStyle),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
