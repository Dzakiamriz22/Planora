import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/chart_tokens.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/stock_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

Future<void> showBuyStockSheet(
  BuildContext context, {
  required WidgetRef ref,
  required String componentId,
  StockTransaction? existing,
  int? legacyOpeningLimit,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => BuyStockSheet(
      componentId: componentId,
      existing: existing,
      legacyOpeningLimit: legacyOpeningLimit,
    ),
  );
}

Future<void> showSellStockSheet(
  BuildContext context, {
  required WidgetRef ref,
  required String componentId,
  required StockPosition position,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => SellStockSheet(
      componentId: componentId,
      position: position,
    ),
  );
}

class BuyStockSheet extends ConsumerStatefulWidget {
  const BuyStockSheet({
    super.key,
    required this.componentId,
    this.existing,
    this.legacyOpeningLimit,
  });

  final String componentId;
  final StockTransaction? existing;
  final int? legacyOpeningLimit;

  @override
  ConsumerState<BuyStockSheet> createState() => _BuyStockSheetState();
}

class _BuyStockSheetState extends ConsumerState<BuyStockSheet> {
  late final TextEditingController _tickerCtrl;
  late final TextEditingController _lotsCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _noteCtrl;
  late DateTime _selectedDate;
  bool _saving = false;

  bool get _isEdit => widget.existing != null;
  bool get _isLegacyConversion => widget.legacyOpeningLimit != null;

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _tickerCtrl = TextEditingController(text: ex?.ticker ?? '');
    _lotsCtrl = TextEditingController(text: ex != null ? '${ex.lots}' : '1');
    _priceCtrl = TextEditingController(
      text: ex != null ? AppFormatters.number(ex.pricePerShare) : '',
    );
    _noteCtrl = TextEditingController(text: ex?.note ?? '');
    _selectedDate =
        AppFormatters.parseIsoDate(ex?.transactionDate) ?? DateTime.now();
  }

  @override
  void dispose() {
    _tickerCtrl.dispose();
    _lotsCtrl.dispose();
    _priceCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _stepLots(int delta) {
    final current = int.tryParse(_lotsCtrl.text.trim()) ?? 0;
    final next = (current + delta).clamp(1, 9999999);
    setState(() {
      _lotsCtrl.text = '$next';
      _lotsCtrl.selection = TextSelection.collapsed(offset: _lotsCtrl.text.length);
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.isAfter(now) ? now : _selectedDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    final ticker = StockLotCalc.normalizeTicker(_tickerCtrl.text);
    final lots = int.tryParse(_lotsCtrl.text.trim()) ?? 0;
    final price = parseRupiahInput(_priceCtrl.text);
    final note = _noteCtrl.text.trim();
    final totalModal = StockLotCalc.transactionModal(
      lots: lots,
      pricePerShare: price,
    );

    setState(() => _saving = true);
    try {
      final repo = ref.read(stockRepositoryProvider);
      if (_isLegacyConversion) {
        await repo.convertLegacyOpeningToLot(
          componentId: widget.componentId,
          ticker: ticker,
          lots: lots,
          pricePerShare: price,
          transactionDate: _selectedDate,
          note: note,
        );
      } else if (_isEdit) {
        await repo.updateStockTransaction(
          transactionId: widget.existing!.id,
          ticker: ticker,
          lots: lots,
          pricePerShare: price,
          transactionDate: _selectedDate,
          note: note,
        );
      } else {
        await repo.buyStock(
          componentId: widget.componentId,
          ticker: ticker,
          lots: lots,
          pricePerShare: price,
          transactionDate: _selectedDate,
          note: note,
        );
      }

      if (mounted) {
        final messenger = ScaffoldMessenger.maybeOf(context);
        Navigator.of(context).pop();
        messenger?.showSnackBar(
          SnackBar(
            content: Text(
              _isLegacyConversion
                  ? 'Saldo awal dirinci: $ticker $lots lot (${AppFormatters.rupiah(totalModal)})'
                  : _isEdit
                      ? 'Transaksi $ticker diperbarui (${AppFormatters.rupiah(totalModal)})'
                      : 'Tercatat beli $ticker $lots lot (${AppFormatters.rupiah(totalModal)})',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final cs = Theme.of(context).colorScheme;
    final knownTickers =
        ref.watch(knownStockTickersProvider).value ?? const <String>[];

    final tickerErr = _tickerCtrl.text.isEmpty
        ? null
        : StockLotCalc.validateTicker(_tickerCtrl.text);
    final tickerValid = StockLotCalc.validateTicker(_tickerCtrl.text) == null;

    final lotsErr = StockLotCalc.validateLotsText(_lotsCtrl.text);
    final parsedLots = lotsErr == null ? int.parse(_lotsCtrl.text.trim()) : 0;
    final shares = StockLotCalc.sharesFromLots(parsedLots);

    final parsedPrice = parseRupiahInput(_priceCtrl.text);
    final priceErr = _priceCtrl.text.trim().isEmpty
        ? null
        : StockLotCalc.validatePricePerShare(parsedPrice);
    final priceValid = StockLotCalc.validatePricePerShare(parsedPrice) == null;

    final dateErr = StockLotCalc.validateTransactionDate(_selectedDate);
    final totalModal = StockLotCalc.transactionModal(
      lots: parsedLots,
      pricePerShare: parsedPrice,
    );

    final legacyExceeded = _isLegacyConversion &&
        totalModal > 0 &&
        totalModal > widget.legacyOpeningLimit!;

    final canSave = !_saving &&
        tickerValid &&
        lotsErr == null &&
        priceValid &&
        dateErr == null &&
        !legacyExceeded;

    final title = _isLegacyConversion
        ? 'Rinci Saldo Awal Menjadi Lot'
        : _isEdit
            ? (widget.existing!.side == StockLotCalc.sideSell
                ? 'Edit Transaksi Jual Saham'
                : 'Edit Transaksi Beli Saham')
            : 'Beli Saham';

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: AppTheme.sora(size: 17, weight: FontWeight.w700),
            ),
            if (_isLegacyConversion) ...[
              const SizedBox(height: 6),
              Text(
                'Sisa saldo awal yang dapat dirinci: ${AppFormatters.rupiah(widget.legacyOpeningLimit!)}. Rincian parsial diperbolehkan.',
                style: AppTheme.manrope(
                  size: 12,
                  color: cs.onSurfaceVariant,
                  tabular: true,
                ),
              ),
            ],
            const SizedBox(height: 14),
            TextField(
              key: const Key('stock_ticker_field'),
              controller: _tickerCtrl,
              readOnly: _isEdit && widget.existing!.side == StockLotCalc.sideSell,
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [_UpperCaseTextFormatter()],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Kode saham',
                hintText: '4 karakter huruf/angka',
                errorText: tickerErr,
              ),
            ),
            if (knownTickers.isNotEmpty &&
                !(_isEdit && widget.existing!.side == StockLotCalc.sideSell)) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: knownTickers.map((code) {
                  return ActionChip(
                    label: Text(code),
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      setState(() {
                        _tickerCtrl.text = code;
                        _tickerCtrl.selection = TextSelection.collapsed(
                          offset: code.length,
                        );
                      });
                    },
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton.outlined(
                  key: const Key('stock_lot_minus'),
                  tooltip: 'Kurangi lot',
                  onPressed: parsedLots > 1 ? () => _stepLots(-1) : null,
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    key: const Key('stock_lot_field'),
                    controller: _lotsCtrl,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (_) => setState(() {}),
                    style: AppTheme.manrope(
                      size: 15,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                      tabular: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Jumlah lot',
                      suffixText: 'lot',
                      errorText: lotsErr,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.outlined(
                  key: const Key('stock_lot_plus'),
                  tooltip: 'Tambah lot',
                  onPressed: () => _stepLots(1),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumlah lembar (1 lot = 100 lembar)',
                    style: AppTheme.manrope(
                      size: 12,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${AppFormatters.number(shares)} lembar',
                    key: const Key('stock_shares_display'),
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
            const SizedBox(height: 12),
            RupiahTextField(
              key: const Key('stock_price_field'),
              controller: _priceCtrl,
              label: _isEdit && widget.existing!.side == StockLotCalc.sideSell
                  ? 'Harga jual per lembar'
                  : 'Harga beli per lembar',
              onChanged: (_) => setState(() {}),
            ),
            if (priceErr != null) ...[
              const SizedBox(height: 4),
              Text(
                priceErr,
                style: AppTheme.manrope(
                  size: 11.5,
                  color: PlanoraColors.danger,
                ),
              ),
            ],
            const SizedBox(height: 12),
            PlanoraNoteBox(
              isWarning: legacyExceeded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Modal',
                    style: AppTheme.manrope(
                      size: 11,
                      weight: FontWeight.w700,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$parsedLots lot × 100 × ${AppFormatters.rupiah(parsedPrice)} = ${AppFormatters.rupiah(totalModal)}',
                    key: const Key('stock_total_modal_panel'),
                    style: AppTheme.manrope(
                      size: 13,
                      weight: FontWeight.w800,
                      color: legacyExceeded
                          ? PlanoraColors.danger
                          : PlanoraChartTokens.chartStock,
                      tabular: true,
                    ),
                  ),
                  if (legacyExceeded) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Melebihi sisa saldo awal (${AppFormatters.rupiah(widget.legacyOpeningLimit!)}).',
                      style: AppTheme.manrope(
                        size: 11.5,
                        color: PlanoraColors.danger,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today_outlined, size: 18),
              label: Text(
                'Tanggal: ${AppFormatters.shortDate(_selectedDate)}',
              ),
            ),
            if (dateErr != null) ...[
              const SizedBox(height: 4),
              Text(
                dateErr,
                style: AppTheme.manrope(
                  size: 11.5,
                  color: PlanoraColors.danger,
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: _noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
                hintText: 'Contoh: Catatan sekuritas atau alasan beli',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('stock_save_button'),
              onPressed: canSave ? _submit : null,
              child: Text(
                _isLegacyConversion
                    ? 'Simpan Rincian Lot'
                    : _isEdit
                        ? 'Simpan Perubahan'
                        : 'Simpan Pembelian',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SellStockSheet extends ConsumerStatefulWidget {
  const SellStockSheet({
    super.key,
    required this.componentId,
    required this.position,
  });

  final String componentId;
  final StockPosition position;

  @override
  ConsumerState<SellStockSheet> createState() => _SellStockSheetState();
}

class _SellStockSheetState extends ConsumerState<SellStockSheet> {
  late final TextEditingController _lotsCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _noteCtrl;
  late DateTime _selectedDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _lotsCtrl = TextEditingController(text: '1');
    _priceCtrl = TextEditingController();
    _noteCtrl = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _lotsCtrl.dispose();
    _priceCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _stepLots(int delta) {
    final current = int.tryParse(_lotsCtrl.text.trim()) ?? 0;
    final next = (current + delta).clamp(1, widget.position.totalLots);
    setState(() {
      _lotsCtrl.text = '$next';
      _lotsCtrl.selection = TextSelection.collapsed(offset: _lotsCtrl.text.length);
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.isAfter(now) ? now : _selectedDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submit() async {
    final lots = int.tryParse(_lotsCtrl.text.trim()) ?? 0;
    final price = parseRupiahInput(_priceCtrl.text);
    final note = _noteCtrl.text.trim();

    setState(() => _saving = true);
    try {
      final res = await ref.read(stockRepositoryProvider).sellStock(
            componentId: widget.componentId,
            ticker: widget.position.ticker,
            lots: lots,
            pricePerShare: price,
            transactionDate: _selectedDate,
            note: note,
          );
      if (mounted) {
        final messenger = ScaffoldMessenger.maybeOf(context);
        Navigator.of(context).pop();
        messenger?.showSnackBar(
          SnackBar(
            content: Text(
              'Tercatat jual ${widget.position.ticker} $lots lot (modal keluar ${AppFormatters.rupiah(res.modalKeluar)})',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final cs = Theme.of(context).colorScheme;
    final pos = widget.position;

    final lotFormatErr = StockLotCalc.validateLotsText(_lotsCtrl.text);
    final parsedLots =
        lotFormatErr == null ? int.parse(_lotsCtrl.text.trim()) : null;
    final lotErr = lotFormatErr ??
        StockLotCalc.validateSellLots(
          lots: parsedLots,
          availableLots: pos.totalLots,
        );

    final parsedPrice = parseRupiahInput(_priceCtrl.text);
    final priceErr = _priceCtrl.text.trim().isEmpty
        ? null
        : StockLotCalc.validatePricePerShare(parsedPrice);
    final priceValid = StockLotCalc.validatePricePerShare(parsedPrice) == null;
    final dateErr = StockLotCalc.validateTransactionDate(_selectedDate);

    final previewSell = (lotErr == null && parsedLots != null)
        ? StockLotCalc.computeSellAverageCost(
            currentLots: pos.totalLots,
            currentModal: pos.totalModal,
            sellLots: parsedLots,
          )
        : null;

    final canSave =
        !_saving && lotErr == null && priceValid && dateErr == null;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Jual Saham — ${pos.ticker}',
              style: AppTheme.sora(size: 17, weight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            PlanoraNoteBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Posisi ${pos.ticker} saat ini',
                    style: AppTheme.manrope(
                      size: 11.5,
                      weight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pos.totalLots} lot (${AppFormatters.number(pos.totalShares)} lembar) · Rata-rata ${StockLotCalc.formatAveragePrice(pos.averagePrice)}/lbr · Modal ${AppFormatters.rupiah(pos.totalModal)}',
                    style: AppTheme.manrope(
                      size: 12,
                      color: cs.onSurfaceVariant,
                      tabular: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton.outlined(
                  tooltip: 'Kurangi lot',
                  onPressed: (parsedLots ?? 0) > 1 ? () => _stepLots(-1) : null,
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    key: const Key('sell_lot_field'),
                    controller: _lotsCtrl,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (_) => setState(() {}),
                    style: AppTheme.manrope(
                      size: 15,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                      tabular: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Jumlah lot jual (maks ${pos.totalLots})',
                      suffixText: 'lot',
                      errorText: lotErr,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.outlined(
                  tooltip: 'Tambah lot',
                  onPressed: (parsedLots ?? 0) < pos.totalLots
                      ? () => _stepLots(1)
                      : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 12),
            RupiahTextField(
              key: const Key('sell_price_field'),
              controller: _priceCtrl,
              label: 'Harga jual per lembar',
              onChanged: (_) => setState(() {}),
            ),
            if (priceErr != null) ...[
              const SizedBox(height: 4),
              Text(
                priceErr,
                style: AppTheme.manrope(
                  size: 11.5,
                  color: PlanoraColors.danger,
                ),
              ),
            ],
            const SizedBox(height: 6),
            Text(
              'Harga jual dicatat sebagai informasi. Pengurangan saldo mengikuti metode biaya rata-rata.',
              style: AppTheme.manrope(
                size: 11,
                color: cs.onSurfaceVariant,
              ),
            ),
            if (previewSell != null) ...[
              const SizedBox(height: 12),
              PlanoraNoteBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Modal keluar: ${AppFormatters.rupiah(previewSell.modalKeluar)}',
                      style: AppTheme.manrope(
                        size: 12.5,
                        weight: FontWeight.w800,
                        color: cs.onSurface,
                        tabular: true,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      previewSell.lotsSisa == 0
                          ? 'Seluruh lot terjual — posisi akan ditutup dan tetap tercatat di riwayat.'
                          : 'Sisa posisi: ${previewSell.lotsSisa} lot · Modal sisa ${AppFormatters.rupiah(previewSell.modalSisa)} · Rata-rata tetap ${StockLotCalc.formatAveragePrice(previewSell.averagePriceSisa)}',
                      style: AppTheme.manrope(
                        size: 11.5,
                        color: cs.onSurfaceVariant,
                        tabular: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today_outlined, size: 18),
              label: Text(
                'Tanggal: ${AppFormatters.shortDate(_selectedDate)}',
              ),
            ),
            if (dateErr != null) ...[
              const SizedBox(height: 4),
              Text(
                dateErr,
                style: AppTheme.manrope(
                  size: 11.5,
                  color: PlanoraColors.danger,
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: _noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('sell_save_button'),
              onPressed: canSave ? _submit : null,
              child: const Text('Simpan Penjualan'),
            ),
          ],
        ),
      ),
    );
  }
}
