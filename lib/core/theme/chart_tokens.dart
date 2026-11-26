import 'package:material_ui/material_ui.dart';

class PlanoraChartTokens {
  PlanoraChartTokens._();

  static const Color chartMoney = Color(0xFF0E9F6E); // RDPU / Pasar Uang
  static const Color chartBond = Color(0xFF2F6FDE); // RD Obligasi
  static const Color chartMixed = Color(0xFF14B8A6); // RD Campuran
  static const Color chartEquityFund = Color(0xFF8B5CF6); // RD Saham
  static const Color chartStock = Color(0xFFC026D3); // Saham langsung
  static const Color chartGold = Color(0xFFD9A514); // Emas
  static const Color chartCash = Color(0xFF6B8F71); // Kas/Tunai
  static const Color chartDeposit = Color(0xFF38BDF8); // Deposito
  static const Color chartOther = Color(0xFF94A3B8); // Lainnya

  static const List<String> instrumentPresets = [
    'RDPU',
    'RD Obligasi',
    'RD Campuran',
    'RD Saham',
    'Saham langsung',
    'Emas',
    'Kas/Tunai',
    'Deposito',
    'Lainnya',
  ];

  static Color colorForInstrument(
    String instrument, {
    bool isDark = false,
  }) {
    final norm = instrument.trim().toLowerCase();
    Color base;
    if (norm.contains('rdpu') || norm.contains('pasar uang')) {
      base = chartMoney;
    } else if (norm.contains('obligasi') || norm.contains('sbn')) {
      base = chartBond;
    } else if (norm.contains('campuran')) {
      base = chartMixed;
    } else if (norm.contains('rd saham') || norm.contains('reksa dana saham')) {
      base = chartEquityFund;
    } else if (norm.contains('saham')) {
      base = chartStock;
    } else if (norm.contains('emas')) {
      base = chartGold;
    } else if (norm.contains('kas') || norm.contains('tunai')) {
      base = chartCash;
    } else if (norm.contains('deposito')) {
      base = chartDeposit;
    } else {
      base = chartOther;
    }

    if (!isDark) return base;
    final hsl = HSLColor.fromColor(base);
    return hsl.withLightness((hsl.lightness + 0.10).clamp(0.0, 0.88)).toColor();
  }

  static Color stockTickerColor(int index, {bool isDark = false}) {
    final baseHsl = HSLColor.fromColor(chartStock);
    const lightOffsets = [0.0, 0.12, -0.10, 0.22, -0.18, 0.30];
    const satOffsets = [0.0, -0.06, -0.04, -0.12, -0.10, -0.16];
    final idx = index % lightOffsets.length;
    final baseLight = isDark ? baseHsl.lightness + 0.08 : baseHsl.lightness;
    final nextLight = (baseLight + lightOffsets[idx]).clamp(0.24, 0.82);
    final nextSat = (baseHsl.saturation + satOffsets[idx]).clamp(0.35, 0.90);
    return baseHsl.withLightness(nextLight).withSaturation(nextSat).toColor();
  }

  static IconData iconForInstrument(String instrument) {
    final norm = instrument.trim().toLowerCase();
    if (norm.contains('rdpu') || norm.contains('pasar uang')) {
      return Icons.account_balance_wallet_outlined;
    }
    if (norm.contains('obligasi')) return Icons.description_outlined;
    if (norm.contains('campuran')) return Icons.pie_chart_outline;
    if (norm.contains('saham')) return Icons.show_chart_rounded;
    if (norm.contains('emas')) return Icons.workspace_premium_outlined;
    if (norm.contains('kas') || norm.contains('tunai')) {
      return Icons.payments_outlined;
    }
    if (norm.contains('deposito')) return Icons.lock_clock_outlined;
    return Icons.category_outlined;
  }

  static String compactRupiah(int amount) {
    final abs = amount.abs();
    final sign = amount < 0 ? '-' : '';
    if (abs >= 1000000000) {
      final v = abs / 1000000000.0;
      final s = v == v.roundToDouble()
          ? v.round().toString()
          : v.toStringAsFixed(1).replaceAll('.', ',');
      return '${sign}Rp $s M';
    }
    if (abs >= 1000000) {
      final v = abs / 1000000.0;
      final s = v == v.roundToDouble()
          ? v.round().toString()
          : v.toStringAsFixed(1).replaceAll('.', ',');
      return '${sign}Rp $s jt';
    }
    if (abs >= 1000) {
      final v = (abs / 1000.0).round();
      return '${sign}Rp $v rb';
    }
    return '${sign}Rp $abs';
  }
}

