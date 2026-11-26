import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/plan_percent_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/notifications/reminder_service.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_charts.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class PlanFormScreen extends ConsumerStatefulWidget {
  const PlanFormScreen({super.key, this.planId});

  final String? planId;

  @override
  ConsumerState<PlanFormScreen> createState() => _PlanFormScreenState();
}

class _PlanFormScreenState extends ConsumerState<PlanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _totalCtrl = TextEditingController();

  final Map<String, int> _shareX100 = {};
  final Map<String, int> _exactAmounts = {};
  final Map<String, TextEditingController> _inputCtrls = {};
  final Map<String, FocusNode> _focusNodes = {};

  String _inputMode = 'percent'; // 'percent' | 'nominal'
  bool _useExactAmounts = false;
  bool _initialized = false;
  bool _saving = false;
  bool _isEditingActivePlan = false;
  String? _validationError;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _totalCtrl.dispose();
    for (final c in _inputCtrls.values) {
      c.dispose();
    }
    for (final f in _focusNodes.values) {
      f.dispose();
    }
    super.dispose();
  }

  void _init(
    List<Portfolio> portfolios,
    List<PlanWithAllocations> allPlans,
    FinancialSummary summary,
  ) {
    if (_initialized) return;

    final existing = widget.planId == null
        ? null
        : allPlans.where((p) => p.plan.id == widget.planId).firstOrNull;
    if (widget.planId != null && existing == null) return;

    _initialized = true;

    if (existing != null) {
      _nameCtrl.text = existing.plan.name;
      _descCtrl.text = existing.plan.description ?? '';
      _totalCtrl.text = existing.plan.totalAmount > 0
          ? AppFormatters.number(existing.plan.totalAmount)
          : '';
      _isEditingActivePlan = existing.plan.isActive;
      for (final porto in portfolios) {
        _shareX100[porto.id] =
            existing.sharePercentX100ByPortfolioId[porto.id] ?? 0;
        _exactAmounts[porto.id] =
            existing.derivedAmountsByPortfolioId[porto.id] ?? 0;
      }
      if (existing.hasExactFixedAmounts) {
        _useExactAmounts = true;
        _inputMode = 'nominal';
      }
    } else {
      final defaultTotal = summary.ceiling ?? 0;
      _totalCtrl.text =
          defaultTotal > 0 ? AppFormatters.number(defaultTotal) : '';
      for (final porto in portfolios) {
        _shareX100[porto.id] = 0;
        _exactAmounts[porto.id] = 0;
      }
    }

    _syncControllers(portfolios, forceSync: true);
  }

  int get _currentTotal => parseRupiahInput(_totalCtrl.text);

  Map<String, int> _currentDerivedAmounts(List<Portfolio> portfolios) {
    if (_useExactAmounts) {
      return {
        for (final p in portfolios) p.id: _exactAmounts[p.id] ?? 0,
      };
    }
    return PlanPercentCalc.computeAmountsFromPercents(
      totalAmount: _currentTotal,
      sharePercentX100ById: _shareX100,
    );
  }

  String _formatRowInput(String portfolioId, Map<String, int> derived) {
    if (_inputMode == 'nominal') {
      final nom = _useExactAmounts
          ? (_exactAmounts[portfolioId] ?? 0)
          : (derived[portfolioId] ?? 0);
      return nom > 0 ? AppFormatters.number(nom) : '';
    }
    final x100 = _shareX100[portfolioId] ?? 0;
    if (x100 <= 0) return '';
    if (x100 % 100 == 0) return '${x100 ~/ 100}';
    return (x100 / 100.0).toStringAsFixed(2);
  }

  void _ensureRowControllers(List<Portfolio> portfolios) {
    final derived = _currentDerivedAmounts(portfolios);
    for (final p in portfolios) {
      _shareX100.putIfAbsent(p.id, () => 0);
      _exactAmounts.putIfAbsent(p.id, () => 0);
      _focusNodes.putIfAbsent(p.id, FocusNode.new);
      _inputCtrls.putIfAbsent(
        p.id,
        () => TextEditingController(text: _formatRowInput(p.id, derived)),
      );
    }
  }

  void _syncControllers(
    List<Portfolio> portfolios, {
    String? skipPortfolioId,
    bool forceSync = false,
  }) {
    final derived = _currentDerivedAmounts(portfolios);
    for (final p in portfolios) {
      final ctrl = _inputCtrls.putIfAbsent(
        p.id,
        () => TextEditingController(text: _formatRowInput(p.id, derived)),
      );
      final focus = _focusNodes.putIfAbsent(p.id, FocusNode.new);
      if (p.id != skipPortfolioId && (forceSync || !focus.hasFocus)) {
        final desired = _formatRowInput(p.id, derived);
        if (ctrl.text != desired) {
          ctrl.value = TextEditingValue(
            text: desired,
            selection: TextSelection.collapsed(offset: desired.length),
          );
        }
      }
    }
  }

  void _applyPercentMap(List<Portfolio> portfolios, Map<String, int> next) {
    setState(() {
      _useExactAmounts = false;
      for (final p in portfolios) {
        _shareX100[p.id] = next[p.id] ?? 0;
      }
      _syncControllers(portfolios, forceSync: true);
    });
  }

  Future<void> _confirmAutoBalance(List<Portfolio> portfolios) async {
    final balanced = PlanPercentCalc.autoBalanceTo100(_shareX100);
    final changes = <String>[];
    for (final p in portfolios) {
      final before = _shareX100[p.id] ?? 0;
      final after = balanced[p.id] ?? 0;
      if (before != after) {
        changes.add(
          '• ${p.name}: ${PlanPercentCalc.formatX100(before)} → ${PlanPercentCalc.formatX100(after)}',
        );
      }
    }
    if (changes.isEmpty) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pas-kan ke 100%?'),
        content: Text(
          'Perubahan berikut akan dipakai agar total tepat 100%:\n\n${changes.join('\n')}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Pas-kan'),
          ),
        ],
      ),
    );
    if (ok == true) {
      _applyPercentMap(portfolios, balanced);
    }
  }

  Future<void> _submit({required bool saveAsNew}) async {
    if (!_formKey.currentState!.validate()) return;
    final portfolios = ref.read(portfoliosStreamProvider).value ?? const [];

    setState(() {
      _validationError = null;
      _saving = true;
    });

    try {
      final shareSnapshot = {
        for (final p in portfolios) p.id: _shareX100[p.id] ?? 0,
      };
      final exactSnapshot = _useExactAmounts
          ? {for (final p in portfolios) p.id: _exactAmounts[p.id] ?? 0}
          : null;
      final effectiveTotal = _useExactAmounts && exactSnapshot != null
          ? exactSnapshot.values.fold<int>(0, (a, b) => a + b)
          : _currentTotal;
      final isDraft = !PlanPercentCalc.isExact100(shareSnapshot.values);

      final savedId = await ref.read(planRepositoryProvider).savePlan(
            id: saveAsNew ? null : widget.planId,
            name: _nameCtrl.text.trim(),
            description: _descCtrl.text.trim(),
            totalAmount: effectiveTotal,
            sharePercentX100ByPortfolioId: shareSnapshot,
            fixedAmountsByPortfolioId: exactSnapshot,
          );

      final allPlansNow =
          await ref.read(planRepositoryProvider).watchPlans().first;
      final savedNow =
          allPlansNow.where((e) => e.id == savedId).firstOrNull;
      final isNowActive = savedNow?.isActive ?? false;

      if (isNowActive || (_isEditingActivePlan && !saveAsNew)) {
        final setting =
            await ref.read(settingsRepositoryProvider).getSettings();
        await ref.read(reminderServiceProvider).syncSchedules(
              setting: setting,
              activePlanName: isNowActive ? _nameCtrl.text.trim() : null,
              activePlanTotal: isNowActive ? effectiveTotal : 0,
            );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isDraft
                  ? 'Plan "${_nameCtrl.text.trim()}" disimpan sebagai draf (belum 100%).'
                  : isNowActive
                      ? 'Plan "${_nameCtrl.text.trim()}" aktif — setoran bulanan tiap portofolio otomatis diperbarui.'
                      : (saveAsNew
                          ? 'Disimpan sebagai Plan baru "${_nameCtrl.text.trim()}".'
                          : 'Perubahan Plan berhasil disimpan.'),
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _validationError = e.toString());
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _duplicate() async {
    if (widget.planId == null) return;
    final newId =
        await ref.read(planRepositoryProvider).duplicatePlan(widget.planId!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan berhasil diduplikat.')),
      );
      context.pushReplacement('/plans/$newId/edit');
    }
  }

  Future<void> _deactivate() async {
    if (widget.planId == null || !_isEditingActivePlan) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nonaktifkan Plan?'),
        content: Text(
          'Plan "${_nameCtrl.text.trim()}" tidak akan aktif lagi. Anda bisa mengaktifkannya kembali kapan saja.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Nonaktifkan'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await ref.read(planRepositoryProvider).deactivatePlan(widget.planId!);
    final setting = await ref.read(settingsRepositoryProvider).getSettings();
    await ref.read(reminderServiceProvider).syncSchedules(
          setting: setting,
          activePlanName: null,
          activePlanTotal: 0,
        );
    if (mounted) {
      setState(() => _isEditingActivePlan = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan berhasil dinonaktifkan.')),
      );
    }
  }

  Future<void> _delete() async {
    if (widget.planId == null || _isEditingActivePlan) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Plan?'),
        content: Text(
          'Plan "${_nameCtrl.text.trim()}" beserta pembagian persennya akan dihapus permanen.',
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
    if (confirmed != true || !mounted) return;
    await ref.read(planRepositoryProvider).deletePlan(widget.planId!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final portfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
    final allPlans = ref.watch(plansWithAllocationsProvider);
    final summary = ref.watch(financialSummaryProvider);
    _init(portfolios, allPlans, summary);
    _ensureRowControllers(portfolios);

    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEdit = widget.planId != null;

    final totalPlan = _currentTotal;
    final totalX100 = PlanPercentCalc.totalX100(_shareX100.values);
    final isPas = totalX100 == PlanPercentCalc.exact100X100;
    final isOver100 = totalX100 > PlanPercentCalc.exact100X100;
    final derived = _currentDerivedAmounts(portfolios);

    final ceiling = summary.ceiling;
    final overCeiling = ceiling != null && totalPlan > ceiling;

    final activePlan = allPlans.where((p) => p.plan.isActive).firstOrNull;
    final portfolioIds = portfolios.map((p) => p.id).toList();

    final donutSlices = portfolios
        .map(
          (p) => DonutSliceData(
            label: p.name,
            percent: PlanPercentCalc.x100ToPercent(_shareX100[p.id] ?? 0),
            amount: derived[p.id] ?? 0,
            color: Color(p.color),
          ),
        )
        .toList();

    final statusColor = isPas
        ? (isDark ? PlanoraChartTokens.chartMoney : PlanoraColors.primary)
        : (isOver100 ? PlanoraColors.danger : PlanoraColors.gold);
    final statusBg = isPas
        ? (isDark
            ? PlanoraColors.primary.withValues(alpha: 0.25)
            : PlanoraColors.greenSoft)
        : (isOver100
            ? (isDark
                ? PlanoraColors.danger.withValues(alpha: 0.25)
                : PlanoraColors.dangerSoft)
            : (isDark
                ? PlanoraColors.gold.withValues(alpha: 0.22)
                : PlanoraColors.noteYellowBg));

    final statusText = isPas
        ? 'Total 100% — pas dan siap dipakai'
        : isOver100
            ? 'Sudah ${PlanPercentCalc.formatX100(totalX100)} — kelebihan ${PlanPercentCalc.formatX100(totalX100 - PlanPercentCalc.exact100X100)} (draf)'
            : 'Baru ${PlanPercentCalc.formatX100(totalX100)} — kurang ${PlanPercentCalc.formatX100(PlanPercentCalc.exact100X100 - totalX100)} (draf)';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 6),
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
                      isEdit ? 'Edit Plan' : 'Buat Plan Baru',
                      style: AppTheme.sora(
                        size: 17,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  if (_isEditingActivePlan) PlanoraPill.yellow('Plan Aktif'),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                  children: [
                    Text(
                      'NAMA PLAN',
                      style: AppTheme.uppercaseLabel(),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      key: const Key('plan_name_field'),
                      controller: _nameCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Contoh: Fokus DP Rumah, Bulan Hemat',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Nama Plan wajib diisi.'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'CATATAN (OPSIONAL)',
                      style: AppTheme.uppercaseLabel(),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _descCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Keterangan singkat tujuan Plan ini',
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          'TOTAL DANA / BULAN',
                          style: AppTheme.uppercaseLabel(),
                        ),
                        if (ceiling != null && ceiling > 0)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _totalCtrl.text = AppFormatters.number(ceiling);
                                _syncControllers(portfolios, forceSync: true);
                              });
                            },
                            style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            child: Text(
                              'Gunakan batas (${AppFormatters.rupiah(ceiling)})',
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    RupiahTextField(
                      key: const Key('plan_total_field'),
                      controller: _totalCtrl,
                      label: 'Total dana yang dibagi per bulan',
                      onChanged: (_) => setState(() {
                        _useExactAmounts = false;
                        _syncControllers(portfolios);
                      }),
                    ),
                    if (overCeiling) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Total Plan melebihi batas tabungan (${AppFormatters.rupiah(ceiling)}/bln). Sesuaikan totalnya atau ubah profil gaji di Pengaturan.',
                        style: AppTheme.manrope(
                          size: 12,
                          weight: FontWeight.w700,
                          color: PlanoraColors.danger,
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    if (portfolios.isNotEmpty) ...[
                      Text(
                        'PILIH CEPAT',
                        style: AppTheme.uppercaseLabel(),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          ActionChip(
                            label: const Text('Seimbang'),
                            onPressed: () => _applyPercentMap(
                              portfolios,
                              PlanPercentCalc.presetBalanced(portfolioIds),
                            ),
                          ),
                          ActionChip(
                            label: const Text('Fokus Utama'),
                            onPressed: () => _applyPercentMap(
                              portfolios,
                              PlanPercentCalc.presetFocusPrimary(portfolioIds),
                            ),
                          ),
                          if (portfolios.length >= 3)
                            ActionChip(
                              label: const Text('Dua Besar'),
                              onPressed: () => _applyPercentMap(
                                portfolios,
                                PlanPercentCalc.presetTwoMajor(portfolioIds),
                              ),
                            ),
                          if (activePlan != null &&
                              activePlan.plan.id != widget.planId)
                            ActionChip(
                              label: const Text('Salin Plan Aktif'),
                              onPressed: () => _applyPercentMap(
                                portfolios,
                                activePlan.sharePercentX100ByPortfolioId,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? PlanoraColors.darkCard
                              : PlanoraColors.segmentBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            _ModeChip(
                              label: '% Persen',
                              selected: _inputMode == 'percent',
                              onTap: () => setState(() {
                                _inputMode = 'percent';
                                _syncControllers(portfolios, forceSync: true);
                              }),
                            ),
                            _ModeChip(
                              label: 'Rp Nominal',
                              selected: _inputMode == 'nominal',
                              onTap: () => setState(() {
                                if (!_useExactAmounts) {
                                  final curDerived =
                                      _currentDerivedAmounts(portfolios);
                                  for (final p in portfolios) {
                                    _exactAmounts[p.id] = curDerived[p.id] ?? 0;
                                  }
                                }
                                _inputMode = 'nominal';
                                _syncControllers(portfolios, forceSync: true);
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      PlanoraAllocationDonutChart(
                        slices: donutSlices,
                        centerLabel: 'Plan',
                        centerValue: PlanPercentCalc.formatX100(totalX100),
                        mini: true,
                        emptyMessage: 'Atur porsi tiap portofolio hingga total 100%',
                      ),
                      const SizedBox(height: 12),
                      for (final porto in portfolios)
                        _PlanPercentRow(
                          portfolio: porto,
                          x100: _shareX100[porto.id] ?? 0,
                          derivedNominal: derived[porto.id] ?? 0,
                          inputMode: _inputMode,
                          controller: _inputCtrls[porto.id]!,
                          focusNode: _focusNodes[porto.id]!,
                          onSliderChanged: (v) {
                            setState(() {
                              _useExactAmounts = false;
                              _shareX100[porto.id] =
                                  PlanPercentCalc.percentToX100(v);
                              _syncControllers(portfolios, forceSync: true);
                            });
                          },
                          onTextChanged: (val) {
                            setState(() {
                              if (_inputMode == 'nominal') {
                                final nom = parseRupiahInput(val);
                                _useExactAmounts = true;
                                _exactAmounts[porto.id] = nom;
                                final amountsMap = {
                                  for (final p in portfolios)
                                    p.id: _exactAmounts[p.id] ?? 0,
                                };
                                final converted = PlanPercentCalc
                                    .migrateNominalAmountsToPlanPercents(
                                  amountsMap,
                                );
                                _totalCtrl.text = converted.totalAmount > 0
                                    ? AppFormatters.number(converted.totalAmount)
                                    : '';
                                for (final p in portfolios) {
                                  _shareX100[p.id] = converted
                                          .sharePercentX100ById[p.id] ??
                                      0;
                                }
                              } else {
                                _useExactAmounts = false;
                                final parsed = double.tryParse(
                                      val.replaceAll(',', '.'),
                                    ) ??
                                    0.0;
                                _shareX100[porto.id] =
                                    PlanPercentCalc.percentToX100(parsed);
                              }
                            });
                          },
                        ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: statusColor.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPas
                                  ? Icons.check_circle_outline
                                  : Icons.info_outline_rounded,
                              size: 18,
                              color: statusColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                statusText,
                                style: AppTheme.manrope(
                                  size: 12.5,
                                  weight: FontWeight.w700,
                                  color: statusColor,
                                  tabular: true,
                                ),
                              ),
                            ),
                            if (!isPas) ...[
                              const SizedBox(width: 6),
                              TextButton(
                                key: const Key('plan_autobalance_button'),
                                onPressed: () =>
                                    _confirmAutoBalance(portfolios),
                                style: TextButton.styleFrom(
                                  foregroundColor: statusColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                ),
                                child: const Text('Pas-kan ke 100%'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ] else
                      PlanoraCard(
                        child: Text(
                          'Belum ada porto. Buat porto dulu untuk mengatur pembagian Plan.',
                          style: AppTheme.manrope(
                            size: 12.5,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    if (_validationError != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _validationError!,
                        style: AppTheme.manrope(
                          size: 12,
                          weight: FontWeight.w700,
                          color: PlanoraColors.danger,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? PlanoraColors.darkBorder
                        : PlanoraColors.cardBorder,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    key: const Key('plan_save_button'),
                    onPressed: _saving ? null : () => _submit(saveAsNew: false),
                    child: Text(
                      isEdit
                          ? (isPas ? 'Simpan Perubahan' : 'Simpan sebagai Draf')
                          : (isPas ? 'Simpan Plan' : 'Simpan sebagai Draf'),
                    ),
                  ),
                  if (isEdit) ...[
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed:
                          _saving ? null : () => _submit(saveAsNew: true),
                      child: const Text('Simpan sebagai Plan Baru'),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: cs.onSurface,
                          ),
                          onPressed: _saving ? null : _duplicate,
                          child: const Text('Duplikat'),
                        ),
                        if (_isEditingActivePlan)
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: cs.onSurfaceVariant,
                            ),
                            onPressed: _saving ? null : _deactivate,
                            child: const Text('Nonaktifkan'),
                          ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: _isEditingActivePlan
                                ? cs.onSurfaceVariant
                                : PlanoraColors.danger,
                          ),
                          onPressed: _saving
                              ? null
                              : (_isEditingActivePlan
                                  ? () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Nonaktifkan Plan ini dulu sebelum menghapusnya.',
                                          ),
                                        ),
                                      );
                                    }
                                  : _delete),
                          child: const Text('Hapus Plan'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanPercentRow extends StatelessWidget {
  const _PlanPercentRow({
    required this.portfolio,
    required this.x100,
    required this.derivedNominal,
    required this.inputMode,
    required this.controller,
    required this.focusNode,
    required this.onSliderChanged,
    required this.onTextChanged,
  });

  final Portfolio portfolio;
  final int x100;
  final int derivedNominal;
  final String inputMode;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<double> onSliderChanged;
  final ValueChanged<String> onTextChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = Color(portfolio.color);
    final isNominal = inputMode == 'nominal';
    final pct = PlanPercentCalc.x100ToPercent(x100);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 10, 6),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PortfolioDot(color: color, size: 10),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      portfolio.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      isNominal
                          ? PlanPercentCalc.formatX100(x100)
                          : AppFormatters.rupiah(derivedNominal),
                      style: AppTheme.manrope(
                        size: 12,
                        color: cs.onSurfaceVariant,
                        tabular: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: isNominal ? 124 : 84,
                child: TextField(
                  key: Key('plan_row_input_${portfolio.id}'),
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: !isNominal,
                  ),
                  inputFormatters: isNominal
                      ? [RupiahInputFormatter()]
                      : [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9.,]'),
                          ),
                        ],
                  textAlign: TextAlign.right,
                  style: AppTheme.manrope(
                    size: 13,
                    weight: FontWeight.w700,
                    color: cs.onSurface,
                    tabular: true,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: '0',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    prefixText: isNominal ? 'Rp ' : null,
                    suffixText: isNominal ? null : '%',
                  ),
                  onChanged: onTextChanged,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              thumbColor: color,
              overlayColor: color.withValues(alpha: 0.16),
              inactiveTrackColor: cs.surfaceContainerHighest,
              trackHeight: 4,
            ),
            child: Slider(
              value: pct.clamp(0.0, 100.0),
              min: 0,
              max: 100,
              divisions: 200,
              onChanged: onSliderChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          constraints: const BoxConstraints(minHeight: 40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? cs.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            label,
            style: AppTheme.manrope(
              size: 12.5,
              weight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? cs.primary : cs.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
