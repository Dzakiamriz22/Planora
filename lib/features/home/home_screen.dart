import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/portfolios/contribution_sheet.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rebalance_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
  }

  bool get _isCurrentMonth {
    final now = DateTime.now();
    return _selectedMonth.year == now.year && _selectedMonth.month == now.month;
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat pagi,';
    if (hour < 15) return 'Selamat siang,';
    if (hour < 18) return 'Selamat sore,';
    return 'Selamat malam,';
  }

  void _shiftMonth(int delta) {
    final now = DateTime.now();
    final next = DateTime(_selectedMonth.year, _selectedMonth.month + delta, 1);
    final currentMonth = DateTime(now.year, now.month, 1);
    if (next.isAfter(currentMonth)) return;
    setState(() => _selectedMonth = next);
  }

  Future<void> _scaleDownToCeiling(FinancialSummary summary) async {
    final ceiling = summary.ceiling;
    if (ceiling == null) return;

    final portfolios = ref.read(portfoliosStreamProvider).value ?? const [];
    final result = PlanoraCalc.scaleAllToCeiling(
      items: portfolios
          .map(
            (p) => RebalanceItem(
              id: p.id,
              name: p.name,
              currentAmount: p.monthlyPlan,
            ),
          )
          .toList(),
      ceilingAmount: ceiling,
    );

    final approved = await showRebalancePreviewDialog(
      context,
      result: result,
      ceilingAmount: ceiling,
      title: 'Skalakan Rencana ke Plafon',
      subtitle:
          'Total rencana saat ini melebihi plafon sebesar ${AppFormatters.rupiah(summary.overCeilingBy)}. Seluruh porto akan diturunkan secara proporsional agar sesuai plafon ${AppFormatters.rupiah(ceiling)}.',
    );
    if (!approved) return;

    final updatedPlans = {
      for (final ch in result.changes) ch.id: ch.newAmount,
    };
    await ref.read(portfolioRepositoryProvider).applyMonthlyPlans(updatedPlans);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rencana setoran berhasil diskalakan sesuai plafon.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(userProfileStreamProvider).value;
    final summary = ref.watch(financialSummaryProvider);
    final snapshots = ref.watch(portfolioSnapshotsProvider);
    final checklist = ref.watch(monthlyChecklistProvider(_selectedMonth));
    final completedCount = checklist.where((c) => c.isCompleted).length;
    final cs = Theme.of(context).colorScheme;

    // Nama sapaan hanya dari Profil Pengguna lokal (FR-03)
    final nick = profile?.displayName?.trim();
    final displayTitle = (nick != null && nick.isNotEmpty) ? nick : 'Planora';
    final avatarPath = profile?.avatarPath;
    final hasPhoto = avatarPath != null &&
        avatarPath.isNotEmpty &&
        File(avatarPath).existsSync();
    final initial =
        (nick != null && nick.isNotEmpty) ? nick[0].toUpperCase() : '';

    final ceiling = summary.ceiling;
    final ceilingRatio = (ceiling == null || ceiling <= 0)
        ? 0.0
        : (summary.totalMonthlyPlan / ceiling).clamp(0.0, 1.0);

    // Subtotal dinamis per instrumen yang benar-benar dipakai (FR-28)
    final instrumentEntries = summary.instrumentSubtotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topRemaining = snapshots
        .where((s) => s.hasTarget && s.remaining > 0)
        .toList()
      ..sort((a, b) => b.remaining.compareTo(a.remaining));
    final topTwo = topRemaining.take(2).toList();

    final plafonChip = ceiling == null
        ? PlanoraPill.gray('Belum diatur')
        : (summary.isOverCeiling
            ? PlanoraPill.danger('Melebihi plafon')
            : (summary.remainingCeiling == 0
                ? PlanoraPill.green('Pas plafon')
                : PlanoraPill.green('Dalam plafon')));

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
          children: [
            // App Bar: Avatar membuka Profil lokal, lonceng membuka Riwayat
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () => context.push('/profile'),
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: PlanoraColors.primary,
                    backgroundImage:
                        hasPhoto ? FileImage(File(avatarPath)) : null,
                    child: hasPhoto
                        ? null
                        : (initial.isNotEmpty
                            ? Text(
                                initial,
                                style: AppTheme.sora(
                                  size: 15,
                                  weight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: 20,
                              )),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => context.push('/profile'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting(),
                          style: AppTheme.manrope(
                            size: 11.5,
                            weight: FontWeight.w500,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          displayTitle,
                          style: AppTheme.manrope(
                            size: 15,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PlanoraAppBarIconButton(
                  icon: Icons.history_rounded,
                  tooltip: 'Riwayat setoran global',
                  onPressed: () => context.push('/history'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 1. Kartu Saldo Hijau Solid (#0B4A34) + subtotal dinamis per instrumen saja (FR-28)
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                color: PlanoraColors.primary,
                child: Stack(
                  children: [
                    Positioned(
                      right: -28,
                      top: -28,
                      child: Container(
                        width: 132,
                        height: 132,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.07),
                            width: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 26,
                      bottom: -44,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.05),
                            width: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL SALDO PORTOFOLIO',
                            style: AppTheme.uppercaseLabel(
                              color: PlanoraColors.balanceLabel,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppFormatters.rupiah(summary.totalBalance),
                            style: AppTheme.sora(
                              size: 27,
                              weight: FontWeight.w800,
                              color: PlanoraColors.balanceText,
                              tabular: true,
                              letterSpacing: -0.5,
                            ),
                          ),
                          if (instrumentEntries.isNotEmpty) ...[
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: instrumentEntries
                                  .map(
                                    (e) => _InstrumentSubtotalBox(
                                      label: e.key.toUpperCase(),
                                      value: AppFormatters.rupiah(e.value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 2. Kartu Plafon Nabung (mendukung keadaan "belum diatur" FR-05)
            PlanoraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Plafon Nabung — ${AppFormatters.monthYear(_selectedMonth)}',
                          style: AppTheme.manrope(
                            size: 13,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      plafonChip,
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (ceiling == null) ...[
                    Text(
                      'Atur gaji bulanan dan biaya hidup minimum untuk mengaktifkan plafon menabung otomatis.',
                      style: AppTheme.manrope(
                        size: 12,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => context.go('/settings'),
                        child: const Text('Atur Gaji & Biaya Hidup'),
                      ),
                    ),
                  ] else ...[
                    PlanoraProgressBar(
                      value: ceilingRatio,
                      color: summary.isOverCeiling
                          ? PlanoraColors.danger
                          : PlanoraColors.greenBright,
                      height: 7,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Rencana ${AppFormatters.rupiah(summary.totalMonthlyPlan)} dari plafon',
                            style: AppTheme.manrope(
                              size: 11.5,
                              color: cs.onSurfaceVariant,
                              tabular: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppFormatters.rupiah(ceiling),
                                style: AppTheme.manrope(
                                  size: 13,
                                  weight: FontWeight.w800,
                                  color: summary.isOverCeiling
                                      ? PlanoraColors.danger
                                      : cs.onSurface,
                                  tabular: true,
                                ),
                              ),
                              TextSpan(
                                text: ' /bln',
                                style: AppTheme.manrope(
                                  size: 11.5,
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (summary.isOverCeiling) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: PlanoraColors.danger,
                          ),
                          onPressed: () => _scaleDownToCeiling(summary),
                          icon: const Icon(Icons.balance, size: 18),
                          label: Text(
                            'Skalakan Turun Proporsional (${AppFormatters.rupiah(summary.overCeilingBy)})',
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Keadaan kosong bila belum ada porto (Bab A.4)
            if (snapshots.isEmpty)
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Belum ada portofolio tujuan',
                      style: AppTheme.manrope(
                        size: 14,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Buat portofolio pertama Anda untuk mulai melacak target, setoran, dan estimasi tercapai.',
                      style: AppTheme.manrope(
                        size: 12.5,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => context.push('/portfolios/new'),
                      child: const Text('Buat Porto Pertama'),
                    ),
                  ],
                ),
              )
            else ...[
              // 3. Kartu Checklist Setoran Bulan Ini
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _isCurrentMonth
                                ? 'Setoran Bulan Ini'
                                : 'Setoran ${AppFormatters.monthYear(_selectedMonth)}',
                            style: AppTheme.manrope(
                              size: 13,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Bulan sebelumnya',
                          visualDensity: VisualDensity.compact,
                          onPressed: () => _shiftMonth(-1),
                          icon: const Icon(Icons.chevron_left, size: 18),
                        ),
                        if (!_isCurrentMonth)
                          IconButton(
                            tooltip: 'Bulan berikutnya',
                            visualDensity: VisualDensity.compact,
                            onPressed: () => _shiftMonth(1),
                            icon: const Icon(Icons.chevron_right, size: 18),
                          ),
                        PlanoraPill.gray(
                          '$completedCount dari ${checklist.length}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (checklist.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Belum ada porto dengan rencana setoran bulanan di atas Rp 0.',
                          style: AppTheme.manrope(
                            size: 12,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      )
                    else
                      for (var i = 0; i < checklist.length; i++) ...[
                        if (i > 0) const DashedDivider(),
                        _HomeChecklistRow(
                          row: checklist[i],
                          onTap: _isCurrentMonth
                              ? () => showContributionSheet(
                                    context,
                                    ref: ref,
                                    portfolioId: checklist[i].portfolio.id,
                                    portfolioName: checklist[i].portfolio.name,
                                    suggestedAmount: (checklist[i].monthlyPlan -
                                            checklist[i].deposited)
                                        .clamp(0, checklist[i].monthlyPlan),
                                  )
                              : null,
                        ),
                      ],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 4. Kartu Sisa Kebutuhan Terbesar
              if (topTwo.isNotEmpty)
                PlanoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sisa Kebutuhan Terbesar',
                            style: AppTheme.manrope(
                              size: 13,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          InkWell(
                            onTap: () => context.go('/portfolios'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              child: Text(
                                'Lihat Porto',
                                style: AppTheme.manrope(
                                  size: 12.5,
                                  weight: FontWeight.w800,
                                  color: cs.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      for (var i = 0; i < topTwo.length; i++) ...[
                        if (i > 0) const SizedBox(height: 12),
                        InkWell(
                          onTap: () => context
                              .push('/portfolios/${topTwo[i].portfolio.id}'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  PortfolioDot(
                                    color: Color(topTwo[i].portfolio.color),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      topTwo[i].portfolio.name,
                                      style: AppTheme.manrope(
                                        size: 13,
                                        weight: FontWeight.w800,
                                        color: cs.onSurface,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'sisa ${AppFormatters.rupiah(topTwo[i].remaining)}',
                                    style: AppTheme.manrope(
                                      size: 12,
                                      color: cs.onSurfaceVariant,
                                      tabular: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              PlanoraProgressBar(
                                value: topTwo[i].progressPct / 100.0,
                                color: Color(topTwo[i].portfolio.color),
                                height: 7,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InstrumentSubtotalBox extends StatelessWidget {
  const _InstrumentSubtotalBox({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTheme.uppercaseLabel(
              color: PlanoraColors.balanceLabel,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTheme.manrope(
              size: 13,
              weight: FontWeight.w800,
              color: PlanoraColors.balanceText,
              tabular: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeChecklistRow extends StatelessWidget {
  const _HomeChecklistRow({
    required this.row,
    this.onTap,
  });

  final ChecklistRow row;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final p = row.portfolio;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: row.isCompleted
                    ? PlanoraColors.greenBright
                    : Colors.transparent,
                border: row.isCompleted
                    ? null
                    : Border.all(
                        color: row.isPartial
                            ? PlanoraColors.gold
                            : PlanoraColors.checkBorder,
                        width: 2,
                      ),
              ),
              child: row.isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : (row.isPartial
                      ? const Icon(
                          Icons.more_horiz,
                          size: 14,
                          color: PlanoraColors.gold,
                        )
                      : null),
            ),
            const SizedBox(width: 10),
            PortfolioDot(color: Color(p.color)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                p.name,
                style: AppTheme.manrope(
                  size: 13,
                  weight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
            ),
            Text(
              AppFormatters.rupiah(row.monthlyPlan),
              style: AppTheme.manrope(
                size: 13,
                weight: FontWeight.w800,
                color: row.isCompleted ? cs.onSurface : cs.onSurfaceVariant,
                tabular: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
