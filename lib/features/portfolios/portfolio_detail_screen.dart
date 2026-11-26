import 'package:drift/drift.dart' as drift;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/constants/portfolio_palette.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/stock_repository.dart';
import 'package:planora/features/portfolios/contribution_sheet.dart';
import 'package:planora/features/portfolios/stock_transaction_sheets.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_charts.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rebalance_dialog.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class PortfolioDetailScreen extends ConsumerStatefulWidget {
  const PortfolioDetailScreen({super.key, required this.portfolioId});

  final String portfolioId;

  @override
  ConsumerState<PortfolioDetailScreen> createState() =>
      _PortfolioDetailScreenState();
}

class _PortfolioDetailScreenState extends ConsumerState<PortfolioDetailScreen> {
  int _tenorMonths = 240;
  double _illustrativeRatePct = 6.75;
  String _donutMode = 'actual'; // 'actual' | 'target'
  final Set<String> _expandedStockComponentIds = {};

  Future<void> _confirmDeleteStockTransaction(StockTransaction tx) async {
    final sideLabel = tx.side == StockLotCalc.sideBuy ? 'beli' : 'jual';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Transaksi Saham?'),
        content: Text(
          'Transaksi $sideLabel ${tx.ticker} ${tx.lots} lot (${AppFormatters.rupiah(tx.totalAmount)}) akan dihapus. Posisi, harga rata-rata, dan setoran terkait akan dihitung ulang.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: PlanoraColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(stockRepositoryProvider).deleteStockTransaction(tx.id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  Future<void> _showComponentActualSheet(
    PortfolioSnapshot snap,
    PortfolioComponent comp,
  ) async {
    final formKey = GlobalKey<FormState>();
    final amountCtrl = TextEditingController(
      text: comp.actualAmount > 0 ? AppFormatters.number(comp.actualAmount) : '',
    );
    final targetDerived = PlanoraV22Calc.targetAmountFromPercent(
      targetPercent: comp.targetPercent,
      portfolioTargetTotal: snap.portfolio.savedTarget ?? 0,
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) {
        final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    comp.instrumentType,
                    style: AppTheme.sora(size: 17, weight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Target alokasi: ${PlanoraV22Calc.formatPercent(comp.targetPercent)}'
                    '${targetDerived > 0 ? ' (${AppFormatters.rupiah(targetDerived)})' : ''}',
                    style: AppTheme.manrope(
                      size: 12.5,
                      color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                      tabular: true,
                    ),
                  ),
                  const SizedBox(height: 14),
                  RupiahTextField(
                    controller: amountCtrl,
                    label: 'Saldo aktual komponen',
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () async {
                      await ref
                          .read(portfolioRepositoryProvider)
                          .updateComponentActualAmount(
                            componentId: comp.id,
                            actualAmount: parseRupiahInput(amountCtrl.text),
                          );
                      if (ctx.mounted) Navigator.of(ctx).pop();
                    },
                    child: const Text('Simpan Saldo Aktual'),
                  ),
                  const SizedBox(height: 6),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.push('/portfolios/${snap.portfolio.id}/edit');
                    },
                    child: const Text('Ubah Persentase Target di Form Porto'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    amountCtrl.dispose();
  }

  Future<void> _confirmDeleteContribution(Contribution contribution) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Catatan Setoran?'),
        content: Text(
          'Setoran sebesar ${AppFormatters.rupiah(contribution.amount)} akan dihapus dan saldo porto akan dihitung ulang.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: PlanoraColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    try {
      await ref
          .read(portfolioRepositoryProvider)
          .deleteContribution(contribution.id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  Future<void> _showPriceReferenceSheet(PortfolioSnapshot snap) async {
    final refs = ref.read(priceReferencesStreamProvider).value ?? const [];
    if (refs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Belum ada referensi harga. Tambahkan dulu di halaman Pengaturan.',
          ),
        ),
      );
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ambil dari Catatan Harga',
              style: AppTheme.sora(size: 17, weight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Saldo dan komponen tidak berubah saat menerapkan referensi harga.',
              style: AppTheme.manrope(
                size: 12.5,
                color: PlanoraColors.inkMuted,
              ),
            ),
            const SizedBox(height: 12),
            ...refs.map((r) {
              final target = r.downPayment + r.fees;
              final creditLeft =
                  (r.fullPrice - r.downPayment).clamp(0, r.fullPrice);
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  r.name,
                  style: AppTheme.manrope(size: 13.5, weight: FontWeight.w800),
                ),
                subtitle: Text(
                  'Penuh ${AppFormatters.rupiah(r.fullPrice)} • DP + biaya ${AppFormatters.rupiah(target)} • Sisa kredit ${AppFormatters.rupiah(creditLeft)}',
                  style: AppTheme.manrope(size: 11.5, tabular: true),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await _previewAndApplyReference(snap, r);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _previewAndApplyReference(
    PortfolioSnapshot snap,
    PriceReference r,
  ) async {
    final p = snap.portfolio;
    final newTarget = r.downPayment + r.fees;
    final now = DateTime.now();
    final newReq = PlanoraCalc.requiredMonthlyDeposit(
      savedTarget: newTarget,
      balance: snap.balance,
      targetDate: snap.targetDate,
      annualReturnPct: p.annualReturnPct,
      now: now,
    );
    final willChangeCategory = p.category != 'down_payment';

    final approved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pakai "${r.name}"?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlanoraKeyValueRow(
              label: 'Harga penuh baru',
              value: AppFormatters.rupiah(r.fullPrice),
              verticalPadding: 4,
            ),
            PlanoraKeyValueRow(
              label: 'Target ditabung baru',
              value: AppFormatters.rupiah(newTarget),
              verticalPadding: 4,
            ),
            PlanoraKeyValueRow(
              label: 'Saldo & komponen',
              value: 'Tetap (${AppFormatters.rupiah(snap.balance)})',
              verticalPadding: 4,
            ),
            if (snap.targetDate != null)
              PlanoraKeyValueRow(
                label: 'Perlu per bulan baru',
                value: '${AppFormatters.rupiah(newReq.amount)}/bln',
                verticalPadding: 4,
              ),
            if (willChangeCategory) ...[
              const SizedBox(height: 8),
              Text(
                'Kategori porto ini akan diubah menjadi "DP + biaya".',
                style: AppTheme.manrope(
                  size: 12,
                  weight: FontWeight.w700,
                  color: PlanoraColors.gold,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Pakai'),
          ),
        ],
      ),
    );

    if (approved != true || !mounted) return;

    await ref.read(portfolioRepositoryProvider).updatePortfolio(
          id: p.id,
          changes: PortfoliosCompanion(
            category: const drift.Value('down_payment'),
            fullPrice: drift.Value(r.fullPrice),
            downPayment: drift.Value(r.downPayment),
            fees: drift.Value(r.fees),
            savedTarget: drift.Value(newTarget),
          ),
        );
  }

  Future<void> _showInstallmentConfigDialog() async {
    final tenorCtrl = TextEditingController(text: '$_tenorMonths');
    final rateCtrl = TextEditingController(text: '$_illustrativeRatePct');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Atur Ilustrasi Cicilan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: tenorCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tenor (bulan)',
                helperText: 'Contoh: 240 untuk 20 tahun',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: rateCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Bunga ilustrasi (%/tahun)',
                helperText: '0% dihitung secara linear',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              final m = int.tryParse(tenorCtrl.text.trim()) ?? _tenorMonths;
              final r = double.tryParse(
                    rateCtrl.text.trim().replaceAll(',', '.'),
                  ) ??
                  _illustrativeRatePct;
              setState(() {
                _tenorMonths = m > 0 ? m : 12;
                _illustrativeRatePct = r >= 0 ? r : 0;
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Pakai'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAdjustSheet(PortfolioSnapshot snap, String mode) async {
    final p = snap.portfolio;
    final targetCtrl = TextEditingController(
      text: p.savedTarget != null ? AppFormatters.number(p.savedTarget!) : '',
    );
    final monthlyCtrl = TextEditingController(
      text: p.monthlyPlan > 0 ? AppFormatters.number(p.monthlyPlan) : '',
    );
    final returnCtrl = TextEditingController(text: p.annualReturnPct.toString());
    var targetDate = snap.targetDate;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          final now = DateTime.now();
          final parsedReturn =
              double.tryParse(returnCtrl.text.replaceAll(',', '.')) ??
                  p.annualReturnPct;
          final parsedTarget = p.category == 'no_target'
              ? null
              : parseRupiahInput(targetCtrl.text);
          final parsedMonthly = parseRupiahInput(monthlyCtrl.text);

          RequiredMonthlyResult? liveReq;
          TargetDateEstimate? liveEst;
          if (parsedTarget != null && parsedTarget > 0) {
            if (mode == 'target_driven') {
              liveReq = PlanoraCalc.requiredMonthlyDeposit(
                savedTarget: parsedTarget,
                balance: snap.balance,
                targetDate: targetDate,
                annualReturnPct: parsedReturn,
                now: now,
              );
            } else {
              liveEst = PlanoraCalc.estimateTargetDate(
                savedTarget: parsedTarget,
                balance: snap.balance,
                monthlyPlan: parsedMonthly,
                annualReturnPct: parsedReturn,
                now: now,
              );
            }
          }

          final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;

          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    mode == 'target_driven'
                        ? 'Setoran Ikut Target'
                        : 'Tanggal Ikut Setoran',
                    style: AppTheme.sora(size: 17, weight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  if (p.category != 'no_target') ...[
                    RupiahTextField(
                      controller: targetCtrl,
                      label: 'Target simpan',
                      onChanged: (_) => setSheetState(() {}),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (mode == 'target_driven' && p.category != 'no_target') ...[
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: ctx,
                          initialDate: targetDate ?? DateTime(2033, 10, 31),
                          firstDate: DateTime(now.year - 2, 1, 1),
                          lastDate: DateTime(2100, 12, 31),
                        );
                        if (picked != null) {
                          setSheetState(() => targetDate = picked);
                        }
                      },
                      icon: const Icon(Icons.calendar_today_outlined, size: 18),
                      label: Text(
                        targetDate == null
                            ? 'Pilih tanggal target'
                            : 'Tanggal target: ${AppFormatters.shortDate(targetDate!)}',
                      ),
                    ),
                    const SizedBox(height: 12),
                  ] else ...[
                    RupiahTextField(
                      controller: monthlyCtrl,
                      label: 'Rencana setoran bulanan',
                      onChanged: (_) => setSheetState(() {}),
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                    controller: returnCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Asumsi return per tahun (%)',
                      suffixText: '%',
                    ),
                    onChanged: (_) => setSheetState(() {}),
                  ),
                  const SizedBox(height: 12),
                  if (liveReq != null && targetDate != null)
                    PlanoraNoteBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Setoran terhitung: ${AppFormatters.rupiah(liveReq.amount)}/bln',
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: PlanoraColors.primary,
                              tabular: true,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Ilustrasi berdasarkan asumsi return $parsedReturn%/tahun, bukan janji hasil investasi.',
                            style: AppTheme.manrope(
                              size: 11,
                              color: PlanoraColors.inkMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (liveEst != null)
                    PlanoraNoteBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            liveEst.isAchieved
                                ? 'Target sudah tercapai'
                                : liveEst.isUnreachable
                                    ? 'Tidak tercapai dengan setoran saat ini'
                                    : 'Estimasi tercapai: ${AppFormatters.shortMonthYear(liveEst.estimatedDate!)}',
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: PlanoraColors.primary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Ilustrasi berdasarkan asumsi return $parsedReturn%/tahun, bukan janji hasil investasi.',
                            style: AppTheme.manrope(
                              size: 11,
                              color: PlanoraColors.inkMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () async {
                      final allPortfolios =
                          ref.read(portfoliosStreamProvider).value ?? const [];
                      final summary = ref.read(financialSummaryProvider);

                      int nextMonthly;
                      DateTime? nextDate = targetDate;

                      if (mode == 'target_driven' &&
                          parsedTarget != null &&
                          parsedTarget > 0 &&
                          targetDate != null) {
                        nextMonthly = PlanoraCalc.requiredMonthlyDeposit(
                          savedTarget: parsedTarget,
                          balance: snap.balance,
                          targetDate: targetDate,
                          annualReturnPct: parsedReturn,
                          now: now,
                        ).amount;
                      } else {
                        nextMonthly = parsedMonthly;
                        if (parsedTarget != null && parsedTarget > 0) {
                          final est = PlanoraCalc.estimateTargetDate(
                            savedTarget: parsedTarget,
                            balance: snap.balance,
                            monthlyPlan: nextMonthly,
                            annualReturnPct: parsedReturn,
                            now: now,
                          );
                          if (est.estimatedDate != null) {
                            nextDate = est.estimatedDate;
                          }
                        }
                      }

                      final rebalance = PlanoraCalc.rebalanceProportionally(
                        items: allPortfolios
                            .map(
                              (item) => RebalanceItem(
                                id: item.id,
                                name: item.name,
                                currentAmount: item.monthlyPlan,
                              ),
                            )
                            .toList(),
                        editedId: p.id,
                        newEditedAmount: nextMonthly,
                        ceilingAmount: summary.ceiling,
                      );

                      Map<String, int>? rebalancedPlans;
                      if (rebalance.needsRebalance && summary.ceiling != null) {
                        final approved = await showRebalancePreviewDialog(
                          ctx,
                          result: rebalance,
                          ceilingAmount: summary.ceiling!,
                        );
                        if (!approved) return;
                        rebalancedPlans = {
                          for (final ch in rebalance.changes)
                            if (ch.id != p.id) ch.id: ch.newAmount,
                        };
                      }

                      await ref
                          .read(portfolioRepositoryProvider)
                          .updatePortfolio(
                            id: p.id,
                            changes: PortfoliosCompanion(
                              calcMode: drift.Value(mode),
                              savedTarget: drift.Value(parsedTarget),
                              targetDate: drift.Value(
                                nextDate != null
                                    ? AppFormatters.toIsoDate(nextDate)
                                    : null,
                              ),
                              monthlyPlan: drift.Value(nextMonthly),
                              annualReturnPct: drift.Value(parsedReturn),
                            ),
                            rebalancedPlans: rebalancedPlans,
                          );

                      if (ctx.mounted) Navigator.of(ctx).pop();
                    },
                    child: const Text('Simpan Rencana'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final snapshots = ref.watch(portfolioSnapshotsProvider);
    final snap = snapshots
        .where((s) => s.portfolio.id == widget.portfolioId)
        .firstOrNull;
    final contributionsAsync =
        ref.watch(portfolioContributionsProvider(widget.portfolioId));
    final cs = Theme.of(context).colorScheme;

    if (snap == null) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Porto tidak ditemukan.'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final p = snap.portfolio;
    final color = Color(p.color);
    final isDpCategory = p.category == 'down_payment' && p.fullPrice != null;
    final platformLabel =
        PortfolioPalette.displayPlatform(p.platformPreset, p.platformName);

    final loanPrincipal = isDpCategory
        ? ((p.fullPrice ?? 0) - (p.downPayment ?? p.savedTarget ?? 0))
            .clamp(0, p.fullPrice ?? 0)
        : 0;
    final monthlyInstallment = PlanoraCalc.annuityInstallment(
      principal: loanPrincipal,
      tenorMonths: _tenorMonths,
      annualInterestPct: _illustrativeRatePct,
    );

    final returnLabel = p.annualReturnPct == p.annualReturnPct.roundToDouble()
        ? '${p.annualReturnPct.round()}%'
        : '${p.annualReturnPct.toStringAsFixed(1).replaceAll('.', ',')}%';

    String estText;
    if (snap.estimatedDate?.isAchieved ?? false) {
      estText = 'Tercapai';
    } else if (snap.estimatedDate?.estimatedDate != null) {
      estText = AppFormatters.shortMonthYear(snap.estimatedDate!.estimatedDate!);
    } else if (snap.targetDate != null) {
      estText = AppFormatters.shortMonthYear(snap.targetDate!);
    } else {
      estText = 'Fleksibel';
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
              child: Row(
                children: [
                  PlanoraAppBarIconButton(
                    icon: Icons.chevron_left_rounded,
                    tooltip: 'Kembali',
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Detail Porto',
                      style: AppTheme.sora(
                        size: 17,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  PlanoraAppBarIconButton(
                    icon: Icons.edit_outlined,
                    tooltip: 'Edit porto',
                    onPressed: () => context.push('/portfolios/${p.id}/edit'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          PortfolioPalette.iconFor(p.icon),
                          color: color,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: AppTheme.sora(
                                size: 16.5,
                                weight: FontWeight.w800,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: [
                                if (p.platformPreset != null ||
                                    (p.platformName != null &&
                                        p.platformName!.isNotEmpty))
                                  PlanoraPill.platform(platformLabel),
                                if (isDpCategory)
                                  PlanoraPill.gray('Mode DP + Biaya')
                                else if (p.category == 'no_target')
                                  PlanoraPill.gray('Tanpa Target'),
                                switch (snap.projectionV22.status) {
                                  PortfolioTrackStatusV22.achieved =>
                                    PlanoraPill.green('Tercapai'),
                                  PortfolioTrackStatusV22.notStarted =>
                                    PlanoraPill.gray('Belum Mulai'),
                                  PortfolioTrackStatusV22.onTrack =>
                                    PlanoraPill.green('On Track'),
                                  PortfolioTrackStatusV22.offTrack =>
                                    PlanoraPill.danger('Off Track'),
                                },
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('TERKUMPUL', style: AppTheme.uppercaseLabel()),
                          const SizedBox(height: 2),
                          Text(
                            AppFormatters.rupiah(snap.balance),
                            style: AppTheme.manrope(
                              size: 15,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                              tabular: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  if (snap.hasTarget) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            isDpCategory
                                ? 'Target simpan (DP + biaya)'
                                : 'Target simpan',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.manrope(
                              size: 12,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${AppFormatters.rupiah(p.savedTarget!)} · ${AppFormatters.percent(snap.progressPct)}',
                          style: AppTheme.manrope(
                            size: 12,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                            tabular: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    PlanoraProgressBar(
                      value: snap.progressPct / 100.0,
                      color: color,
                      height: 9,
                    ),
                  ],

                  const SizedBox(height: 14),

                  PlanoraCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    child: Column(
                      children: [
                        if (p.fullPrice != null) ...[
                          PlanoraKeyValueRow(
                            label: 'Harga penuh',
                            value: AppFormatters.rupiah(p.fullPrice!),
                          ),
                          const Divider(),
                        ],
                        if (snap.hasTarget) ...[
                          PlanoraKeyValueRow(
                            label: 'Sisa kebutuhan',
                            value: AppFormatters.rupiah(snap.remaining),
                          ),
                          const Divider(),
                        ],
                        PlanoraKeyValueRow(
                          label: 'Setoran saat ini',
                          value: '${AppFormatters.rupiah(p.monthlyPlan)}/bln',
                        ),
                        if (snap.hasTarget) ...[
                          const Divider(),
                          PlanoraKeyValueRow(
                            label: 'Estimasi tercapai (return $returnLabel)',
                            value: estText,
                            valueColor: cs.primary,
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (snap.components.isNotEmpty) ...[
                    Builder(
                      builder: (context) {
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;
                        final summary = ref.watch(financialSummaryProvider);
                        final isTargetView = _donutMode == 'target';
                        final totalActualComp = snap.totalComponentsActual;
                        final donutSlices = snap.components.map((c) {
                          final pct = isTargetView
                              ? c.targetPercent
                              : PlanoraV22Calc.actualPercent(
                                  actualAmount: c.actualAmount,
                                  totalActualPortfolio: totalActualComp,
                                );
                          final amt = isTargetView
                              ? PlanoraV22Calc.targetAmountFromPercent(
                                  targetPercent: c.targetPercent,
                                  portfolioTargetTotal: p.savedTarget ?? 0,
                                )
                              : c.actualAmount;
                          return DonutSliceData(
                            label: c.instrumentType,
                            percent: pct,
                            amount: amt,
                            color: PlanoraChartTokens.colorForInstrument(
                              c.instrumentType,
                              isDark: isDark,
                            ),
                          );
                        }).toList();

                        return Column(
                          children: [
                            PlanoraCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Alokasi Instrumen',
                                          style: AppTheme.manrope(
                                            size: 13.5,
                                            weight: FontWeight.w800,
                                            color: cs.onSurface,
                                          ),
                                        ),
                                      ),
                                      SegmentedButton<String>(
                                        segments: const [
                                          ButtonSegment(
                                            value: 'actual',
                                            label: Text('Aktual'),
                                          ),
                                          ButtonSegment(
                                            value: 'target',
                                            label: Text('Target'),
                                          ),
                                        ],
                                        selected: {_donutMode},
                                        onSelectionChanged: (s) {
                                          if (s.isNotEmpty) {
                                            setState(() => _donutMode = s.first);
                                          }
                                        },
                                        showSelectedIcon: false,
                                        style: ButtonStyle(
                                          visualDensity: VisualDensity.compact,
                                          textStyle: WidgetStatePropertyAll(
                                            AppTheme.manrope(
                                              size: 11.5,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  PlanoraAllocationDonutChart(
                                    slices: donutSlices,
                                    centerLabel:
                                        isTargetView ? 'Target' : 'Aktual',
                                    centerValue: PlanoraChartTokens.compactRupiah(
                                      isTargetView
                                          ? (p.savedTarget ?? 0)
                                          : totalActualComp,
                                    ),
                                    emptyMessage: isTargetView
                                        ? 'Belum ada target komponen'
                                        : 'Belum ada setoran teralokasi — catat setoran pertama',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            PlanoraCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Alokasi vs Target',
                                        style: AppTheme.manrope(
                                          size: 13.5,
                                          weight: FontWeight.w800,
                                          color: cs.onSurface,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => context
                                            .push('/portfolios/${p.id}/edit'),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Atur %',
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
                                  const SizedBox(height: 8),
                                  for (var i = 0;
                                      i < snap.components.length;
                                      i++) ...[
                                    if (i > 0) const Divider(),
                                    if (snap.components[i].mechanism ==
                                        StockLotCalc.mechanismLotBased) ...[
                                      _StockComponentTile(
                                        component: snap.components[i],
                                        portfolioTargetTotal:
                                            p.savedTarget ?? 0,
                                        totalActualPortfolio: totalActualComp,
                                        highlightNominal:
                                            summary.componentInputMode ==
                                                'nominal',
                                        expanded: _expandedStockComponentIds
                                            .contains(snap.components[i].id),
                                        onToggleExpand: () {
                                          setState(() {
                                            final cid = snap.components[i].id;
                                            if (_expandedStockComponentIds
                                                .contains(cid)) {
                                              _expandedStockComponentIds
                                                  .remove(cid);
                                            } else {
                                              _expandedStockComponentIds
                                                  .add(cid);
                                            }
                                          });
                                        },
                                        onBuyTap: () => showBuyStockSheet(
                                          context,
                                          ref: ref,
                                          componentId: snap.components[i].id,
                                        ),
                                        onSellTap: (pos) => showSellStockSheet(
                                          context,
                                          ref: ref,
                                          componentId: snap.components[i].id,
                                          position: pos,
                                        ),
                                        onConvertLegacyTap: () =>
                                            showBuyStockSheet(
                                          context,
                                          ref: ref,
                                          componentId: snap.components[i].id,
                                          legacyOpeningLimit: snap
                                              .components[i]
                                              .legacyOpeningAmount,
                                        ),
                                        onEditTx: (tx) => showBuyStockSheet(
                                          context,
                                          ref: ref,
                                          componentId: snap.components[i].id,
                                          existing: tx,
                                        ),
                                        onDeleteTx:
                                            _confirmDeleteStockTransaction,
                                      ),
                                    ] else
                                      PlanoraAllocationComparisonRow(
                                        instrument:
                                            snap.components[i].instrumentType,
                                        actualAmount:
                                            snap.components[i].actualAmount,
                                        targetAmount: PlanoraV22Calc
                                            .targetAmountFromPercent(
                                          targetPercent:
                                              snap.components[i].targetPercent,
                                          portfolioTargetTotal:
                                              p.savedTarget ?? 0,
                                        ),
                                        actualPercent:
                                            PlanoraV22Calc.actualPercent(
                                          actualAmount:
                                              snap.components[i].actualAmount,
                                          totalActualPortfolio: totalActualComp,
                                        ),
                                        targetPercent:
                                            snap.components[i].targetPercent,
                                        highlightNominal:
                                            summary.componentInputMode ==
                                                'nominal',
                                        onTap: () => _showComponentActualSheet(
                                          snap,
                                          snap.components[i],
                                        ),
                                      ),
                                  ],
                                  if (snap.unallocatedBalance > 0) ...[
                                    const Divider(),
                                    PlanoraKeyValueRow(
                                      label: 'Saldo belum dialokasikan ke komponen',
                                      value: AppFormatters.rupiah(
                                        snap.unallocatedBalance,
                                      ),
                                      valueColor: cs.onSurfaceVariant,
                                      verticalPadding: 4,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ] else
                    PlanoraCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Belum ada komponen instrumen. Atur persentase instrumen melalui Edit Porto.',
                              style: AppTheme.manrope(
                                size: 12,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () =>
                                context.push('/portfolios/${p.id}/edit'),
                            child: const Text('Atur'),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 12),

                  PlanoraCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riwayat Saldo Porto (6 Bulan)',
                          style: AppTheme.manrope(
                            size: 13.5,
                            weight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        PlanoraBalanceAreaChart(
                          points: snap.balanceSeries6m,
                          lineColor: color,
                          height: 156,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (snap.hasTarget) ...[
                    PlanoraCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Proyeksi Capaian (Laju 3 Bulan Terakhir)',
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          PlanoraKeyValueRow(
                            label: 'Rata-rata setoran 3 bln',
                            value:
                                '${AppFormatters.rupiah(snap.projectionV22.averageRate3m)}/bln',
                            verticalPadding: 6,
                          ),
                          const Divider(),
                          PlanoraKeyValueRow(
                            label: 'Perkiraan tercapai',
                            value: snap.projectionV22.projectedDate != null
                                ? AppFormatters.shortMonthYear(
                                    snap.projectionV22.projectedDate!,
                                  )
                                : '—',
                            valueColor: cs.primary,
                            verticalPadding: 6,
                          ),
                          if (snap.projectionV22.requiredMonthly != null &&
                              snap.projectionV22.requiredMonthly! > 0) ...[
                            const Divider(),
                            PlanoraKeyValueRow(
                              label: 'Butuh per bulan sesuai tanggal target',
                              value:
                                  '${AppFormatters.rupiah(snap.projectionV22.requiredMonthly!)}/bln',
                              verticalPadding: 6,
                            ),
                          ],
                          if (snap.projectionV22.rateEmptyMessage != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              snap.projectionV22.rateEmptyMessage!,
                              style: AppTheme.manrope(
                                size: 11.5,
                                color: PlanoraColors.gold,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  if (p.category != 'no_target') ...[
                    PlanoraCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Atur Target',
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _TargetModeRadioCard(
                            selected: p.calcMode == 'target_driven',
                            title: 'Setoran ikut target',
                            subtitle: 'Tanggal tetap, setoran dihitung ulang',
                            onTap: () => _showAdjustSheet(snap, 'target_driven'),
                          ),
                          const SizedBox(height: 8),
                          _TargetModeRadioCard(
                            selected: p.calcMode != 'target_driven',
                            title: 'Tanggal ikut setoran',
                            subtitle: 'Setoran tetap, estimasi tanggal bergeser',
                            onTap: () =>
                                _showAdjustSheet(snap, 'deposit_driven'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  if (isDpCategory && loanPrincipal > 0) ...[
                    PlanoraNoteBox(
                      isWarning: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: AppTheme.manrope(
                                size: 12,
                                color: cs.onSurface,
                                height: 1.45,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Ilustrasi cicilan setelah DP terkumpul:\n',
                                  style: AppTheme.manrope(
                                    size: 12,
                                    weight: FontWeight.w800,
                                    color: cs.onSurface,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'pinjaman ${AppFormatters.rupiah(loanPrincipal)} · $_tenorMonths bulan · bunga ilustrasi ${_illustrativeRatePct.toString().replaceAll('.', ',')}% → sekitar ',
                                  style: AppTheme.manrope(
                                    size: 12,
                                    color: PlanoraColors.inkSecondary,
                                    tabular: true,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${AppFormatters.rupiah(monthlyInstallment)}/bln.\n',
                                  style: AppTheme.manrope(
                                    size: 12,
                                    weight: FontWeight.w800,
                                    color: cs.onSurface,
                                    tabular: true,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Ilustrasi berdasarkan asumsi tenor & bunga Anda, bukan penawaran kredit dan tidak mengurangi batas nabung.',
                                  style: AppTheme.manrope(
                                    size: 11.5,
                                    color: PlanoraColors.inkMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 14,
                            children: [
                              InkWell(
                                onTap: _showInstallmentConfigDialog,
                                child: Text(
                                  'Ubah tenor/bunga',
                                  style: AppTheme.manrope(
                                    size: 12,
                                    weight: FontWeight.w800,
                                    color: PlanoraColors.chipYellowText,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => _showPriceReferenceSheet(snap),
                                child: Text(
                                  'Ambil dari Catatan Harga →',
                                  style: AppTheme.manrope(
                                    size: 12,
                                    weight: FontWeight.w800,
                                    color: PlanoraColors.chipYellowText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ] else ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => _showPriceReferenceSheet(snap),
                        icon: const Icon(Icons.bookmark_outline, size: 18),
                        label: const Text('Ambil dari Catatan Harga'),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],

                  PlanoraCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Setoran Terakhir',
                              style: AppTheme.manrope(
                                size: 13.5,
                                weight: FontWeight.w800,
                                color: cs.onSurface,
                              ),
                            ),
                            InkWell(
                              onTap: () => context.push('/history'),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                child: Text(
                                  'Semua',
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
                        const SizedBox(height: 8),
                        contributionsAsync.when(
                          loading: () => const Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          error: (e, _) => Text('Gagal memuat setoran: $e'),
                          data: (items) {
                            if (items.isEmpty) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Belum ada setoran tercatat. Ketuk "+ Catat Setoran" di bawah.',
                                  style: AppTheme.manrope(
                                    size: 12,
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                              );
                            }
                            final recent = items.take(5).toList();
                            return Column(
                              children: [
                                for (var i = 0; i < recent.length; i++) ...[
                                  if (i > 0) const Divider(),
                                  InkWell(
                                    onTap: () {
                                      final isStockLinked = recent[i]
                                                  .stockTransactionId !=
                                              null ||
                                          recent[i].source !=
                                              StockLotCalc.sourceManual;
                                      if (isStockLinked) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Ubah transaksi saham melalui komponen Saham langsung di atas.',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      showContributionSheet(
                                        context,
                                        ref: ref,
                                        portfolioId: p.id,
                                        portfolioName: p.name,
                                        existing: recent[i],
                                      );
                                    },
                                    onLongPress: () {
                                      final isStockLinked = recent[i]
                                                  .stockTransactionId !=
                                              null ||
                                          recent[i].source !=
                                              StockLotCalc.sourceManual;
                                      if (isStockLinked) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Hapus transaksi saham melalui riwayat komponen Saham langsung di atas.',
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      _confirmDeleteContribution(recent[i]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppFormatters.parseIsoDate(
                                                            recent[i].date,
                                                          ) !=
                                                          null
                                                      ? AppFormatters.shortDate(
                                                          AppFormatters
                                                              .parseIsoDate(
                                                            recent[i].date,
                                                          )!,
                                                        )
                                                      : recent[i].date,
                                                  style: AppTheme.manrope(
                                                    size: 13,
                                                    color: cs.onSurfaceVariant,
                                                  ),
                                                ),
                                                if (recent[i].note != null &&
                                                    recent[i].note!.isNotEmpty)
                                                  Text(
                                                    recent[i].note!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTheme.manrope(
                                                      size: 11,
                                                      color:
                                                          cs.onSurfaceVariant,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            recent[i].amount < 0
                                                ? '− ${AppFormatters.rupiah(recent[i].amount.abs())}'
                                                : '+ ${AppFormatters.rupiah(recent[i].amount)}',
                                            style: AppTheme.manrope(
                                              size: 13,
                                              weight: FontWeight.w800,
                                              color: recent[i].amount < 0
                                                  ? PlanoraColors.danger
                                                  : cs.onSurface,
                                              tabular: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? PlanoraColors.darkBorder
                        : PlanoraColors.cardBorder,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => showContributionSheet(
                    context,
                    ref: ref,
                    portfolioId: p.id,
                    portfolioName: p.name,
                    suggestedAmount: p.monthlyPlan,
                  ),
                  child: const Text('+ Catat Setoran'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockComponentTile extends ConsumerWidget {
  const _StockComponentTile({
    required this.component,
    required this.portfolioTargetTotal,
    required this.totalActualPortfolio,
    required this.highlightNominal,
    required this.expanded,
    required this.onToggleExpand,
    required this.onBuyTap,
    required this.onSellTap,
    required this.onConvertLegacyTap,
    required this.onEditTx,
    required this.onDeleteTx,
  });

  final PortfolioComponent component;
  final int portfolioTargetTotal;
  final int totalActualPortfolio;
  final bool highlightNominal;
  final bool expanded;
  final VoidCallback onToggleExpand;
  final VoidCallback onBuyTap;
  final ValueChanged<StockPosition> onSellTap;
  final VoidCallback onConvertLegacyTap;
  final ValueChanged<StockTransaction> onEditTx;
  final ValueChanged<StockTransaction> onDeleteTx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txs =
        ref.watch(componentStockTransactionsProvider(component.id)).value ??
            const <StockTransaction>[];
    final ledger = ref.watch(componentStockLedgerProvider(component.id));

    final targetAmount = PlanoraV22Calc.targetAmountFromPercent(
      targetPercent: component.targetPercent,
      portfolioTargetTotal: portfolioTargetTotal,
    );
    final actualPercent = PlanoraV22Calc.actualPercent(
      actualAmount: component.actualAmount,
      totalActualPortfolio: totalActualPortfolio,
    );

    final tickerSlices = <DonutSliceData>[
      for (var i = 0; i < ledger.activePositions.length; i++)
        DonutSliceData(
          label: ledger.activePositions[i].ticker,
          percent: StockLotCalc.percentWithinStockComponent(
            tickerModal: ledger.activePositions[i].totalModal,
            stockComponentActual: component.actualAmount,
          ),
          amount: ledger.activePositions[i].totalModal,
          color: PlanoraChartTokens.stockTickerColor(i, isDark: isDark),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlanoraAllocationComparisonRow(
          instrument: component.instrumentType,
          actualAmount: component.actualAmount,
          targetAmount: targetAmount,
          actualPercent: actualPercent,
          targetPercent: component.targetPercent,
          highlightNominal: highlightNominal,
          onTap: onToggleExpand,
        ),
        InkWell(
          key: Key('stock_component_toggle_${component.id}'),
          onTap: onToggleExpand,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: PlanoraChartTokens.chartStock
                        .withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Mekanisme Lot',
                    style: AppTheme.manrope(
                      size: 10.5,
                      weight: FontWeight.w800,
                      color: PlanoraChartTokens.chartStock,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ledger.activePositions.isEmpty
                        ? (component.legacyOpeningAmount > 0
                            ? 'Ada saldo awal belum dirinci'
                            : '0 lot')
                        : '${ledger.activePositions.length} kode · ${ledger.totalActiveLots} lot',
                    style: AppTheme.manrope(
                      size: 11.5,
                      color: cs.onSurfaceVariant,
                      tabular: true,
                    ),
                  ),
                ),
                Text(
                  expanded ? 'Tutup' : 'Rincian',
                  style: AppTheme.manrope(
                    size: 11.5,
                    weight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: cs.primary,
                ),
              ],
            ),
          ),
        ),
        if (expanded) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (component.legacyOpeningAmount > 0) ...[
                  Container(
                    key: const Key('legacy_opening_row'),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? PlanoraColors.gold.withValues(alpha: 0.14)
                          : PlanoraColors.noteYellowBg,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: PlanoraColors.gold.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Saldo awal (belum dirinci per lot)',
                                style: AppTheme.manrope(
                                  size: 12,
                                  weight: FontWeight.w700,
                                  color: cs.onSurface,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppFormatters.rupiah(
                                component.legacyOpeningAmount,
                              ),
                              style: AppTheme.manrope(
                                size: 12.5,
                                weight: FontWeight.w800,
                                color: cs.onSurface,
                                tabular: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton.icon(
                            key: const Key('convert_legacy_button'),
                            onPressed: onConvertLegacyTap,
                            icon: const Icon(Icons.splitscreen_outlined,
                                size: 16),
                            label: const Text('Rinci menjadi lot'),
                            style: OutlinedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                if (ledger.activePositions.isEmpty &&
                    component.legacyOpeningAmount == 0) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          'Belum ada saham tercatat',
                          style: AppTheme.manrope(
                            size: 13,
                            weight: FontWeight.w700,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FilledButton.icon(
                          key: const Key('buy_stock_empty_button'),
                          onPressed: onBuyTap,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Beli Saham'),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  if (ledger.activePositions.isNotEmpty) ...[
                    Text(
                      'Komposisi per Kode',
                      style: AppTheme.manrope(
                        size: 12,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PlanoraAllocationDonutChart(
                      slices: tickerSlices,
                      centerLabel: 'Saham',
                      centerValue: '${ledger.totalActiveLots} lot',
                      mini: true,
                      emptyMessage: 'Belum ada posisi aktif',
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 6),
                    Text(
                      'Daftar Posisi Aktif',
                      style: AppTheme.manrope(
                        size: 12,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    for (var idx = 0;
                        idx < ledger.activePositions.length;
                        idx++) ...[
                      if (idx > 0) const Divider(),
                      _StockPositionCard(
                        position: ledger.activePositions[idx],
                        pctInStock: StockLotCalc.percentWithinStockComponent(
                          tickerModal: ledger.activePositions[idx].totalModal,
                          stockComponentActual: component.actualAmount,
                        ),
                        pctInPortfolio: StockLotCalc.percentOfPortfolio(
                          tickerModal: ledger.activePositions[idx].totalModal,
                          portfolioTotalActual: totalActualPortfolio,
                        ),
                        accentColor: PlanoraChartTokens.stockTickerColor(
                          idx,
                          isDark: isDark,
                        ),
                        onSell: () => onSellTap(ledger.activePositions[idx]),
                      ),
                    ],
                    const SizedBox(height: 10),
                  ],
                  FilledButton.icon(
                    key: const Key('buy_stock_button'),
                    onPressed: onBuyTap,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Beli Saham'),
                  ),
                ],
                if (txs.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 6),
                  Text(
                    'Riwayat Transaksi',
                    style: AppTheme.manrope(
                      size: 12,
                      weight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  for (var idx = 0; idx < txs.length; idx++) ...[
                    if (idx > 0) const Divider(height: 10),
                    _StockTxRow(
                      tx: txs[idx],
                      onEdit: () => onEditTx(txs[idx]),
                      onDelete: () => onDeleteTx(txs[idx]),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _StockPositionCard extends StatelessWidget {
  const _StockPositionCard({
    required this.position,
    required this.pctInStock,
    required this.pctInPortfolio,
    required this.accentColor,
    required this.onSell,
  });

  final StockPosition position;
  final double pctInStock;
  final double pctInPortfolio;
  final Color accentColor;
  final VoidCallback onSell;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      position.ticker,
                      style: AppTheme.sora(
                        size: 14,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      '${position.totalLots} lot · ${AppFormatters.number(position.totalShares)} lembar',
                      style: AppTheme.manrope(
                        size: 11.5,
                        color: cs.onSurfaceVariant,
                        tabular: true,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                key: Key('sell_stock_button_${position.ticker}'),
                onPressed: onSell,
                style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('Jual'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Rata-rata ${StockLotCalc.formatAveragePrice(position.averagePrice)}/lbr',
                  style: AppTheme.manrope(
                    size: 11.5,
                    color: cs.onSurfaceVariant,
                    tabular: true,
                  ),
                ),
              ),
              Text(
                AppFormatters.rupiah(position.totalModal),
                style: AppTheme.manrope(
                  size: 12.5,
                  weight: FontWeight.w800,
                  color: cs.onSurface,
                  tabular: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            '${PlanoraV22Calc.formatPercent(pctInStock)} dari Saham · ${PlanoraV22Calc.formatPercent(pctInPortfolio)} dari Porto',
            style: AppTheme.manrope(
              size: 11,
              color: cs.onSurfaceVariant,
              tabular: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _StockTxRow extends StatelessWidget {
  const _StockTxRow({
    required this.tx,
    required this.onEdit,
    required this.onDelete,
  });

  final StockTransaction tx;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isBuy = tx.side == StockLotCalc.sideBuy;
    final dt = AppFormatters.parseIsoDate(tx.transactionDate);
    final dateText =
        dt != null ? AppFormatters.shortDate(dt) : tx.transactionDate;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    tx.ticker,
                    style: AppTheme.manrope(
                      size: 12.5,
                      weight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: (isBuy
                              ? PlanoraChartTokens.chartMoney
                              : PlanoraColors.danger)
                          .withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      isBuy ? 'Beli' : 'Jual',
                      style: AppTheme.manrope(
                        size: 10,
                        weight: FontWeight.w800,
                        color: isBuy
                            ? PlanoraChartTokens.chartMoney
                            : PlanoraColors.danger,
                      ),
                    ),
                  ),
                  Text(
                    '${tx.lots} lot @ ${AppFormatters.rupiah(tx.pricePerShare)}',
                    style: AppTheme.manrope(
                      size: 11.5,
                      color: cs.onSurfaceVariant,
                      tabular: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '$dateText · ${AppFormatters.rupiah(tx.totalAmount)}',
                style: AppTheme.manrope(
                  size: 11,
                  color: cs.onSurfaceVariant,
                  tabular: true,
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          tooltip: 'Opsi transaksi saham',
          onSelected: (action) {
            if (action == 'edit') onEdit();
            if (action == 'delete') onDelete();
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Hapus')),
          ],
        ),
      ],
    );
  }
}

class _TargetModeRadioCard extends StatelessWidget {
  const _TargetModeRadioCard({
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? (isDark
                  ? PlanoraColors.primary.withValues(alpha: 0.25)
                  : PlanoraColors.noteGreenBg)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? PlanoraColors.primary
                : (isDark
                    ? PlanoraColors.darkBorder
                    : PlanoraColors.inputBorder),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? PlanoraColors.primary
                      : PlanoraColors.checkBorder,
                  width: selected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.manrope(
                      size: 13,
                      weight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
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
      ),
    );
  }
}
