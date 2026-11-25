import 'package:drift/drift.dart' as drift;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/constants/portfolio_palette.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rebalance_dialog.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class PortfolioFormScreen extends ConsumerStatefulWidget {
  const PortfolioFormScreen({super.key, this.portfolioId});

  final String? portfolioId;

  @override
  ConsumerState<PortfolioFormScreen> createState() =>
      _PortfolioFormScreenState();
}

class _PortfolioFormScreenState extends ConsumerState<PortfolioFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _platformNameCtrl;
  late final TextEditingController _fullPriceCtrl;
  late final TextEditingController _savedTargetCtrl;
  late final TextEditingController _monthlyPlanCtrl;
  late final TextEditingController _returnCtrl;
  late final TextEditingController _noteCtrl;

  String _platformPreset = 'aperd';
  String _category = 'cash';
  DateTime? _targetDate;
  String _iconKey = 'savings';
  int _colorValue = PlanoraColors.sixPortfolioColors.first;
  bool _initialized = false;
  bool _saving = false;
  Portfolio? _editingPortfolio;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _platformNameCtrl = TextEditingController();
    _fullPriceCtrl = TextEditingController();
    _savedTargetCtrl = TextEditingController();
    _monthlyPlanCtrl = TextEditingController(text: '0');
    _returnCtrl = TextEditingController(text: '5');
    _noteCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _platformNameCtrl.dispose();
    _fullPriceCtrl.dispose();
    _savedTargetCtrl.dispose();
    _monthlyPlanCtrl.dispose();
    _returnCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _initFromProviders(
    List<Portfolio> allPortfolios,
    FinancialSummary summary,
  ) {
    if (_initialized) return;
    _initialized = true;

    if (widget.portfolioId != null) {
      final found =
          allPortfolios.where((p) => p.id == widget.portfolioId).firstOrNull;
      if (found != null) {
        _editingPortfolio = found;
        _nameCtrl.text = found.name;
        _platformPreset = found.platformPreset ?? 'other';
        _platformNameCtrl.text = found.platformName ?? '';
        _category = found.category;
        if (found.fullPrice != null) {
          _fullPriceCtrl.text = AppFormatters.number(found.fullPrice!);
        }
        if (found.savedTarget != null) {
          _savedTargetCtrl.text = AppFormatters.number(found.savedTarget!);
        }
        _targetDate = AppFormatters.parseIsoDate(found.targetDate);
        _monthlyPlanCtrl.text = AppFormatters.number(found.monthlyPlan);
        _returnCtrl.text = found.annualReturnPct.toString();
        _noteCtrl.text = found.note ?? '';
        _iconKey = found.icon;
        _colorValue = found.color;
        return;
      }
    }

    _returnCtrl.text = summary.defaultAnnualReturnPct.toString();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? DateTime(now.year + 3, now.month, now.day),
      firstDate: DateTime(now.year - 5, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (picked != null) {
      setState(() => _targetDate = picked);
    }
  }

  Future<void> _confirmDelete() async {
    final p = _editingPortfolio;
    if (p == null) return;
    final repo = ref.read(portfolioRepositoryProvider);
    final counts = await repo.countPortfolioChildren(p.id);
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Porto?'),
        content: Text(
          'Porto "${p.name}" beserta ${counts.contributions} catatan setoran dan ${counts.components} komponen instrumen di dalamnya akan dihapus permanen. Alokasinya di semua fase juga ikut terhapus.',
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

    if (confirmed == true) {
      await repo.deletePortfolio(p.id);
      if (mounted) context.go('/portfolios');
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final allPortfolios = ref.read(portfoliosStreamProvider).value ?? const [];
    final summary = ref.read(financialSummaryProvider);

    final monthlyPlan = parseRupiahInput(_monthlyPlanCtrl.text);
    final annualReturn =
        double.tryParse(_returnCtrl.text.replaceAll(',', '.')) ??
            summary.defaultAnnualReturnPct;

    int? fullPrice;
    int? downPayment;
    int? fees;
    int? savedTarget;

    if (_category == 'cash') {
      savedTarget = parseRupiahInput(_savedTargetCtrl.text);
      final fp = parseRupiahInput(_fullPriceCtrl.text);
      fullPrice = fp > 0 ? fp : savedTarget;
    } else if (_category == 'down_payment') {
      fullPrice = parseRupiahInput(_fullPriceCtrl.text);
      savedTarget = parseRupiahInput(_savedTargetCtrl.text);
      downPayment = savedTarget;
      fees = 0;
    }

    final editedId = _editingPortfolio?.id ?? '__new_portfolio__';
    final rebalanceItems = [
      ...allPortfolios.map(
        (p) => RebalanceItem(
          id: p.id,
          name: p.name,
          currentAmount: p.monthlyPlan,
        ),
      ),
      if (_editingPortfolio == null)
        RebalanceItem(
          id: editedId,
          name: _nameCtrl.text.trim(),
          currentAmount: 0,
        ),
    ];

    final rebalance = PlanoraCalc.rebalanceProportionally(
      items: rebalanceItems,
      editedId: editedId,
      newEditedAmount: monthlyPlan,
      ceilingAmount: summary.ceiling,
    );

    Map<String, int>? rebalancedPlans;
    if (rebalance.needsRebalance && summary.ceiling != null) {
      final approved = await showRebalancePreviewDialog(
        context,
        result: rebalance,
        ceilingAmount: summary.ceiling!,
      );
      if (!approved) return;
      rebalancedPlans = {
        for (final ch in rebalance.changes)
          if (ch.id != editedId) ch.id: ch.newAmount,
      };
    }

    setState(() => _saving = true);
    try {
      final repo = ref.read(portfolioRepositoryProvider);
      final targetDateIso =
          _targetDate != null ? AppFormatters.toIsoDate(_targetDate!) : null;

      if (_editingPortfolio == null) {
        await repo.createPortfolio(
          name: _nameCtrl.text.trim(),
          category: _category,
          platformPreset: _platformPreset,
          platformName: _platformNameCtrl.text.trim(),
          fullPrice: fullPrice,
          downPayment: downPayment,
          fees: fees,
          savedTarget: savedTarget,
          targetDate: targetDateIso,
          monthlyPlan: monthlyPlan,
          annualReturnPct: annualReturn,
          icon: _iconKey,
          color: _colorValue,
          note: _noteCtrl.text.trim(),
          rebalancedPlans: rebalancedPlans,
        );
      } else {
        await repo.updatePortfolio(
          id: _editingPortfolio!.id,
          changes: PortfoliosCompanion(
            name: drift.Value(_nameCtrl.text.trim()),
            category: drift.Value(_category),
            platformPreset: drift.Value(_platformPreset),
            platformName: drift.Value(
              _platformNameCtrl.text.trim().isEmpty
                  ? null
                  : _platformNameCtrl.text.trim(),
            ),
            fullPrice: drift.Value(fullPrice),
            downPayment: drift.Value(downPayment),
            fees: drift.Value(fees),
            savedTarget: drift.Value(savedTarget),
            targetDate: drift.Value(targetDateIso),
            monthlyPlan: drift.Value(monthlyPlan),
            annualReturnPct: drift.Value(annualReturn),
            icon: drift.Value(_iconKey),
            color: drift.Value(_colorValue),
            note: drift.Value(
              _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
            ),
          ),
          rebalancedPlans: rebalancedPlans,
        );
      }

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan porto: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allPortfolios = ref.watch(portfoliosStreamProvider).value ?? const [];
    final summary = ref.watch(financialSummaryProvider);
    _initFromProviders(allPortfolios, summary);

    final isEdit = _editingPortfolio != null;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fullVal = parseRupiahInput(_fullPriceCtrl.text);
    final targetVal = parseRupiahInput(_savedTargetCtrl.text);
    final dpPct = (fullVal > 0 && targetVal > 0)
        ? ((targetVal / fullVal) * 100).round()
        : null;

    final duplicateName = allPortfolios.any(
      (p) =>
          p.id != _editingPortfolio?.id &&
          p.name.trim().toLowerCase() == _nameCtrl.text.trim().toLowerCase() &&
          _nameCtrl.text.trim().isNotEmpty,
    );

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
                      isEdit ? 'Edit Porto' : 'Tambah Porto',
                      style: AppTheme.sora(
                        size: 17,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                  children: [
                    _FieldLabel('NAMA PORTO'),
                    TextFormField(
                      controller: _nameCtrl,
                      onChanged: (_) => setState(() {}),
                      style: AppTheme.manrope(
                        size: 14,
                        weight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Contoh: Dana Darurat',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Nama porto wajib diisi.'
                          : null,
                    ),
                    if (duplicateName) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Catatan: Sudah ada porto lain dengan nama yang sama.',
                        style: AppTheme.manrope(
                          size: 11.5,
                          color: PlanoraColors.gold,
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),

                    // Platform: 2 bagian (FR-07) — preset generik tanpa merek + teks bebas
                    _FieldLabel('JENIS TEMPAT / PLATFORM'),
                    DropdownButtonFormField<String>(
                      initialValue: _platformPreset,
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      items: PortfolioPalette.platformPresets
                          .map(
                            (opt) => DropdownMenuItem(
                              value: opt.code,
                              child: Text(opt.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _platformPreset = v);
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _platformNameCtrl,
                      style: AppTheme.manrope(
                        size: 13.5,
                        weight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nama platform (opsional, teks bebas)',
                        helperText:
                            'Hanya label tempat — tidak terhubung ke akun mana pun.',
                        helperMaxLines: 2,
                      ),
                    ),

                    const SizedBox(height: 14),
                    _FieldLabel('MODE TARGET'),
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
                          _ModeSegmentItem(
                            label: 'Tunai Penuh',
                            selected: _category == 'cash',
                            onTap: () => setState(() => _category = 'cash'),
                          ),
                          _ModeSegmentItem(
                            label: 'DP + Biaya',
                            selected: _category == 'down_payment',
                            onTap: () =>
                                setState(() => _category = 'down_payment'),
                          ),
                          _ModeSegmentItem(
                            label: 'Tanpa Target',
                            selected: _category == 'no_target',
                            onTap: () =>
                                setState(() => _category = 'no_target'),
                          ),
                        ],
                      ),
                    ),

                    if (_category == 'down_payment') ...[
                      const SizedBox(height: 14),
                      _FieldLabel('HARGA PENUH'),
                      RupiahTextField(
                        controller: _fullPriceCtrl,
                        label: '',
                        onChanged: (_) => setState(() {}),
                        validator: (v) => parseRupiahInput(v ?? '') <= 0
                            ? 'Harga penuh wajib diisi untuk mode DP + Biaya.'
                            : null,
                      ),
                    ],

                    if (_category != 'no_target') ...[
                      const SizedBox(height: 14),
                      _FieldLabel(
                        _category == 'down_payment'
                            ? 'TARGET SIMPAN (DP + BIAYA)'
                            : 'TARGET SIMPAN',
                      ),
                      TextFormField(
                        controller: _savedTargetCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [RupiahInputFormatter()],
                        onChanged: (_) => setState(() {}),
                        style: AppTheme.manrope(
                          size: 14,
                          weight: FontWeight.w700,
                          color: cs.onSurface,
                          tabular: true,
                        ),
                        decoration: InputDecoration(
                          prefixText: 'Rp ',
                          suffixIcon: (_category == 'down_payment' &&
                                  dpPct != null)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PlanoraPill.gray('$dpPct% harga'),
                                    ],
                                  ),
                                )
                              : null,
                        ),
                        validator: (v) => parseRupiahInput(v ?? '') <= 0
                            ? 'Target simpan wajib lebih dari Rp 0.'
                            : null,
                      ),
                      const SizedBox(height: 14),
                      _FieldLabel('TANGGAL TARGET (OPSIONAL)'),
                      InkWell(
                        borderRadius: BorderRadius.circular(13),
                        onTap: _pickDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? PlanoraColors.darkCard
                                : PlanoraColors.cardSurface,
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: isDark
                                  ? PlanoraColors.darkBorder
                                  : PlanoraColors.inputBorder,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _targetDate == null
                                      ? 'Fleksibel (ketuk untuk memilih)'
                                      : AppFormatters.shortMonthYear(
                                          _targetDate!,
                                        ),
                                  style: AppTheme.manrope(
                                    size: 14,
                                    weight: FontWeight.w600,
                                    color: _targetDate == null
                                        ? cs.onSurfaceVariant
                                        : cs.onSurface,
                                  ),
                                ),
                              ),
                              if (_targetDate != null)
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _targetDate = null),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                      color: cs.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 18,
                                color: cs.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 14),
                    _FieldLabel('WARNA PORTO'),
                    const SizedBox(height: 4),
                    Row(
                      children: PlanoraColors.sixPortfolioColors.map((c) {
                        final selected = c == _colorValue;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () => setState(() => _colorValue = c),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: selected
                                    ? Border.all(
                                        color: cs.onSurface,
                                        width: 2.5,
                                      )
                                    : Border.all(
                                        color: Colors.transparent,
                                        width: 2.5,
                                      ),
                              ),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Color(c),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 14),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: Text(
                          'Pengaturan Lanjutan (Setoran, Return, Ikon, Catatan)',
                          style: AppTheme.manrope(
                            size: 12.5,
                            weight: FontWeight.w700,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        children: [
                          const SizedBox(height: 6),
                          RupiahTextField(
                            controller: _monthlyPlanCtrl,
                            label: 'Rencana setoran bulanan',
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _returnCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Asumsi return per tahun (%)',
                              suffixText: '%',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _noteCtrl,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              labelText: 'Catatan (opsional)',
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: PortfolioPalette.icons.entries.map((entry) {
                              final sel = entry.key == _iconKey;
                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () =>
                                    setState(() => _iconKey = entry.key),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: sel
                                        ? Color(_colorValue)
                                            .withValues(alpha: 0.14)
                                        : cs.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: sel
                                          ? Color(_colorValue)
                                          : cs.outlineVariant,
                                      width: sel ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Icon(
                                    entry.value,
                                    size: 20,
                                    color: sel
                                        ? Color(_colorValue)
                                        : cs.onSurfaceVariant,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    PlanoraNoteBox(
                      child: Text(
                        'Porto baru otomatis muncul di semua fase dengan alokasi Rp 0 — atur pembagiannya dari Form Fase. Rincian komponen instrumen dikelola di Detail Porto.',
                        style: AppTheme.manrope(
                          size: 12,
                          color: cs.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                    ),
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
                    onPressed: _saving ? null : _submit,
                    child: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Porto'),
                  ),
                  if (isEdit) ...[
                    const SizedBox(height: 6),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: PlanoraColors.danger,
                      ),
                      onPressed: _saving ? null : _confirmDelete,
                      child: const Text('Hapus Porto'),
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: AppTheme.uppercaseLabel(color: PlanoraColors.inkMuted),
      ),
    );
  }
}

class _ModeSegmentItem extends StatelessWidget {
  const _ModeSegmentItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(9),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected
                ? (isDark ? PlanoraColors.darkBg : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: selected && !isDark
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTheme.manrope(
              size: 12,
              weight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? cs.primary : cs.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
