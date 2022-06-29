import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/voucher.dart';
import 'package:collection/collection.dart';

class Api {
  // Singleton API object
  static final Api _api = Api._internal();
  factory Api() {
    return _api;
  }
  Api._internal();

  final _storage = const FlutterSecureStorage();

  final List<Voucher> _availableVouchers = [
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

  final List<Voucher> _historyVouchers = [
    Voucher(code: "RJTJ123456789",
        start: DateTime.now().subtract(const Duration(days: 31)),
        end: DateTime.now().subtract(const Duration(days: 1)),
        description: "Voucher Rp. 50000",
        usedDate: DateTime.now().subtract(const Duration(days: 2)),
        status: VoucherStatus.used),
    Voucher(code: "AGGT123456789",
        start: DateTime.now().subtract(const Duration(days: 33)),
        end: DateTime.now().subtract(const Duration(days: 3)),
        description: "Voucher Rp. 50000",
        status: VoucherStatus.expired),
    Voucher(code: "TRYY123456789",
        start: DateTime.now().subtract(const Duration(days: 35)),
        end: DateTime.now().subtract(const Duration(days: 5)),
        description: "Voucher Rp. 50000",
        usedDate: DateTime.now().subtract(const Duration(days: 10)),
        status: VoucherStatus.used),
  ];

  Future<List<Voucher>> getVouchers() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return _availableVouchers;
    });
  }

  Future<bool> claimVoucher(String code) async {
    return Future.delayed(const Duration(seconds: 2), () {
      Voucher? voucher = _availableVouchers
          .firstWhereOrNull((item) => item.code == code);

      if (voucher == null || voucher.status != VoucherStatus.active) {
        return false;
      }

      for (int i = 0; i < _availableVouchers.length; i++) {
        if (_availableVouchers[i].code != code) {
          continue;
        }

        Voucher removedVoucher = _availableVouchers.removeAt(i);
        _historyVouchers.insert(0, Voucher(
          code: removedVoucher.code,
          start: removedVoucher.start,
          end: removedVoucher.end,
          usedDate: DateTime.now(),
          description: removedVoucher.description,
          status: VoucherStatus.used,
        ));   // Insert to the front of the list
        break;
      }

      return true;
    });
  }

  Future<List<Voucher>> getHistoryVouchers() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return _historyVouchers;
    });
  }

  Future<bool> signIn(String username, String password) async {
    return Future.delayed(const Duration(seconds: 2), () async {
      if (username != "Yehezkiel" && password != "123456") {
        return false;
      }

      await _storage.write(key: "token", value: "Yehezkiel");
      return true;
    });
  }

  Future<void> signOut() async {
    await _storage.delete(key: "token");
  }

}
