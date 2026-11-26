import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/widgets/planora_charts.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class EditableComponentRow {
  EditableComponentRow({
    required this.key,
    this.id,
    required this.instrumentType,
    required this.targetPercent,
    this.actualAmount = 0,
    this.mechanism,
    this.totalStockLots = 0,
    this.isLocked = false,
    this.name,
    this.codeNote,
  });

  final String key;
  final String? id;
  final String instrumentType;
  double targetPercent;
  final int actualAmount;
  final String? mechanism;
  final int totalStockLots;
  final bool isLocked;
  final String? name;
  final String? codeNote;

  bool get isLotBased =>
      (mechanism ??
          StockLotCalc.defaultMechanismForInstrument(instrumentType)) ==
      StockLotCalc.mechanismLotBased;

  EditableComponentRow copyWith({
    String? key,
    String? id,
    String? instrumentType,
    double? targetPercent,
    int? actualAmount,
    String? mechanism,
    int? totalStockLots,
    bool? isLocked,
    String? name,
    String? codeNote,
  }) {
    return EditableComponentRow(
      key: key ?? this.key,
      id: id ?? this.id,
      instrumentType: instrumentType ?? this.instrumentType,
      targetPercent: targetPercent ?? this.targetPercent,
      actualAmount: actualAmount ?? this.actualAmount,
      mechanism: mechanism ?? this.mechanism,
      totalStockLots: totalStockLots ?? this.totalStockLots,
      isLocked: isLocked ?? this.isLocked,
      name: name ?? this.name,
      codeNote: codeNote ?? this.codeNote,
    );
  }
}

class ComponentAllocationEditor extends StatefulWidget {
  const ComponentAllocationEditor({
    super.key,
    required this.rows,
    required this.portfolioTargetTotal,
    required this.inputMode,
    required this.onRowsChanged,
    required this.onInputModeChanged,
  });

  final List<EditableComponentRow> rows;
  final int portfolioTargetTotal;

  final String inputMode;
  final ValueChanged<List<EditableComponentRow>> onRowsChanged;
  final ValueChanged<String> onInputModeChanged;

  @override
  State<ComponentAllocationEditor> createState() =>
      _ComponentAllocationEditorState();
}

class _ComponentAllocationEditorState extends State<ComponentAllocationEditor> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
  String? _lastEditedKey;
  int _keyCounter = 0;

  @override
  void initState() {
    super.initState();
    _syncControllersFromRows();
  }

  @override
  void didUpdateWidget(covariant ComponentAllocationEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inputMode != widget.inputMode ||
        oldWidget.portfolioTargetTotal != widget.portfolioTargetTotal ||
        oldWidget.rows.length != widget.rows.length) {
      _syncControllersFromRows(respectFocus: oldWidget.inputMode == widget.inputMode);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    for (final f in _focusNodes.values) {
      f.dispose();
    }
    super.dispose();
  }

  String _formatControllerText(EditableComponentRow row) {
    if (widget.inputMode == 'nominal') {
      final nominal = PlanoraV22Calc.targetAmountFromPercent(
        targetPercent: row.targetPercent,
        portfolioTargetTotal: widget.portfolioTargetTotal,
      );
      return nominal > 0 ? AppFormatters.number(nominal) : '';
    }
    final r = PlanoraV22Calc.round2(row.targetPercent);
    if (r <= 0) return '';
    if ((r - r.roundToDouble()).abs() < 0.005) {
      return r.round().toString();
    }
    return r.toStringAsFixed(2);
  }

  FocusNode _focusNodeFor(String key) {
    return _focusNodes.putIfAbsent(key, FocusNode.new);
  }

  void _syncControllersFromRows({
    List<EditableComponentRow>? rows,
    String? skipKey,
    bool respectFocus = true,
  }) {
    final source = rows ?? widget.rows;
    final validKeys = source.map((e) => e.key).toSet();
    final stale = _controllers.keys.where((k) => !validKeys.contains(k)).toList();
    for (final k in stale) {
      _controllers.remove(k)?.dispose();
      _focusNodes.remove(k)?.dispose();
    }
    for (final r in source) {
      final ctrl = _controllers.putIfAbsent(
        r.key,
        () => TextEditingController(text: _formatControllerText(r)),
      );
      final focus = _focusNodeFor(r.key);
      if (r.key != skipKey && (!respectFocus || !focus.hasFocus)) {
        final desired = _formatControllerText(r);
        if (ctrl.text != desired) {
          ctrl.value = TextEditingValue(
            text: desired,
            selection: TextSelection.collapsed(offset: desired.length),
          );
        }
      }
    }
  }

  void _emit(
    List<EditableComponentRow> next, {
    String? skipControllerKey,
    bool forceSync = false,
  }) {
    _syncControllersFromRows(
      rows: next,
      skipKey: skipControllerKey,
      respectFocus: !forceSync,
    );
    widget.onRowsChanged(next);
  }

  void _updateRowPercent(
    String key,
    double nextPercent, {
    bool skipController = false,
    bool fromSlider = false,
  }) {
    _lastEditedKey = key;
    final clamped = PlanoraV22Calc.round2(nextPercent.clamp(0.0, 100.0));
    final next = widget.rows
        .map((r) => r.key == key ? r.copyWith(targetPercent: clamped) : r)
        .toList();
    _emit(
      next,
      skipControllerKey: skipController ? key : null,
      forceSync: fromSlider,
    );
  }

  void _applyAutoBalance() {
    final items = widget.rows
        .map(
          (r) => ComponentPercentItem(
            key: r.key,
            instrumentType: r.instrumentType,
            targetPercent: r.targetPercent,
            actualAmount: r.actualAmount,
          ),
        )
        .toList();
    final balanced = PlanoraV22Calc.autoBalanceTo100(
      items,
      lastEditedKey: _lastEditedKey,
    );
    final map = {for (final b in balanced) b.key: b.targetPercent};
    final next = widget.rows
        .map((r) => r.copyWith(targetPercent: map[r.key] ?? r.targetPercent))
        .toList();
    _emit(next, forceSync: true);
  }

  Future<void> _showAddComponentSheet() async {
    final usedNorm = widget.rows
        .map((r) => r.instrumentType.trim().toLowerCase())
        .toSet();
    final available = PlanoraChartTokens.instrumentPresets
        .where((p) => p == 'Lainnya' || !usedNorm.contains(p.toLowerCase()))
        .toList();

    final chosen = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => _AddComponentSheet(
        availablePresets: available,
        usedNormalizedNames: usedNorm,
      ),
    );

    if (chosen == null || !mounted) return;
    _keyCounter++;
    final newKey = 'comp_new_${DateTime.now().microsecondsSinceEpoch}_$_keyCounter';
    final next = [
      ...widget.rows,
      EditableComponentRow(
        key: newKey,
        instrumentType: chosen,
        targetPercent: 0.0,
      ),
    ];
    _lastEditedKey = newKey;
    _emit(next);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isNominalMode = widget.inputMode == 'nominal';
    final totalPct = PlanoraV22Calc.totalTargetPercent(
      widget.rows.map((r) => r.targetPercent),
    );
    final isPas = PlanoraV22Calc.isExact100(
      widget.rows.map((r) => r.targetPercent),
    );
    final isOver = totalPct > 100.001;
    final diffPct = PlanoraV22Calc.round2((100.0 - totalPct).abs());
    final diffRp = PlanoraV22Calc.targetAmountFromPercent(
      targetPercent: diffPct,
      portfolioTargetTotal: widget.portfolioTargetTotal,
    );

    final slices = widget.rows
        .map(
          (r) => DonutSliceData(
            label: r.instrumentType,
            percent: r.targetPercent,
            amount: PlanoraV22Calc.targetAmountFromPercent(
              targetPercent: r.targetPercent,
              portfolioTargetTotal: widget.portfolioTargetTotal,
            ),
            color: PlanoraChartTokens.colorForInstrument(
              r.instrumentType,
              isDark: isDark,
            ),
          ),
        )
        .toList();

    final statusBg = isPas
        ? (isDark
            ? PlanoraColors.primary.withValues(alpha: 0.25)
            : PlanoraColors.greenSoft)
        : (isOver
            ? (isDark
                ? PlanoraColors.danger.withValues(alpha: 0.25)
                : PlanoraColors.dangerSoft)
            : (isDark
                ? PlanoraColors.gold.withValues(alpha: 0.22)
                : PlanoraColors.noteYellowBg));
    final statusColor = isPas
        ? (isDark ? PlanoraChartTokens.chartMoney : PlanoraColors.primary)
        : (isOver ? PlanoraColors.danger : PlanoraColors.gold);

    final statusText = isPas
        ? 'Total 100% — pas'
        : isOver
            ? (isNominalMode && widget.portfolioTargetTotal > 0
                ? 'Total ${PlanoraV22Calc.formatPercent(totalPct, forceTwoDecimals: true)} — lebih ${PlanoraV22Calc.formatPercent(diffPct)} (${AppFormatters.rupiah(diffRp)})'
                : 'Total ${PlanoraV22Calc.formatPercent(totalPct, forceTwoDecimals: true)} — lebih ${PlanoraV22Calc.formatPercent(diffPct)}')
            : (isNominalMode && widget.portfolioTargetTotal > 0
                ? 'Total ${PlanoraV22Calc.formatPercent(totalPct, forceTwoDecimals: true)} — kurang ${PlanoraV22Calc.formatPercent(diffPct)} (${AppFormatters.rupiah(diffRp)})'
                : 'Total ${PlanoraV22Calc.formatPercent(totalPct, forceTwoDecimals: true)} — kurang ${PlanoraV22Calc.formatPercent(diffPct)}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'KOMPONEN INSTRUMEN',
                style: AppTheme.manrope(
                  size: 11,
                  weight: FontWeight.w800,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _showAddComponentSheet,
              icon: const Icon(Icons.add, size: 17),
              label: const Text('Tambah'),
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDark ? PlanoraColors.darkCard : PlanoraColors.segmentBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _ModeToggleChip(
                label: '% Persen',
                selected: !isNominalMode,
                onTap: () => widget.onInputModeChanged('percent'),
              ),
              _ModeToggleChip(
                label: 'Rp Nominal',
                selected: isNominalMode,
                onTap: () => widget.onInputModeChanged('nominal'),
              ),
            ],
          ),
        ),

        if (isNominalMode && widget.portfolioTargetTotal <= 0) ...[
          const SizedBox(height: 8),
          Text(
            'Isi Target Simpan terlebih dahulu agar konversi Rp ↔ % dapat dihitung.',
            style: AppTheme.manrope(
              size: 11.5,
              color: PlanoraColors.gold,
            ),
          ),
        ],

        const SizedBox(height: 12),

        PlanoraAllocationDonutChart(
          slices: slices,
          centerLabel: 'Target',
          centerValue: PlanoraV22Calc.formatPercent(totalPct),
          mini: true,
          emptyMessage: 'Geser slider atau ketik angka untuk mengatur alokasi',
        ),

        const SizedBox(height: 12),

        for (final row in widget.rows) _buildRow(context, row, isDark),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor.withValues(alpha: 0.35)),
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
              if (!isPas && widget.rows.isNotEmpty) ...[
                const SizedBox(width: 8),
                TextButton(
                  onPressed: _applyAutoBalance,
                  style: TextButton.styleFrom(
                    foregroundColor: statusColor,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    minimumSize: const Size(48, 36),
                  ),
                  child: const Text('Pas-kan ke 100%'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
    BuildContext context,
    EditableComponentRow row,
    bool isDark,
  ) {
    final cs = Theme.of(context).colorScheme;
    final color = PlanoraChartTokens.colorForInstrument(
      row.instrumentType,
      isDark: isDark,
    );
    final isNominalMode = widget.inputMode == 'nominal';
    final ctrl = _controllers.putIfAbsent(
      row.key,
      () => TextEditingController(text: _formatControllerText(row)),
    );
    final derivedNominal = PlanoraV22Calc.targetAmountFromPercent(
      targetPercent: row.targetPercent,
      portfolioTargetTotal: widget.portfolioTargetTotal,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 8, 8),
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
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  PlanoraChartTokens.iconForInstrument(row.instrumentType),
                  size: 16,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          row.instrumentType,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.manrope(
                            size: 13.5,
                            weight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        if (row.isLotBased)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
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
                                size: 10,
                                weight: FontWeight.w800,
                                color: PlanoraChartTokens.chartStock,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      isNominalMode
                          ? PlanoraV22Calc.formatPercent(row.targetPercent)
                          : (widget.portfolioTargetTotal > 0
                              ? AppFormatters.rupiah(derivedNominal)
                              : 'Target nominal belum diisi'),
                      style: AppTheme.manrope(
                        size: 11,
                        color: cs.onSurfaceVariant,
                        tabular: true,
                      ),
                    ),
                    if (row.isLotBased)
                      Text(
                        'Tertanam saat ini ${AppFormatters.rupiah(row.actualAmount)} dari ${row.totalStockLots} lot',
                        style: AppTheme.manrope(
                          size: 10.5,
                          color: cs.onSurfaceVariant,
                          tabular: true,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: isNominalMode ? 124 : 84,
                child: TextField(
                  controller: ctrl,
                  focusNode: _focusNodeFor(row.key),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: !isNominalMode,
                  ),
                  inputFormatters: isNominalMode
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
                    prefixText: isNominalMode ? 'Rp ' : null,
                    suffixText: isNominalMode ? null : '%',
                  ),
                  onChanged: (val) {
                    if (isNominalMode) {
                      final nom = parseRupiahInput(val);
                      final pct = PlanoraV22Calc.percentFromNominal(
                        nominal: nom,
                        portfolioTargetTotal: widget.portfolioTargetTotal,
                      );
                      _updateRowPercent(row.key, pct, skipController: true);
                    } else {
                      final parsed =
                          double.tryParse(val.replaceAll(',', '.')) ?? 0.0;
                      _updateRowPercent(row.key, parsed, skipController: true);
                    }
                  },
                ),
              ),
              IconButton(
                tooltip: row.isLocked
                    ? 'Instrumen dengan transaksi lot atau saldo awal tidak dapat dihapus'
                    : 'Hapus ${row.instrumentType}',
                onPressed: row.isLocked
                    ? null
                    : () {
                        final next = widget.rows
                            .where((e) => e.key != row.key)
                            .toList();
                        _emit(next);
                      },
                icon: Icon(
                  row.isLocked ? Icons.lock_outline_rounded : Icons.close_rounded,
                  size: 18,
                  color: cs.onSurfaceVariant,
                ),
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              ),
            ],
          ),
          Semantics(
            label:
                '${row.instrumentType} ${PlanoraV22Calc.formatPercent(row.targetPercent)}',
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: color,
                thumbColor: color,
                overlayColor: color.withValues(alpha: 0.16),
                inactiveTrackColor: cs.surfaceContainerHighest,
                trackHeight: 4,
              ),
              child: Slider(
                value: row.targetPercent.clamp(0.0, 100.0),
                min: 0,
                max: 100,
                divisions: 200,
                onChanged: (v) =>
                    _updateRowPercent(row.key, v, fromSlider: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddComponentSheet extends StatefulWidget {
  const _AddComponentSheet({
    required this.availablePresets,
    required this.usedNormalizedNames,
  });

  final List<String> availablePresets;
  final Set<String> usedNormalizedNames;

  @override
  State<_AddComponentSheet> createState() => _AddComponentSheetState();
}

class _AddComponentSheetState extends State<_AddComponentSheet> {
  final _customCtrl = TextEditingController();
  bool _showCustomField = false;
  String? _customError;

  @override
  void dispose() {
    _customCtrl.dispose();
    super.dispose();
  }

  void _submitCustom() {
    final txt = _customCtrl.text.trim();
    if (txt.isEmpty) {
      setState(() => _customError = 'Masukkan nama instrumen.');
      return;
    }
    if (widget.usedNormalizedNames.contains(txt.toLowerCase())) {
      setState(() => _customError = 'Instrumen ini sudah ada di portofolio.');
      return;
    }
    Navigator.of(context).pop(txt);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tambah Instrumen',
              style: AppTheme.sora(size: 16, weight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Pilih dari daftar atau buat nama instrumen sendiri.',
              style: AppTheme.manrope(
                size: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            if (!_showCustomField)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.availablePresets.map((preset) {
                  final color = PlanoraChartTokens.colorForInstrument(
                    preset,
                    isDark: isDark,
                  );
                  return ActionChip(
                    avatar: CircleAvatar(
                      backgroundColor: color,
                      radius: 6,
                    ),
                    label: Text(preset),
                    onPressed: () {
                      if (preset == 'Lainnya') {
                        setState(() {
                          _showCustomField = true;
                          _customError = null;
                        });
                      } else {
                        Navigator.of(context).pop(preset);
                      }
                    },
                  );
                }).toList(),
              )
            else ...[
              TextField(
                controller: _customCtrl,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onChanged: (_) {
                  if (_customError != null) {
                    setState(() => _customError = null);
                  }
                },
                onSubmitted: (_) => _submitCustom(),
                decoration: InputDecoration(
                  labelText: 'Nama instrumen',
                  hintText: 'Contoh: Obligasi Ritel, Reksa Dana Indeks',
                  errorText: _customError,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          setState(() => _showCustomField = false),
                      child: const Text('Kembali'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: _submitCustom,
                      child: const Text('Tambahkan'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ModeToggleChip extends StatelessWidget {
  const _ModeToggleChip({
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
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
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

