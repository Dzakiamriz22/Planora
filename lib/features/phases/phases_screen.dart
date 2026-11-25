import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/phase_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';

class PhasesScreen extends ConsumerWidget {
  const PhasesScreen({super.key});

  Future<void> _confirmApplyPhase(
    BuildContext context,
    WidgetRef ref,
    PhaseWithAllocations phaseData,
    FinancialSummary summary,
  ) async {
    final total = phaseData.totalMonthly;
    final sisaGaji = summary.monthlySalary == null
        ? null
        : summary.monthlySalary! - total;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pakai ${phaseData.phase.name}?'),
        content: Text(
          'Menerapkan fase ini akan menimpa rencana setoran bulanan seluruh porto.\n\n'
          '• Total setoran bulanan baru: ${AppFormatters.rupiah(total)}'
          '${sisaGaji != null ? '\n• Sisa gaji untuk biaya hidup: ${AppFormatters.rupiah(sisaGaji)}' : ''}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Terapkan'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;
    try {
      await ref.read(phaseRepositoryProvider).applyPhase(phaseData.phase.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${phaseData.phase.name} berhasil diterapkan.'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menerapkan fase: $e')),
        );
      }
    }
  }

  Future<void> _createBalancedPhase(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final id =
          await ref.read(phaseRepositoryProvider).createBalancedPhase();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fase seimbang berhasil dibuat dari batas nabung Anda.'),
          ),
        );
        context.push('/phases/$id/edit');
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
    final phases = ref.watch(phasesWithAllocationsProvider);
    final portfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
    final summary = ref.watch(financialSummaryProvider);
    final cs = Theme.of(context).colorScheme;

    final activePhase = phases.where((p) => p.phase.isActive).firstOrNull;
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
                  child: Text(
                    'Fase Alokasi',
                    style: AppTheme.sora(
                      size: 21,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                PlanoraAppBarIconButton(
                  icon: Icons.add,
                  tooltip: 'Buat fase baru',
                  filled: true,
                  onPressed: () => context.push('/phases/new'),
                ),
              ],
            ),
            const SizedBox(height: 10),

            if (phases.isEmpty) ...[
              PlanoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Belum ada fase alokasi',
                      style: AppTheme.manrope(
                        size: 15,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Fase adalah templat pembagian setoran bulanan ke seluruh porto agar prioritas dapat bergeser tanpa mengubah porto satu per satu.',
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
                        child: const Text('Buat Porto Dulu'),
                      )
                    else ...[
                      FilledButton(
                        onPressed: canCreateBalanced
                            ? () => _createBalancedPhase(context, ref)
                            : null,
                        child: const Text('Buat Fase Seimbang'),
                      ),
                      if (!canCreateBalanced) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Atur gaji dan biaya hidup di Pengaturan untuk mengaktifkan "Buat Fase Seimbang".',
                          style: AppTheme.manrope(
                            size: 11.5,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => context.push('/phases/new'),
                        child: const Text('+ Buat Fase Baru'),
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
                            'Fase aktif: ${activePhase?.phase.name ?? "Belum ada"}.\n',
                        style: AppTheme.manrope(
                          size: 12.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      TextSpan(
                        text: summary.ceiling != null
                            ? 'Menerapkan fase mengganti setoran bulanan semua porto sekaligus, tetap dalam batas nabung ${AppFormatters.rupiah(summary.ceiling!)}/bln.'
                            : 'Menerapkan fase mengganti setoran bulanan semua porto sekaligus.',
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
              for (final phaseData in phases) ...[
                _PhaseCard(
                  phaseData: phaseData,
                  portfolios: portfolios,
                  summary: summary,
                  onApply: () =>
                      _confirmApplyPhase(context, ref, phaseData, summary),
                  onEdit: () =>
                      context.push('/phases/${phaseData.phase.id}/edit'),
                ),
                const SizedBox(height: 12),
              ],
              if (canCreateBalanced) ...[
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _createBalancedPhase(context, ref),
                    child: const Text('Buat Fase Seimbang'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.push('/phases/new'),
                  child: const Text('+ Buat Fase Baru'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  const _PhaseCard({
    required this.phaseData,
    required this.portfolios,
    required this.summary,
    required this.onApply,
    required this.onEdit,
  });

  final PhaseWithAllocations phaseData;
  final List<Portfolio> portfolios;
  final FinancialSummary summary;
  final VoidCallback onApply;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final p = phaseData.phase;
    final cs = Theme.of(context).colorScheme;
    final total = phaseData.totalMonthly;
    final overCeiling = summary.ceiling != null && total > summary.ceiling!;

    final segments = portfolios
        .map(
          (porto) => AllocationBarSegment(
            amount: phaseData.allocations[porto.id] ?? 0,
            color: Color(porto.color),
          ),
        )
        .toList();

    final topAllocations = portfolios
        .where((porto) => (phaseData.allocations[porto.id] ?? 0) > 0)
        .toList()
      ..sort(
        (a, b) => (phaseData.allocations[b.id] ?? 0)
            .compareTo(phaseData.allocations[a.id] ?? 0),
      );
    final topFour = topAllocations.take(4).toList();

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
                    size: 13.5,
                    weight: FontWeight.w800,
                    color: cs.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (p.isActive) PlanoraPill.yellow('Aktif'),
            ],
          ),
          if (p.description != null && p.description!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              p.description!,
              style: AppTheme.manrope(
                size: 12,
                color: cs.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 10),
          StackedAllocationBar(segments: segments, height: 12),
          if (p.isActive && topFour.isNotEmpty) ...[
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
                        style: AppTheme.manrope(
                          size: 12.5,
                          color: cs.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      AppFormatters.rupiah(
                        phaseData.allocations[porto.id] ?? 0,
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
              ),
            const SizedBox(height: 6),
            const Divider(),
          ],
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total ${AppFormatters.rupiah(total)}/bln',
                style: AppTheme.manrope(
                  size: 12,
                  color: overCeiling ? PlanoraColors.danger : cs.onSurfaceVariant,
                  tabular: true,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: p.isActive ? onEdit : (overCeiling ? null : onApply),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(
                    p.isActive
                        ? 'Edit Fase'
                        : (overCeiling ? 'Melebihi batas' : 'Terapkan'),
                    style: AppTheme.manrope(
                      size: 13,
                      weight: FontWeight.w800,
                      color: overCeiling && !p.isActive
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
