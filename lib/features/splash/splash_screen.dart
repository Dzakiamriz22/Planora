import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/widgets/planora_logo.dart';

/// Splash animasi Planora v2.1 — total 2,4 detik sesuai Bab A.5 & Library Bab 02.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _word = 'Planora';
  late final AnimationController _controller;
  bool _navigated = false;
  bool _firstRun = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _boot();
  }

  Future<void> _boot() async {
    final settingsFuture = ref.read(settingsRepositoryProvider).getSettings();
    final animFuture = _controller.forward().orCancel.catchError((_) {});

    final settings = await settingsFuture;
    _firstRun = !settings.onboardingDone;
    await animFuture;

    if (!mounted || _navigated) return;
    _navigated = true;
    context.go(_firstRun ? '/onboarding' : '/home');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (reduceMotion && _controller.duration!.inMilliseconds > 200) {
      _controller.duration = const Duration(milliseconds: 120);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF073325),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;

            // Tahap 1 (0,0 - 0,8 dtk): Logo masuk (fade + scale)
            final logoOpacity = (t / 0.25).clamp(0.0, 1.0);
            final logoScale = t < 0.25
                ? 0.72 + Curves.easeOutCubic.transform(t / 0.25) * 0.30
                : (t < 0.34
                    ? 1.02 - ((t - 0.25) / 0.09) * 0.02
                    : 1.0);

            // Tahap 2 (0,6 - 1,6 dtk): Garis emas menyapu kiri ke kanan
            final lineProgress = ((t - 0.25) / 0.40).clamp(0.0, 1.0);
            final lineWidth =
                Curves.easeInOut.transform(lineProgress) * 118.0;

            // Tahap 4 (2,0 - 2,4 dtk): Cross-fade keluar
            final exitOpacity =
                t > 0.84 ? (1.0 - ((t - 0.84) / 0.16)).clamp(0.0, 1.0) : 1.0;

            // Tagline fade-in (1,7 - 2,0 dtk)
            final tagOpacity = ((t - 0.70) / 0.14).clamp(0.0, 1.0);

            return Opacity(
              opacity: exitOpacity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: logoOpacity,
                    child: Transform.scale(
                      scale: logoScale,
                      child: const PlanoraLogo(size: 104),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 118,
                    height: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: lineWidth,
                        height: 4,
                        decoration: BoxDecoration(
                          color: PlanoraColors.gold,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_word.length, (i) {
                      // Tahap 3 (1,2 - 2,0 dtk): huruf demi huruf
                      final start = 0.50 + i * 0.035;
                      final p = ((t - start) / 0.12).clamp(0.0, 1.0);
                      return Opacity(
                        opacity: p,
                        child: Transform.translate(
                          offset: Offset(0, (1.0 - p) * 10),
                          child: Text(
                            _word[i],
                            style: AppTheme.sora(
                              size: 31,
                              weight: FontWeight.w800,
                              color: const Color(0xFFF7F3E7),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 6),
                  Opacity(
                    opacity: tagOpacity,
                    child: Text(
                      'Rencanakan. Tabung. Tercapai.',
                      style: AppTheme.manrope(
                        size: 12.5,
                        weight: FontWeight.w600,
                        color: const Color(0xFFBCD3C2),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
