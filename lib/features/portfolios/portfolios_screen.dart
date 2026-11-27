import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/constants/portfolio_palette.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_charts.dart';
import 'package:planora/widgets/planora_widgets.dart';

class PortfoliosScreen extends ConsumerStatefulWidget {
  const PortfoliosScreen({super.key});

  @override
  ConsumerState<PortfoliosScreen> createState() => _PortfoliosScreenState();
}

class _PortfoliosScreenState extends ConsumerState<PortfoliosScreen> {
  bool _reordering = false;

  Future<void> _onReorder(
    List<PortfolioSnapshot> snapshots,
    int oldIndex,
    int newIndex,
  ) async {
    final ids = snapshots.map((s) => s.portfolio.id).toList();
    final moved = ids.removeAt(oldIndex);
    ids.insert(newIndex, moved);
    await ref.read(portfolioRepositoryProvider).reorderPortfolios(ids);
  }

  @override
  Widget build(BuildContext context) {
    final portfoliosAsync = ref.watch(portfoliosStreamProvider);
    ref.watch(hideAmountsProvider);
    final snapshots = ref.watch(portfolioSnapshotsProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: portfoliosAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Gagal memuat daftar porto: $err',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 12, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Portofolio',
                          style: AppTheme.sora(
                            size: 21,
                            weight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      PlanoraPill.gray('${snapshots.length} porto'),
                      const SizedBox(width: 4),
                      if (snapshots.length > 1)
                        PlanoraAppBarIconButton(
                          icon: _reordering ? Icons.check : Icons.swap_vert,
                          tooltip: _reordering
                              ? 'Selesai urutkan'
                              : 'Atur urutan porto',
                          onPressed: () =>
                              setState(() => _reordering = !_reordering),
                        ),
                      PlanoraAppBarIconButton(
                        icon: Icons.add,
                        tooltip: 'Tambah porto baru',
                        filled: true,
                        onPressed: () => context.push('/portfolios/new'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: snapshots.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 52,
                                  color: cs.onSurfaceVariant,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Belum ada portofolio',
                                  style: AppTheme.manrope(
                                    size: 16,
                                    weight: FontWeight.w800,
                                    color: cs.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Tambahkan portofolio tujuan keuangan Anda untuk mulai mencatat setoran dan komponen instrumen.',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.manrope(
                                    size: 12.5,
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                FilledButton(
                                  onPressed: () =>
                                      context.push('/portfolios/new'),
                                  child: const Text('Tambah Porto'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : _reordering
                          ? Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Text(
                                    'Tahan dan seret kartu untuk mengubah urutan tampil di Porto, Beranda, Plan, dan Setoran Bulan Ini.',
                                    style: AppTheme.manrope(
                                      size: 12,
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ReorderableListView.builder(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      4,
                                      16,
                                      28,
                                    ),
                                    itemCount: snapshots.length,
                                    onReorderItem: (oldIndex, newIndex) =>
                                        _onReorder(
                                      snapshots,
                                      oldIndex,
                                      newIndex,
                                    ),
                                    itemBuilder: (context, index) {
                                      final snap = snapshots[index];
                                      final p = snap.portfolio;
                                      return Padding(
                                        key: ValueKey(p.id),
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: PlanoraCard(
                                          child: Row(
                                            children: [
                                              PortfolioDot(
                                                color: Color(p.color),
                                              ),
                                              const SizedBox(width: 10),
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
                                              const Icon(Icons.drag_handle),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 4, 16, 28),
                              itemCount: snapshots.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                return _PortfolioCard(
                                  snapshot: snapshots[index],
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.snapshot});

  final PortfolioSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final p = snapshot.portfolio;
    final cs = Theme.of(context).colorScheme;
    final color = Color(p.color);
    final isNoTarget = p.category == 'no_target' || !snapshot.hasTarget;
    final isDpMode = p.category == 'down_payment';
    final platformLabel =
        PortfolioPalette.displayPlatform(p.platformPreset, p.platformName);

    String rightFooter;
    if (isNoTarget) {
      rightFooter = snapshot.components.isEmpty
          ? 'Berjalan terus'
          : '${snapshot.components.length} komponen';
    } else if (snapshot.estimatedDate?.isAchieved ?? false) {
      rightFooter = 'Target tercapai';
    } else if (snapshot.estimatedDate?.estimatedDate != null) {
      rightFooter =
          'Est. tercapai ${AppFormatters.shortMonthYear(snapshot.estimatedDate!.estimatedDate!)}';
    } else if (snapshot.targetDate != null) {
      rightFooter =
          'Target ${AppFormatters.shortMonthYear(snapshot.targetDate!)}';
    } else {
      rightFooter = 'Fleksibel';
    }

    final statusPill = switch (snapshot.projectionV22.status) {
      PortfolioTrackStatusV22.achieved => PlanoraPill.green('Tercapai'),
      PortfolioTrackStatusV22.notStarted => PlanoraPill.gray('Belum Mulai'),
      PortfolioTrackStatusV22.onTrack => PlanoraPill.green('On Track'),
      PortfolioTrackStatusV22.offTrack => PlanoraPill.danger('Off Track'),
    };

    return PlanoraCard(
      onTap: () => context.push('/portfolios/${p.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (!isNoTarget) ...[
                PlanoraProgressRing(
                  progressPercent: snapshot.progressPct,
                  size: 38,
                  strokeWidth: 4,
                  color: color,
                ),
                const SizedBox(width: 10),
              ] else ...[
                PortfolioDot(color: color),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Wrap(
                      spacing: 5,
                      runSpacing: 4,
                      children: [
                        if (p.platformPreset != null ||
                            (p.platformName != null &&
                                p.platformName!.isNotEmpty))
                          PlanoraPill.platform(platformLabel),
                        if (isDpMode)
                          PlanoraPill.gray('DP + Biaya')
                        else if (isNoTarget)
                          PlanoraPill.gray('Tanpa target'),
                        statusPill,
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              PlanoraSparkline(
                values: snapshot.sparkline6m,
                color: color,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                AppFormatters.rupiah(snapshot.balance),
                style: AppTheme.manrope(
                  size: 14.5,
                  weight: FontWeight.w800,
                  color: cs.onSurface,
                  tabular: true,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  isNoTarget
                      ? 'Rutin berjalan'
                      : 'dari ${AppFormatters.rupiah(p.savedTarget!)} · ${AppFormatters.percent(snapshot.progressPct)}',
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.manrope(
                    size: 11.5,
                    color: cs.onSurfaceVariant,
                    tabular: true,
                  ),
                ),
              ),
            ],
          ),
          if (!isNoTarget) ...[
            const SizedBox(height: 8),
            PlanoraProgressBar(
              value: snapshot.progressPct / 100.0,
              color: color,
              height: 7,
            ),
          ],
          const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${AppFormatters.rupiah(p.monthlyPlan)}/bln',
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.manrope(
                    size: 11.5,
                    color: cs.onSurfaceVariant,
                    tabular: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  rightFooter,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.manrope(
                    size: 11.5,
                    color: cs.onSurfaceVariant,
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

