import 'package:flutter/material.dart';
import 'package:sugoi/api/api.dart';

import '../common_widgets/voucher_widget.dart';
import '../models/voucher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _initVoucherData;
  late List<Voucher> _vouchers;
  final Api _api = Api();

  @override
  void initState() {
    super.initState();
    _initVoucherData = _initVouchers();
  }

  Future<void> _initVouchers() async {
    _vouchers = await _api.getVouchers();
  }

  Future<void> _refreshVouchers() async {
    final vouchers = await _api.getVouchers();
    setState(() {
      _vouchers = vouchers;
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
