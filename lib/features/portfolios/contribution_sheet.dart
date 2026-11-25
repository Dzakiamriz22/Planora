import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

Future<void> showContributionSheet(
  BuildContext context, {
  required WidgetRef ref,
  required String portfolioId,
  required String portfolioName,
  Contribution? existing,
  int? suggestedAmount,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => _ContributionSheet(
      portfolioId: portfolioId,
      portfolioName: portfolioName,
      existing: existing,
      suggestedAmount: suggestedAmount,
    ),
  );
}

class _ContributionSheet extends ConsumerStatefulWidget {
  const _ContributionSheet({
    required this.portfolioId,
    required this.portfolioName,
    this.existing,
    this.suggestedAmount,
  });

  final String portfolioId;
  final String portfolioName;
  final Contribution? existing;
  final int? suggestedAmount;

  @override
  ConsumerState<_ContributionSheet> createState() => _ContributionSheetState();
}

class _ContributionSheetState extends ConsumerState<_ContributionSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountCtrl;
  late final TextEditingController _noteCtrl;
  late DateTime _selectedDate;
  String? _selectedComponentId;
  bool _componentSelectionInitialized = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final initialAmount = widget.existing?.amount ?? widget.suggestedAmount ?? 0;
    _amountCtrl = TextEditingController(
      text: initialAmount > 0 ? AppFormatters.number(initialAmount) : '',
    );
    _noteCtrl = TextEditingController(text: widget.existing?.note ?? '');
    _selectedDate =
        AppFormatters.parseIsoDate(widget.existing?.date) ?? DateTime.now();
    if (widget.existing != null) {
      _selectedComponentId = widget.existing!.componentId;
      _componentSelectionInitialized = true;
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit(List<PortfolioComponent> components) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final repo = ref.read(portfolioRepositoryProvider);
      final amount = parseRupiahInput(_amountCtrl.text);
      final dateIso = AppFormatters.toIsoDate(_selectedDate);
      final note = _noteCtrl.text.trim();
      final effectiveComponentId =
          components.isEmpty ? null : _selectedComponentId;

      if (widget.existing == null) {
        await repo.addContribution(
          portfolioId: widget.portfolioId,
          amount: amount,
          dateIso: dateIso,
          note: note,
          componentId: effectiveComponentId,
        );
      } else {
        await repo.updateContribution(
          id: widget.existing!.id,
          amount: amount,
          dateIso: dateIso,
          note: note,
          componentId: effectiveComponentId,
          updateComponentId: true,
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isEdit = widget.existing != null;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final components =
        ref.watch(portfolioComponentsProvider(widget.portfolioId)).value ??
            const <PortfolioComponent>[];

    final hasPercentComponents = components.isNotEmpty &&
        components.any((c) => c.targetPercent > 0);

    if (!_componentSelectionInitialized && hasPercentComponents) {
      _componentSelectionInitialized = true;
      _selectedComponentId = PortfolioRepository.autoSplitComponentId;
    }

    final validSelected = (_selectedComponentId ==
                PortfolioRepository.autoSplitComponentId &&
            hasPercentComponents) ||
        components.any((c) => c.id == _selectedComponentId)
        ? _selectedComponentId
        : null;

    final currentAmount = parseRupiahInput(_amountCtrl.text);
    final isAutoSplit =
        validSelected == PortfolioRepository.autoSplitComponentId;
    final autoSplits = (isAutoSplit && currentAmount > 0)
        ? PlanoraV22Calc.splitDepositByTargetPercent(
            depositAmount: currentAmount,
            components: components
                .map((c) => (id: c.id, targetPercent: c.targetPercent))
                .toList(),
          )
        : const <String, int>{};

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isEdit
                    ? 'Edit Setoran — ${widget.portfolioName}'
                    : 'Catat Setoran — ${widget.portfolioName}',
                style: AppTheme.sora(size: 17, weight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              RupiahTextField(
                controller: _amountCtrl,
                label: 'Jumlah setoran',
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  final amount = parseRupiahInput(value ?? '');
                  if (amount <= 0) {
                    return 'Masukkan jumlah setoran lebih dari Rp 0.';
                  }
                  return null;
                },
              ),
              if (components.isNotEmpty) ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  initialValue: validSelected,
                  decoration: const InputDecoration(
                    labelText: 'Pembagian ke instrumen',
                  ),
                  items: [
                    if (hasPercentComponents)
                      const DropdownMenuItem<String?>(
                        value: PortfolioRepository.autoSplitComponentId,
                        child: Text('Otomatis sesuai persentase target'),
                      ),
                    ...components.map(
                      (c) => DropdownMenuItem<String?>(
                        value: c.id,
                        child: Text(
                          'Hanya ke ${c.instrumentType} (${PlanoraV22Calc.formatPercent(c.targetPercent)})',
                        ),
                      ),
                    ),
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Umum (tanpa pembagian instrumen)'),
                    ),
                  ],
                  onChanged: (v) => setState(() => _selectedComponentId = v),
                ),
                if (isAutoSplit && currentAmount > 0) ...[
                  const SizedBox(height: 10),
                  PlanoraNoteBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pembagian otomatis setoran ini:',
                          style: AppTheme.manrope(
                            size: 11.5,
                            weight: FontWeight.w700,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        for (final c in components)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color:
                                        PlanoraChartTokens.colorForInstrument(
                                      c.instrumentType,
                                      isDark: isDark,
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Text(
                                    '${c.instrumentType} (${PlanoraV22Calc.formatPercent(c.targetPercent)})',
                                    style: AppTheme.manrope(
                                      size: 12,
                                      color: cs.onSurface,
                                    ),
                                  ),
                                ),
                                Text(
                                  AppFormatters.rupiah(autoSplits[c.id] ?? 0),
                                  style: AppTheme.manrope(
                                    size: 12,
                                    weight: FontWeight.w800,
                                    color: cs.onSurface,
                                    tabular: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(
                  'Tanggal: ${AppFormatters.shortDate(_selectedDate)}',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'Keterangan (opsional)',
                  hintText: 'Contoh: Setoran rutin bulan ini',
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: _saving ? null : () => _submit(components),
                child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Setoran'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
