import 'package:flutter/material.dart';

import '../api/api.dart';
import '../common_widgets/voucher_widget.dart';
import '../models/voucher.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<void> _initVoucherData;
  late List<Voucher> _vouchers;
  final Api _api = Api();

  @override
  void initState() {
    super.initState();
    _initVoucherData = _initVouchers();
  }

  Future<void> _initVouchers() async {
    _vouchers = await _api.getHistoryVouchers();
  }

  Future<void> _refreshVouchers() async {
    final vouchers = await _api.getHistoryVouchers();
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

  Widget _createMainWidget() {
    final topWidget = _createTopWidget();
    final voucherWidgets = _vouchers.map(
          (item) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: VoucherWidget(
              voucher: item,
              claimCallback: () => setState(() {
                _initVoucherData = _refreshVouchers();
              }),
            ),
          ),
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
      fontSize: screenWidth * 0.07,
      fontWeight: FontWeight.bold,
    );

    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Text("Riwayat", style: bigTextStyle),
        const SizedBox(height: 10),
      ],
    );
  }
}
