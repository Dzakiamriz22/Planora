import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/plan_percent_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/notifications/reminder_service.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';

class PlansScreen extends ConsumerWidget {
  const PlansScreen({super.key});

  Future<void> _confirmApplyPlan(
    BuildContext context,
    WidgetRef ref,
    PlanWithAllocations planData,
    List<Portfolio> portfolios,
    FinancialSummary summary,
  ) async {
    final total = planData.totalMonthly;
    final sisaGaji = summary.monthlySalary == null
        ? null
        : summary.monthlySalary! - total;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pakai ${planData.plan.name}?'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rencana setoran bulanan tiap porto akan diganti mengikuti pembagian ini:',
              ),
              const SizedBox(height: 12),
              for (final porto in portfolios) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      PortfolioDot(color: Color(porto.color)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          porto.name,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.manrope(
                            size: 12.5,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${PlanPercentCalc.formatX100(planData.sharePercentX100ByPortfolioId[porto.id] ?? 0)} · ${AppFormatters.rupiah(planData.derivedAmountsByPortfolioId[porto.id] ?? 0)}',
                        style: AppTheme.manrope(
                          size: 12,
                          weight: FontWeight.w800,
                          tabular: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Divider(height: 16),
              PlanoraKeyValueRow(
                label: 'Total Plan',
                value: '${AppFormatters.rupiah(total)}/bln',
                verticalPadding: 4,
              ),
              if (sisaGaji != null)
                PlanoraKeyValueRow(
                  label: 'Sisa gaji untuk biaya hidup',
                  value: AppFormatters.rupiah(sisaGaji),
                  verticalPadding: 4,
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Pakai Plan ini'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;
    try {
      await ref.read(planRepositoryProvider).applyPlan(planData.plan.id);
      final setting = await ref.read(settingsRepositoryProvider).getSettings();
      await ref.read(reminderServiceProvider).syncSchedules(
            setting: setting,
            activePlanName: planData.plan.name,
            activePlanTotal: planData.totalMonthly,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${planData.plan.name} sekarang menjadi Plan aktif.'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  Future<void> _createBalancedPlan(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final id = await ref.read(planRepositoryProvider).createBalancedPlan();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Plan Seimbang dibuat dari batas aman setoranmu.'),
          ),
        );
        context.push('/plans/$id/edit');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(plansWithAllocationsProvider);
    final portfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
    final summary = ref.watch(financialSummaryProvider);
    final cs = Theme.of(context).colorScheme;

    final activePlan = plans.where((p) => p.plan.isActive).firstOrNull;
    final canCreateBalanced =
        summary.ceiling != null && summary.ceiling! > 0 && portfolios.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plan',
                        style: AppTheme.sora(
                          size: 21,
                          weight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        'Pembagian setoran bulan ini',
                        style: AppTheme.manrope(
                          size: 12.5,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                PlanoraAppBarIconButton(
                  icon: Icons.add,
                  tooltip: 'Buat Plan baru',
                  filled: true,
                  onPressed: () => context.push('/plans/new'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (plans.isEmpty) ...[
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Belum ada Plan',
                      style: AppTheme.manrope(
                        size: 15,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Plan membagi total uang tabungan bulananmu ke tiap porto memakai persen. Kalau gaji berubah, cukup ganti totalnya tanpa atur ulang satu per satu.',
                      style: AppTheme.manrope(
                        size: 12.5,
                        color: cs.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (portfolios.isEmpty)
                      FilledButton(
                        onPressed: () => context.push('/portfolios/new'),
                        child: const Text('Buat Porto Pertama'),
                      )
                    else ...[
                      FilledButton(
                        onPressed: canCreateBalanced
                            ? () => _createBalancedPlan(context, ref)
                            : null,
                        child: const Text('Buat Plan Seimbang'),
                      ),
                      if (!canCreateBalanced) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Atur gaji dan biaya hidup di Pengaturan agar bisa membuat Plan Seimbang otomatis.',
                          style: AppTheme.manrope(
                            size: 12,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => context.push('/plans/new'),
                        child: const Text('+ Buat Plan Baru'),
                      ),
                    ],
                  ],
                ),
              ),
            ] else ...[
              PlanoraNoteBox(
                child: RichText(
                  text: TextSpan(
                    style: AppTheme.manrope(
                      size: 12.5,
                      color: cs.onSurface,
                      height: 1.45,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Plan aktif: ${activePlan?.plan.name ?? "Belum ada"}.\n',
                        style: AppTheme.manrope(
                          size: 12.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      TextSpan(
                        text: summary.ceiling != null
                            ? 'Batas aman setoranmu (plafon) saat ini ${AppFormatters.rupiah(summary.ceiling!)}/bln.'
                            : 'Atur gaji dan biaya hidup di Pengaturan untuk melihat batas aman setoran bulanan.',
                        style: AppTheme.manrope(
                          size: 12.5,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              for (final planData in plans) ...[
                _PlanCard(
                  planData: planData,
                  portfolios: portfolios,
                  summary: summary,
                  onApply: () => _confirmApplyPlan(
                    context,
                    ref,
                    planData,
                    portfolios,
                    summary,
                  ),
                  onEdit: () => context.push('/plans/${planData.plan.id}/edit'),
                ),
                const SizedBox(height: 12),
              ],
              if (canCreateBalanced) ...[
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _createBalancedPlan(context, ref),
                    child: const Text('Buat Plan Seimbang'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.push('/plans/new'),
                  child: const Text('+ Buat Plan Baru'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.planData,
    required this.portfolios,
    required this.summary,
    required this.onApply,
    required this.onEdit,
  });

  final PlanWithAllocations planData;
  final List<Portfolio> portfolios;
  final FinancialSummary summary;
  final VoidCallback onApply;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final p = planData.plan;
    final cs = Theme.of(context).colorScheme;
    final total = planData.totalMonthly;
    final overCeiling = summary.ceiling != null && total > summary.ceiling!;
    final isDraft = planData.isDraft;
    final sisaGaji = summary.monthlySalary == null
        ? null
        : summary.monthlySalary! - total;

    final segments = portfolios
        .map(
          (porto) => AllocationBarSegment(
            amount: planData.sharePercentX100ByPortfolioId[porto.id] ?? 0,
            color: Color(porto.color),
          ),
        )
        .toList();

    final nonZeroPortos = portfolios
        .where(
          (porto) => (planData.sharePercentX100ByPortfolioId[porto.id] ?? 0) > 0,
        )
        .toList()
      ..sort(
        (a, b) => (planData.sharePercentX100ByPortfolioId[b.id] ?? 0)
            .compareTo(planData.sharePercentX100ByPortfolioId[a.id] ?? 0),
      );
    final topFour = nonZeroPortos.take(4).toList();

    final draftChipLabel = planData.totalX100 < PlanPercentCalc.exact100X100
        ? 'Draf — baru ${PlanPercentCalc.formatX100(planData.totalX100)}'
        : 'Draf — kelebihan ${PlanPercentCalc.formatX100(planData.totalX100)}';

    final canApply = !p.isActive && !isDraft && !overCeiling;

    return PlanoraCard(
      borderColor: p.isActive ? PlanoraColors.gold : null,
      borderWidth: p.isActive ? 1.5 : 1,
      showGoldRing: p.isActive,
      onTap: onEdit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  p.name,
                  style: AppTheme.manrope(
                    size: 14,
                    weight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (p.isActive)
                PlanoraPill.yellow('Aktif')
              else if (isDraft)
                PlanoraPill.danger(draftChipLabel),
            ],
          ),
          if (p.description != null && p.description!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              p.description!,
              style: AppTheme.manrope(
                size: 12.5,
                color: cs.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 10),
          StackedAllocationBar(segments: segments, height: 12),
          if (topFour.isNotEmpty) ...[
            const SizedBox(height: 10),
            for (final porto in topFour)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    PortfolioDot(color: Color(porto.color)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        porto.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.manrope(
                          size: 12.5,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      '${PlanPercentCalc.formatX100(planData.sharePercentX100ByPortfolioId[porto.id] ?? 0)} · ${AppFormatters.rupiah(planData.derivedAmountsByPortfolioId[porto.id] ?? 0)}',
                      style: AppTheme.manrope(
                        size: 12.5,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                        tabular: true,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 6),
            const Divider(),
          ],
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total ${AppFormatters.rupiah(total)}/bln',
                      style: AppTheme.manrope(
                        size: 12.5,
                        weight: FontWeight.w700,
                        color: overCeiling
                            ? PlanoraColors.danger
                            : cs.onSurface,
                        tabular: true,
                      ),
                    ),
                    if (sisaGaji != null)
                      Text(
                        'Sisa gaji ${AppFormatters.rupiah(sisaGaji)}',
                        style: AppTheme.manrope(
                          size: 12,
                          color: cs.onSurfaceVariant,
                          tabular: true,
                        ),
                      ),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: p.isActive ? onEdit : (canApply ? onApply : onEdit),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  child: Text(
                    p.isActive
                        ? 'Edit Plan'
                        : (isDraft
                            ? 'Lengkapi 100%'
                            : (overCeiling
                                ? 'Lewat batas aman'
                                : 'Pakai Plan ini')),
                    style: AppTheme.manrope(
                      size: 13,
                      weight: FontWeight.w800,
                      color: (overCeiling || isDraft) && !p.isActive
                          ? PlanoraColors.danger
                          : cs.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
