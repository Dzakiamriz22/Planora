import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/cash_flow_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/cash_flow_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

IconData cashFlowIconData(String key) {
  return switch (key) {
    'payments' => Icons.payments_outlined,
    'work' => Icons.work_outline_rounded,
    'card_giftcard' => Icons.card_giftcard_outlined,
    'trending_up' => Icons.trending_up_rounded,
    'restaurant' => Icons.restaurant_outlined,
    'local_cafe' => Icons.local_cafe_outlined,
    'directions_bus' => Icons.directions_bus_outlined,
    'local_gas_station' => Icons.local_gas_station_outlined,
    'local_parking' => Icons.local_parking_rounded,
    'shopping_bag' => Icons.shopping_bag_outlined,
    'medical_services' => Icons.medical_services_outlined,
    'movie' => Icons.movie_outlined,
    'receipt_long' => Icons.receipt_long_outlined,
    _ => Icons.category_outlined,
  };
}

Future<void> showCashFlowEntrySheet(
  BuildContext context, {
  String initialType = CashFlowCalc.typeExpense,
  CashFlowTransaction? existing,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => CashFlowEntrySheet(
      initialType: existing?.type ?? initialType,
      existing: existing,
    ),
  );
}

class CashFlowEntrySheet extends ConsumerStatefulWidget {
  const CashFlowEntrySheet({
    super.key,
    this.initialType = CashFlowCalc.typeExpense,
    this.existing,
  });

  final String initialType;
  final CashFlowTransaction? existing;

  @override
  ConsumerState<CashFlowEntrySheet> createState() => _CashFlowEntrySheetState();
}

class _CashFlowEntrySheetState extends ConsumerState<CashFlowEntrySheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountCtrl;
  late final TextEditingController _noteCtrl;
  late String _type;
  late DateTime _selectedDate;
  String? _selectedCategoryId;
  bool _saving = false;
  String? _errorText;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _type = ex?.type ?? widget.initialType;
    _amountCtrl = TextEditingController(
      text: ex != null ? AppFormatters.number(ex.amount) : '',
    );
    _noteCtrl = TextEditingController(text: ex?.note ?? '');
    _selectedDate =
        AppFormatters.parseIsoDate(ex?.transactionDate) ?? DateTime.now();
    _selectedCategoryId = ex?.categoryId;
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  List<CashFlowCategory> _sortedCategoriesForType(
    List<CashFlowCategory> allCats,
    List<CashFlowTransaction> allTxs,
    String type,
  ) {
    final freq = <String, int>{};
    for (final tx in allTxs) {
      if (tx.type == type) {
        freq[tx.categoryId] = (freq[tx.categoryId] ?? 0) + 1;
      }
    }
    final filtered = allCats
        .where(
          (c) =>
              c.type == type &&
              (!c.isHidden || c.id == widget.existing?.categoryId),
        )
        .toList();
    filtered.sort((a, b) {
      final fa = freq[a.id] ?? 0;
      final fb = freq[b.id] ?? 0;
      if (fa != fb) return fb.compareTo(fa);
      return a.sortOrder.compareTo(b.sortOrder);
    });
    return filtered;
  }

  String? _defaultCategoryForType(
    List<CashFlowCategory> sortedCats,
    List<CashFlowTransaction> allTxs,
    String type,
  ) {
    if (sortedCats.isEmpty) return null;
    final visibleIds = sortedCats.map((c) => c.id).toSet();
    for (final tx in allTxs) {
      if (tx.type == type && visibleIds.contains(tx.categoryId)) {
        return tx.categoryId;
      }
    }
    return sortedCats.first.id;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.isAfter(today) ? today : _selectedDate,
      firstDate: DateTime(2015, 1, 1),
      lastDate: today,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit(String? effectiveCategoryId) async {
    if (!_formKey.currentState!.validate()) return;
    final amount = parseRupiahInput(_amountCtrl.text);
    final amtErr = CashFlowCalc.validateAmount(amount);
    if (amtErr != null) {
      setState(() => _errorText = amtErr);
      return;
    }
    final dateErr = CashFlowCalc.validateTransactionDate(_selectedDate);
    if (dateErr != null) {
      setState(() => _errorText = dateErr);
      return;
    }
    if (effectiveCategoryId == null) {
      setState(() => _errorText = 'Pilih kategori terlebih dahulu.');
      return;
    }

    setState(() {
      _saving = true;
      _errorText = null;
    });

    try {
      final repo = ref.read(cashFlowRepositoryProvider);
      if (_isEdit) {
        await repo.updateTransaction(
          id: widget.existing!.id,
          type: _type,
          amount: amount,
          categoryId: effectiveCategoryId,
          transactionDate: _selectedDate,
          note: _noteCtrl.text,
        );
      } else {
        await repo.addTransaction(
          type: _type,
          amount: amount,
          categoryId: effectiveCategoryId,
          transactionDate: _selectedDate,
          note: _noteCtrl.text,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() => _errorText = e.toString());
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmDelete() async {
    final ex = widget.existing;
    if (ex == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Transaksi?'),
        content: Text(
          'Transaksi sebesar ${AppFormatters.rupiah(ex.amount, allowMask: false)} akan dihapus dari catatan arus kas.',
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
    await ref.read(cashFlowRepositoryProvider).deleteTransaction(ex.id);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final cs = Theme.of(context).colorScheme;
    final allCats =
        ref.watch(cashFlowCategoriesStreamProvider).value ?? const [];
    final allTxs =
        ref.watch(cashFlowTransactionsStreamProvider).value ?? const [];

    final sortedCats = _sortedCategoriesForType(allCats, allTxs, _type);
    final validCatIds = sortedCats.map((c) => c.id).toSet();
    final effectiveCatId =
        (_selectedCategoryId != null && validCatIds.contains(_selectedCategoryId))
            ? _selectedCategoryId
            : _defaultCategoryForType(sortedCats, allTxs, _type);

    final isIncome = _type == CashFlowCalc.typeIncome;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 18, 20, 20 + bottomInset),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isEdit ? 'Edit Transaksi Arus Kas' : 'Catat Arus Kas',
                style: AppTheme.sora(size: 17, weight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              SegmentedButton<String>(
                key: const Key('cashflow_type_segment'),
                segments: const [
                  ButtonSegment(
                    value: CashFlowCalc.typeExpense,
                    icon: Icon(Icons.arrow_upward_rounded, size: 16),
                    label: Text('Pengeluaran'),
                  ),
                  ButtonSegment(
                    value: CashFlowCalc.typeIncome,
                    icon: Icon(Icons.arrow_downward_rounded, size: 16),
                    label: Text('Pemasukan'),
                  ),
                ],
                selected: {_type},
                onSelectionChanged: (s) {
                  if (s.isNotEmpty) {
                    setState(() {
                      _type = s.first;
                      _selectedCategoryId = null;
                      _errorText = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                key: const Key('cashflow_amount_field'),
                controller: _amountCtrl,
                autofocus: !_isEdit,
                keyboardType: TextInputType.number,
                inputFormatters: [RupiahInputFormatter()],
                style: AppTheme.sora(
                  size: 20,
                  weight: FontWeight.w800,
                  color: isIncome ? PlanoraColors.primary : cs.onSurface,
                  tabular: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Nominal',
                  prefixText: 'Rp ',
                  hintText: '0',
                ),
                validator: (v) {
                  final amt = parseRupiahInput(v ?? '');
                  return CashFlowCalc.validateAmount(amt);
                },
              ),
              const SizedBox(height: 14),
              Text(
                isIncome ? 'KATEGORI PEMASUKAN' : 'KATEGORI PENGELUARAN',
                style: AppTheme.uppercaseLabel(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sortedCats.map((cat) {
                  final selected = cat.id == effectiveCatId;
                  return ChoiceChip(
                    key: Key('cf_cat_${cat.id}'),
                    avatar: Icon(
                      cashFlowIconData(cat.icon),
                      size: 16,
                      color: selected ? Colors.white : Color(cat.color),
                    ),
                    label: Text(cat.name),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => _selectedCategoryId = cat.id);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const Key('cashflow_date_button'),
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today_outlined, size: 17),
                      label: Text(AppFormatters.shortDate(_selectedDate)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                key: const Key('cashflow_note_field'),
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'Catatan (opsional)',
                  hintText: 'Contoh: Makan siang, proyek desain',
                ),
              ),
              if (_errorText != null) ...[
                const SizedBox(height: 8),
                Text(
                  _errorText!,
                  style: AppTheme.manrope(
                    size: 12,
                    weight: FontWeight.w700,
                    color: PlanoraColors.danger,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              FilledButton(
                key: const Key('cashflow_save_button'),
                onPressed: _saving ? null : () => _submit(effectiveCatId),
                child: Text(
                  _isEdit
                      ? 'Simpan Perubahan'
                      : (isIncome ? 'Simpan Pemasukan' : 'Simpan Pengeluaran'),
                ),
              ),
              if (_isEdit) ...[
                const SizedBox(height: 6),
                TextButton(
                  key: const Key('cashflow_delete_button'),
                  style: TextButton.styleFrom(
                    foregroundColor: PlanoraColors.danger,
                  ),
                  onPressed: _saving ? null : _confirmDelete,
                  child: const Text('Hapus Transaksi'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
