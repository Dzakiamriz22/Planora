import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/portfolios/contribution_sheet.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/portfolio_icon_badge.dart';

class ContributionsHistoryScreen extends ConsumerStatefulWidget {
  const ContributionsHistoryScreen({super.key});

  @override
  ConsumerState<ContributionsHistoryScreen> createState() =>
      _ContributionsHistoryScreenState();
}

class _ContributionsHistoryScreenState
    extends ConsumerState<ContributionsHistoryScreen> {
  String? _selectedPortfolioId;

  Future<void> _confirmDelete(Contribution contribution) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Catatan Setoran?'),
        content: Text(
          'Setoran sebesar ${AppFormatters.rupiah(contribution.amount)} akan dihapus dan saldo porto terkait akan dihitung ulang.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(portfolioRepositoryProvider)
          .deleteContribution(contribution.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final portfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
    final contributionsAsync = ref.watch(contributionsStreamProvider);
    final portfolioById = {for (final p in portfolios) p.id: p};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Setoran'),
      ),
      body: contributionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal memuat riwayat: $e')),
        data: (allContributions) {
          final filtered = _selectedPortfolioId == null
              ? allContributions
              : allContributions
                  .where((c) => c.portfolioId == _selectedPortfolioId)
                  .toList();

          final grouped = <String, List<Contribution>>{};
          for (final c in filtered) {
            final dt = AppFormatters.parseIsoDate(c.date);
            final key = dt != null
                ? '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}'
                : '0000-00';
            grouped.putIfAbsent(key, () => []).add(c);
          }
          final sortedKeys = grouped.keys.toList()
            ..sort((a, b) => b.compareTo(a));

          return Column(
            children: [
              SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('Semua Porto'),
                        selected: _selectedPortfolioId == null,
                        onSelected: (_) =>
                            setState(() => _selectedPortfolioId = null),
                      ),
                    ),
                    ...portfolios.map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(p.name),
                          selected: _selectedPortfolioId == p.id,
                          onSelected: (_) => setState(
                            () => _selectedPortfolioId =
                                _selectedPortfolioId == p.id ? null : p.id,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.receipt_long_outlined,
                                size: 52,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _selectedPortfolioId == null
                                    ? 'Belum ada catatan setoran'
                                    : 'Belum ada setoran untuk porto ini',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _selectedPortfolioId == null
                                    ? 'Catat setoran pertama Anda dari Beranda atau Detail Porto.'
                                    : 'Pilih "Semua Porto" untuk melihat riwayat porto lain, atau catat setoran baru di Detail Porto.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                        itemCount: sortedKeys.length,
                        itemBuilder: (context, idx) {
                          final key = sortedKeys[idx];
                          final items = grouped[key]!;
                          final monthTotal =
                              items.fold<int>(0, (s, c) => s + c.amount);
                          final firstDate =
                              AppFormatters.parseIsoDate(items.first.date);
                          final monthLabel = firstDate != null
                              ? AppFormatters.monthYear(firstDate)
                              : 'Tanggal tidak diketahui';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        monthLabel,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        AppFormatters.rupiah(monthTotal),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  child: Column(
                                    children: [
                                      for (var i = 0; i < items.length; i++) ...[
                                        if (i > 0) const Divider(height: 1),
                                        _HistoryRowTile(
                                          contribution: items[i],
                                          portfolio: portfolioById[
                                              items[i].portfolioId],
                                          onEdit: () {
                                            final porto = portfolioById[
                                                items[i].portfolioId];
                                            if (porto == null) return;
                                            showContributionSheet(
                                              context,
                                              ref: ref,
                                              portfolioId: porto.id,
                                              portfolioName: porto.name,
                                              existing: items[i],
                                            );
                                          },
                                          onDelete: () =>
                                              _confirmDelete(items[i]),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HistoryRowTile extends StatelessWidget {
  const _HistoryRowTile({
    required this.contribution,
    required this.portfolio,
    required this.onEdit,
    required this.onDelete,
  });

  final Contribution contribution;
  final Portfolio? portfolio;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final dt = AppFormatters.parseIsoDate(contribution.date);
    final isStockLinked = contribution.stockTransactionId != null ||
        contribution.source != StockLotCalc.sourceManual;
    final isWithdrawal = contribution.amount < 0;
    final subtitleParts = [
      if (portfolio != null) portfolio!.name,
      if (isStockLinked) 'Transaksi saham',
      if (dt != null) AppFormatters.shortDate(dt),
      if (contribution.note != null && contribution.note!.isNotEmpty)
        contribution.note!,
    ];

    return ListTile(
      leading: portfolio != null
          ? PortfolioIconBadge(
              iconKey: portfolio!.icon,
              colorValue: portfolio!.color,
              size: 40,
            )
          : const Icon(Icons.savings_outlined),
      title: Text(
        isWithdrawal
            ? '− ${AppFormatters.rupiah(contribution.amount.abs())}'
            : AppFormatters.rupiah(contribution.amount),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: isWithdrawal ? AppTheme.danger : null,
        ),
      ),
      subtitle: Text(subtitleParts.join(' • ')),
      trailing: isStockLinked
          ? IconButton(
              tooltip: 'Ubah melalui transaksi saham di Detail Porto',
              icon: const Icon(Icons.lock_outline_rounded, size: 18),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ubah atau hapus catatan ini melalui komponen Saham langsung di Detail Porto.',
                    ),
                  ),
                );
              },
            )
          : PopupMenuButton<String>(
              tooltip: 'Opsi setoran',
              onSelected: (action) {
                if (action == 'edit') onEdit();
                if (action == 'delete') onDelete();
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Hapus')),
              ],
            ),
    );
  }
}

