import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/constants/portfolio_palette.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/profile_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/widgets/planora_logo.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _step = 0;
  bool _saving = false;

  final _fullNameCtrl = TextEditingController();
  final _nickNameCtrl = TextEditingController();

  final _salaryCtrl = TextEditingController();
  final _minLivingCtrl = TextEditingController();

  final _portoNameCtrl = TextEditingController();
  String _portoCategory = 'cash';
  String _portoIcon = 'savings';
  int _portoColor = PlanoraColors.sixPortfolioColors.first;

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _nickNameCtrl.dispose();
    _salaryCtrl.dispose();
    _minLivingCtrl.dispose();
    _portoNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _skipAll() async {
    await ref.read(settingsRepositoryProvider).markOnboardingDone();
    if (mounted) context.go('/home');
  }

  Future<void> _saveStepAndNext() async {
    if (_step == 0) {
      setState(() => _step = 1);
      return;
    }

    setState(() => _saving = true);
    try {
      if (_step == 1) {
        if (_fullNameCtrl.text.trim().isNotEmpty ||
            _nickNameCtrl.text.trim().isNotEmpty) {
          await ref.read(profileRepositoryProvider).updateProfile(
                displayNameFull: _fullNameCtrl.text.trim(),
                displayName: _nickNameCtrl.text.trim(),
              );
        }
        setState(() => _step = 2);
      } else if (_step == 2) {
        final salary = parseRupiahInput(_salaryCtrl.text);
        final minLiving = parseRupiahInput(_minLivingCtrl.text);
        if (salary > 0 || minLiving > 0) {
          await ref.read(settingsRepositoryProvider).updateFinancialProfile(
                monthlySalary: salary > 0 ? salary : null,
                minimumLivingCost: salary > 0 ? minLiving : null,
              );
        }
        setState(() => _step = 3);
      } else if (_step == 3) {
        if (_portoNameCtrl.text.trim().isNotEmpty) {
          await ref.read(portfolioRepositoryProvider).createPortfolio(
                name: _portoNameCtrl.text.trim(),
                category: _portoCategory,
                monthlyPlan: 0,
                annualReturnPct: 5.0,
                icon: _portoIcon,
                color: _portoColor,
              );
        }
        await ref.read(settingsRepositoryProvider).markOnboardingDone();
        if (mounted) context.go('/home');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final salaryVal = parseRupiahInput(_salaryCtrl.text);
    final minLivingVal = parseRupiahInput(_minLivingCtrl.text);
    final previewCeiling = salaryVal > 0
        ? PlanoraCalc.ceiling(
            monthlySalary: salaryVal,
            minimumLivingCost: minLivingVal,
          )
        : null;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Langkah ${_step + 1} dari 4',
                    style: AppTheme.uppercaseLabel(color: cs.onSurfaceVariant),
                  ),
                  TextButton(
                    onPressed: _saving ? null : _skipAll,
                    child: const Text('Lewati dulu'),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              PlanoraProgressBar(
                value: (_step + 1) / 4.0,
                color: PlanoraColors.primary,
                height: 5,
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: switch (_step) {
                    0 => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Center(child: PlanoraLogo(size: 88)),
                          const SizedBox(height: 24),
                          Text(
                            'Selamat datang di Planora',
                            style: AppTheme.sora(
                              size: 24,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Atur beberapa tujuan keuangan sekaligus sesuai batas nabung bulananmu. Semua data tersimpan di HP, 100% offline, dan tanpa akun.',
                            style: AppTheme.manrope(
                              size: 14,
                              color: cs.onSurfaceVariant,
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PlanoraNoteBox(
                            child: Text(
                              'Planora mulai dari nol — kamu bebas menentukan tujuan, nominal, tempat simpan, dan porsi instrumen sesuai kebutuhan sendiri.',
                              style: AppTheme.manrope(
                                size: 12.5,
                                color: cs.onSurfaceVariant,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    1 => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profil Lokal',
                            style: AppTheme.sora(
                              size: 22,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tersimpan di HP ini, bukan akun online. Boleh dikosongkan dan diisi nanti.',
                            style: AppTheme.manrope(
                              size: 13,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            controller: _nickNameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Nama sapaan (opsional)',
                              hintText: 'Dipakai untuk sapaan di Beranda',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _fullNameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Nama lengkap (opsional)',
                            ),
                          ),
                        ],
                      ),
                    2 => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profil Keuangan',
                            style: AppTheme.sora(
                              size: 22,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Batas nabung bulanan dihitung otomatis dari gaji dikurangi biaya hidup minimum.',
                            style: AppTheme.manrope(
                              size: 13,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 18),
                          RupiahTextField(
                            controller: _salaryCtrl,
                            label: 'Gaji bulanan (opsional)',
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 12),
                          RupiahTextField(
                            controller: _minLivingCtrl,
                            label: 'Biaya hidup minimum (opsional)',
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 14),
                          PlanoraNoteBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Batas nabung bulanan',
                                  style: AppTheme.manrope(size: 12.5),
                                ),
                                Text(
                                  previewCeiling == null
                                      ? 'Belum diatur'
                                      : '${AppFormatters.rupiah(previewCeiling)}/bln',
                                  style: AppTheme.manrope(
                                    size: 13.5,
                                    weight: FontWeight.w800,
                                    color: PlanoraColors.primary,
                                    tabular: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    _ => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Porto Pertama',
                            style: AppTheme.sora(
                              size: 22,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Pilih contoh netral (hanya mengisi nama & kategori) atau ketik tujuan Anda sendiri. Nominal dan platform diatur nanti.',
                            style: AppTheme.manrope(
                              size: 13,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                PortfolioPalette.onboardingExamples.map((ex) {
                              final selected = _portoNameCtrl.text == ex.name;
                              return ChoiceChip(
                                label: Text(ex.name),
                                selected: selected,
                                onSelected: (_) {
                                  setState(() {
                                    _portoNameCtrl.text = ex.name;
                                    _portoCategory = ex.category;
                                    _portoIcon = ex.icon;
                                    _portoColor = ex.color;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _portoNameCtrl,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              labelText: 'Nama porto pertama (opsional)',
                              hintText: 'Contoh: Dana Darurat',
                            ),
                          ),
                          const SizedBox(height: 12),
                          SegmentedButton<String>(
                            segments: const [
                              ButtonSegment(
                                value: 'cash',
                                label: Text('Tunai'),
                              ),
                              ButtonSegment(
                                value: 'down_payment',
                                label: Text('DP + Biaya'),
                              ),
                              ButtonSegment(
                                value: 'no_target',
                                label: Text('Tanpa Target'),
                              ),
                            ],
                            selected: {_portoCategory},
                            onSelectionChanged: (set) =>
                                setState(() => _portoCategory = set.first),
                          ),
                        ],
                      ),
                  },
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  if (_step > 0) ...[
                    OutlinedButton(
                      onPressed:
                          _saving ? null : () => setState(() => _step -= 1),
                      child: const Text('Kembali'),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: FilledButton(
                      onPressed: _saving ? null : _saveStepAndNext,
                      child: Text(
                        _step == 0
                            ? 'Mulai Atur'
                            : (_step == 3 ? 'Selesai & Masuk' : 'Lanjut'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

