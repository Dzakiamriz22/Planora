import 'package:material_ui/material_ui.dart';
import 'package:planora/core/theme/planora_colors.dart';

class PlatformPresetOption {
  const PlatformPresetOption(this.code, this.label);
  final String code;
  final String label;
}

class NeutralPortfolioExample {
  const NeutralPortfolioExample({
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
  });

  final String name;
  final String category;
  final String icon;
  final int color;
}

class PortfolioPalette {
  PortfolioPalette._();

  /// Preset Platform generik tanpa merek (Bab A.3 & p.6).
  static const List<PlatformPresetOption> platformPresets = [
    PlatformPresetOption('aperd', 'Aplikasi investasi / APERD'),
    PlatformPresetOption('broker', 'Broker sekuritas'),
    PlatformPresetOption('bank', 'Bank'),
    PlatformPresetOption('ewallet', 'E-Wallet'),
    PlatformPresetOption('self_storage', 'Penyimpanan sendiri / Brankas'),
    PlatformPresetOption('other', 'Lainnya'),
  ];

  static String platformPresetLabel(String? code) {
    if (code == null || code.isEmpty) return 'Lainnya';
    for (final opt in platformPresets) {
      if (opt.code == code) return opt.label;
    }
    return 'Lainnya';
  }

  /// Label tampil Platform: memakai `platformName` teks bebas pengguna bila diisi,
  /// atau label preset generik bila kosong (FR-07).
  static String displayPlatform(String? preset, String? customName) {
    if (customName != null && customName.trim().isNotEmpty) {
      return customName.trim();
    }
    if (preset != null && preset.trim().isNotEmpty) {
      return platformPresetLabel(preset);
    }
    return 'Belum diatur';
  }

  /// Preset Instrumen / Komponen generik tanpa merek (Bab A.3 & p.6).
  static const List<String> instrumentPresets = [
    'Kas/Tunai',
    'RDPU',
    'RD Obligasi',
    'RD Campuran',
    'RD Saham',
    'Saham langsung',
    'Emas',
    'Deposito',
    'Lainnya',
  ];

  /// Contoh netral onboarding — hanya mengisi nama & kategori, tanpa nominal/platform/tanggal (p.7).
  static const List<NeutralPortfolioExample> onboardingExamples = [
    NeutralPortfolioExample(
      name: 'Dana Darurat',
      category: 'cash',
      icon: 'shield',
      color: 0xFF0E7C66,
    ),
    NeutralPortfolioExample(
      name: 'Tabungan Liburan',
      category: 'cash',
      icon: 'flight',
      color: 0xFFC4557A,
    ),
    NeutralPortfolioExample(
      name: 'DP Rumah',
      category: 'down_payment',
      icon: 'home',
      color: 0xFF2F6DB3,
    ),
    NeutralPortfolioExample(
      name: 'Kendaraan',
      category: 'down_payment',
      icon: 'directions_car',
      color: 0xFFD97706,
    ),
    NeutralPortfolioExample(
      name: 'Investasi Rutin',
      category: 'no_target',
      icon: 'trending_up',
      color: 0xFF6D5BD0,
    ),
    NeutralPortfolioExample(
      name: 'Tujuan Bebas',
      category: 'cash',
      icon: 'savings',
      color: 0xFFB3402A,
    ),
  ];

  static const Map<String, IconData> icons = {
    'shield': Icons.shield_outlined,
    'favorite': Icons.favorite_outline,
    'home': Icons.home_outlined,
    'directions_car': Icons.directions_car_outlined,
    'trending_up': Icons.trending_up,
    'candlestick_chart': Icons.candlestick_chart_outlined,
    'savings': Icons.savings_outlined,
    'school': Icons.school_outlined,
    'flight': Icons.flight_outlined,
    'laptop': Icons.laptop_mac_outlined,
    'medical': Icons.medical_services_outlined,
    'wallet': Icons.account_balance_wallet_outlined,
  };

  static const List<int> colors = PlanoraColors.sixPortfolioColors;

  static IconData iconFor(String key) {
    return icons[key] ?? Icons.savings_outlined;
  }
}
