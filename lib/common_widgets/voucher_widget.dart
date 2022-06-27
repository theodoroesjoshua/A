import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/api.dart';
import '../models/voucher.dart';

class VoucherWidget extends StatefulWidget {
  final Voucher voucher;

  const VoucherWidget({ Key? key, required this.voucher }) : super(key: key);

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  @override
  Widget build(BuildContext context) {
    final voucher = widget.voucher;
    final screenWidth = MediaQuery.of(context).size.width;
    DateFormat formatter = DateFormat("d MMMM yyyy");

    final smallTextStyle = TextStyle(
      color: Colors.grey[600],
      fontSize: screenWidth * 0.035,
    );

    return Card(
      color: Colors.white,
      elevation: 7.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    voucher.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
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
                      trailing: ElevatedButton(
                        onPressed: (voucher.status == VoucherStatus.active) ?
                            _claimVoucher : null,
                        child: const Text("Claim"),
                      ),
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
        ),
      ),
    );
  }

  void _claimVoucher() {
    final api = Api();
    api.claimVoucher(widget.voucher.code);
  }
}
