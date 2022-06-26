import 'package:flutter/material.dart';
import 'dart:math';

import '../common_widgets/voucher_widget.dart';
import '../models/voucher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              children: _vouchers.map((item) => VoucherWidget(voucher: item))
                  .toList(),
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
}
