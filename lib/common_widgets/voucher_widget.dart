import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/api.dart';
import '../models/voucher.dart';

class VoucherWidget extends StatefulWidget {
  final Voucher voucher;
  final Function claimCallback;

  const VoucherWidget({
    Key? key,
    required this.voucher,
    required this.claimCallback,
  }) : super(key: key);

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  bool _buttonClicked = false;

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
                      trailing: _createClaimButton(),
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

  Widget _createClaimButton() {
    final widgetChild = const Text("Claim");

    if (widget.voucher.status != VoucherStatus.active || _buttonClicked) {
      // Returns a disabled button
      return ElevatedButton(onPressed: null, child: widgetChild);
    }

    return ElevatedButton(
      onPressed: _claimVoucher,
      child: widgetChild,
    );
  }
  void _claimVoucher() {
    final api = Api();
    setState(() { _buttonClicked = true; });
    api.claimVoucher(widget.voucher.code)
        .then((value) => widget.claimCallback())
        .then((value) => setState(() { _buttonClicked = false; }));
  }
}
