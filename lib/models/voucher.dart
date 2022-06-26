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
        return "Kadaluarsa";
    }
  }
}
