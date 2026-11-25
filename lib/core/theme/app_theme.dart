import 'package:material_ui/material_ui.dart';
import 'package:planora/core/theme/planora_colors.dart';

class AppTheme {
  AppTheme._();

  static const Color bankGreen = PlanoraColors.primary;
  static const Color bankGreenLight = PlanoraColors.greenBright;
  static const Color surfaceBg = PlanoraColors.screenBg;
  static const Color cardBg = PlanoraColors.cardSurface;
  static const Color textPrimary = PlanoraColors.inkPrimary;
  static const Color textSecondary = PlanoraColors.inkMuted;
  static const Color borderSubtle = PlanoraColors.cardBorder;
  static const Color danger = PlanoraColors.danger;
  static const Color warning = PlanoraColors.gold;
  static const Color success = PlanoraColors.greenBright;

  static const List<FontFeature> tabularFigures = [
    FontFeature.tabularFigures(),
  ];

  static TextStyle sora({
    double size = 21,
    FontWeight weight = FontWeight.w700,
    Color? color,
    bool tabular = false,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Sora',
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      fontFeatures: tabular ? tabularFigures : null,
    );
  }

  static TextStyle manrope({
    double size = 13,
    FontWeight weight = FontWeight.w500,
    Color? color,
    bool tabular = false,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      fontFeatures: tabular ? tabularFigures : null,
    );
  }

  static TextStyle mono({
    double size = 11.5,
    FontWeight weight = FontWeight.w500,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: 'JetBrainsMono',
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle uppercaseLabel({Color? color}) {
    return manrope(
      size: 10.5,
      weight: FontWeight.w700,
      color: color ?? PlanoraColors.inkFaded,
      letterSpacing: 0.84,
    );
  }

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: PlanoraColors.primary,
      primary: PlanoraColors.primary,
      onPrimary: Colors.white,
      secondary: PlanoraColors.greenBright,
      onSecondary: Colors.white,
      error: PlanoraColors.danger,
      surface: PlanoraColors.cardSurface,
      onSurface: PlanoraColors.inkPrimary,
      onSurfaceVariant: PlanoraColors.inkMuted,
      outlineVariant: PlanoraColors.cardBorder,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Manrope',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: PlanoraColors.screenBg,
      appBarTheme: AppBarTheme(
        backgroundColor: PlanoraColors.screenBg,
        foregroundColor: PlanoraColors.inkPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: sora(
          size: 21,
          weight: FontWeight.w700,
          color: PlanoraColors.inkPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: PlanoraColors.cardSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: PlanoraColors.cardBorder, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: PlanoraColors.hairlineDivider,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PlanoraColors.cardSurface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide:
              const BorderSide(color: PlanoraColors.inputBorder, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide:
              const BorderSide(color: PlanoraColors.inputBorder, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide:
              const BorderSide(color: PlanoraColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: PlanoraColors.danger, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: PlanoraColors.danger, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: PlanoraColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          textStyle: manrope(size: 13.5, weight: FontWeight.w800),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PlanoraColors.primary,
          side: const BorderSide(color: PlanoraColors.primary, width: 1.2),
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          textStyle: manrope(size: 13.5, weight: FontWeight.w800),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PlanoraColors.primary,
          minimumSize: const Size(48, 48),
          textStyle: manrope(size: 13, weight: FontWeight.w800),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: PlanoraColors.greenBright,
      brightness: Brightness.dark,
      primary: const Color(0xFF34D399),
      onPrimary: const Color(0xFF06281E),
      secondary: const Color(0xFF6EE7B7),
      onSecondary: const Color(0xFF06281E),
      error: const Color(0xFFF87171),
      surface: PlanoraColors.darkCard,
      onSurface: PlanoraColors.darkInkPrimary,
      onSurfaceVariant: PlanoraColors.darkInkSecondary,
      outlineVariant: PlanoraColors.darkBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Manrope',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: PlanoraColors.darkBg,
      appBarTheme: AppBarTheme(
        backgroundColor: PlanoraColors.darkBg,
        foregroundColor: PlanoraColors.darkInkPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: sora(
          size: 21,
          weight: FontWeight.w700,
          color: PlanoraColors.darkInkPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: PlanoraColors.darkCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: PlanoraColors.darkBorder, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: PlanoraColors.darkBorder,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PlanoraColors.darkCard,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide:
              const BorderSide(color: PlanoraColors.darkBorder, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide:
              const BorderSide(color: PlanoraColors.darkBorder, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Color(0xFF34D399), width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          textStyle: manrope(size: 13.5, weight: FontWeight.w800),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          textStyle: manrope(size: 13.5, weight: FontWeight.w800),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          textStyle: manrope(size: 13, weight: FontWeight.w800),
        ),
      ),
    );
  }
}

