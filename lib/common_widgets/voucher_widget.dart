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
  final DateFormat formatter;

  late double screenWidth = MediaQuery.of(context).size.width;
  late TextStyle smallTextStyle = TextStyle(
    color: Colors.grey[600],
    fontSize: screenWidth * 0.035,
  );

  _VoucherWidgetState(): formatter = DateFormat("d MMMM yyyy");

  @override
  Widget build(BuildContext context) {
    final voucher = widget.voucher;

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
                        children: _createTextWidgets(),
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

  List<Widget> _createTextWidgets() {
    if (widget.voucher.status == VoucherStatus.expired) {
      return <Widget>[
        Text(
          "Berakhir pada ${formatter.format(widget.voucher.end)}",
          style: smallTextStyle,
        ),
        _createStatusText(),
      ];
    }

    if (widget.voucher.status == VoucherStatus.used
        && widget.voucher.usedDate != null) {
      return <Widget>[
        Text(
          "Digunakan pada ${formatter.format(widget.voucher.usedDate!)}",
          style: smallTextStyle,
        ),
        _createStatusText(),
      ];
    }

    if (widget.voucher.status == VoucherStatus.active
        || widget.voucher.status == VoucherStatus.inactive) {
      return <Widget>[
        Text(
          "Berlaku Mulai: ${formatter.format(widget.voucher.start)}",
          style: smallTextStyle,
        ),
        Text(
          "Berlaku Hingga: ${formatter.format(widget.voucher.end)}",
          style: smallTextStyle,
        ),
        _createStatusText(),
      ];
    }

    return <Widget>[_createStatusText()];
  }

  Widget _createStatusText() {
    return RichText(
      text: TextSpan(
        style: smallTextStyle,
        children: <TextSpan>[
          const TextSpan(text: 'Status: '),
          TextSpan(
              text: widget.voucher.getVoucherStatus(),
              style: const TextStyle(fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }

  Widget? _createClaimButton() {
    if (widget.voucher.status == VoucherStatus.expired
        || widget.voucher.status == VoucherStatus.used) {
      return null;
    }

    const widgetChild = Text("Claim");

    if (widget.voucher.status != VoucherStatus.active || _buttonClicked) {
      // Returns a disabled button
      return const ElevatedButton(onPressed: null, child: widgetChild);
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
