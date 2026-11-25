import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static final NumberFormat _rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static final NumberFormat _numberFormat = NumberFormat.decimalPattern('id_ID');

  /// Format penuh: contoh `Rp 1.416.000`
  static String rupiah(int amount) {
    final isNegative = amount < 0;
    final formatted = _rupiahFormat.format(amount.abs()).replaceAll('\u00A0', ' ');
    return isNegative ? '-$formatted' : formatted;
  }

  /// Format ribuan tanpa simbol: contoh `1.416.000`
  static String number(int amount) {
    return _numberFormat.format(amount);
  }

  /// Format ringkas: contoh `Rp 900 rb`, `Rp 1,3 jt`, `Rp 150 jt`
  static String compactRupiah(int amount) {
    final abs = amount.abs();
    final prefix = amount < 0 ? '-Rp ' : 'Rp ';
    if (abs >= 1000000000) {
      final value = abs / 1000000000;
      return '$prefix${_trimDecimal(value)} M';
    }
    if (abs >= 1000000) {
      final value = abs / 1000000;
      return '$prefix${_trimDecimal(value)} jt';
    }
    if (abs >= 1000) {
      final value = abs / 1000;
      return '$prefix${_trimDecimal(value)} rb';
    }
    return '$prefix$abs';
  }

  static String _trimDecimal(double value) {
    final rounded = (value * 10).round() / 10;
    if (rounded == rounded.roundToDouble()) {
      return rounded.round().toString();
    }
    return rounded.toStringAsFixed(1).replaceAll('.', ',');
  }

  /// Format tanggal penuh Indonesia: contoh `31 Okt 2033`
  static String shortDate(DateTime date) {
    return DateFormat('d MMM yyyy', 'id_ID').format(date);
  }

  /// Format bulan dan tahun: contoh `November 2026`
  static String monthYear(DateTime date) {
    return DateFormat('MMMM yyyy', 'id_ID').format(date);
  }

  /// Format bulan singkat dan tahun: contoh `Okt 2033`
  static String shortMonthYear(DateTime date) {
    return DateFormat('MMM yyyy', 'id_ID').format(date);
  }

  /// Parse tanggal ISO `YYYY-MM-DD` atau null
  static DateTime? parseIsoDate(String? iso) {
    if (iso == null || iso.trim().isEmpty) return null;
    return DateTime.tryParse(iso);
  }

  /// Format ke ISO date `YYYY-MM-DD`
  static String toIsoDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// Format persen: contoh `7,5%` atau `100%`
  static String percent(double pct) {
    final clamped = pct.clamp(0, 999.9);
    if (clamped == clamped.roundToDouble()) {
      return '${clamped.round()}%';
    }
    return '${clamped.toStringAsFixed(1).replaceAll('.', ',')}%';
  }
}
