import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
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
    _selectedComponentId = widget.existing?.componentId;
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final repo = ref.read(portfolioRepositoryProvider);
      final amount = parseRupiahInput(_amountCtrl.text);
      final dateIso = AppFormatters.toIsoDate(_selectedDate);
      final note = _noteCtrl.text.trim();

      if (widget.existing == null) {
        await repo.addContribution(
          portfolioId: widget.portfolioId,
          amount: amount,
          dateIso: dateIso,
          note: note,
          componentId: _selectedComponentId,
        );
      } else {
        await repo.updateContribution(
          id: widget.existing!.id,
          amount: amount,
          dateIso: dateIso,
          note: note,
          componentId: _selectedComponentId,
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
    final components =
        ref.watch(portfolioComponentsProvider(widget.portfolioId)).value ??
            const <PortfolioComponent>[];

    final validSelected = components.any((c) => c.id == _selectedComponentId)
        ? _selectedComponentId
        : null;

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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              RupiahTextField(
                controller: _amountCtrl,
                label: 'Jumlah setoran',
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
                    labelText: 'Alokasikan ke instrumen (opsional)',
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Umum (tidak dialokasikan ke instrumen)'),
                    ),
                    ...components.map(
                      (c) => DropdownMenuItem<String?>(
                        value: c.id,
                        child: Text(c.instrumentType),
                      ),
                    ),
                  ],
                  onChanged: (v) => setState(() => _selectedComponentId = v),
                ),
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
                  hintText: 'Contoh: Setoran rutin November',
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: _saving ? null : _submit,
                child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Setoran'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

