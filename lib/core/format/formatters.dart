import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static final NumberFormat _rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static final NumberFormat _numberFormat = NumberFormat.decimalPattern('id_ID');

  static const String maskedRupiah = 'Rp ••••••';
  static bool hideAmounts = false;

  static String rupiah(int amount, {bool allowMask = true}) {
    if (allowMask && hideAmounts) return maskedRupiah;
    final isNegative = amount < 0;
    final formatted = _rupiahFormat.format(amount.abs()).replaceAll('\u00A0', ' ');
    return isNegative ? '-$formatted' : formatted;
  }

  static String number(int amount) {
    return _numberFormat.format(amount);
  }

  static String compactRupiah(int amount, {bool allowMask = true}) {
    if (allowMask && hideAmounts) return maskedRupiah;
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

  static String shortDate(DateTime date) {
    return DateFormat('d MMM yyyy', 'id_ID').format(date);
  }

  static String monthYear(DateTime date) {
    return DateFormat('MMMM yyyy', 'id_ID').format(date);
  }

  static String shortMonthYear(DateTime date) {
    return DateFormat('MMM yyyy', 'id_ID').format(date);
  }

  static String monthYearShort(DateTime date) => shortMonthYear(date);

  static String monthShort(DateTime date) {
    return DateFormat('MMM', 'id_ID').format(date);
  }

  static String toYearMonth(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$y-$m';
  }

  static DateTime? parseIsoDate(String? iso) {
    if (iso == null || iso.trim().isEmpty) return null;
    return DateTime.tryParse(iso);
  }

  static String toIsoDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static String percent(double pct) {
    final clamped = pct.clamp(0, 999.9);
    if (clamped == clamped.roundToDouble()) {
      return '${clamped.round()}%';
    }
    return '${clamped.toStringAsFixed(1).replaceAll('.', ',')}%';
  }
}

