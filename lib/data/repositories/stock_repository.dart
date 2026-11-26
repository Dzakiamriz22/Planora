import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:uuid/uuid.dart';

class StockRepository {
  StockRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<String> _ownerId() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    return profile.id;
  }

  Stream<List<StockTransaction>> watchAllTransactions() {
    return (_db.select(_db.stockTransactions)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.desc(t.transactionDate),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  Stream<List<StockTransaction>> watchTransactionsForComponent(
    String componentId,
  ) {
    return (_db.select(_db.stockTransactions)
          ..where((t) => t.componentId.equals(componentId) & t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.desc(t.transactionDate),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  Future<List<StockTransaction>> getTransactionsForComponent(
    String componentId,
  ) {
    return (_db.select(_db.stockTransactions)
          ..where((t) => t.componentId.equals(componentId) & t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.asc(t.transactionDate),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
  }

  Stream<List<String>> watchKnownTickers() {
    return watchAllTransactions().map((txs) {
      final set = <String>{};
      for (final tx in txs) {
        final norm = StockLotCalc.normalizeTicker(tx.ticker);
        if (norm.isNotEmpty) set.add(norm);
      }
      final list = set.toList()..sort();
      return list;
    });
  }

  StockTxRecord _toRecord(StockTransaction tx) {
    return StockTxRecord(
      id: tx.id,
      ticker: tx.ticker,
      side: tx.side,
      lots: tx.lots,
      shares: tx.shares,
      pricePerShare: tx.pricePerShare,
      totalAmount: tx.totalAmount,
      transactionDate: tx.transactionDate,
      createdAt: tx.createdAt,
    );
  }

  Future<PortfolioComponent> _requireLotComponent(String componentId) async {
    final comp = await (_db.select(_db.portfolioComponents)
          ..where((t) => t.id.equals(componentId)))
        .getSingleOrNull();
    if (comp == null) {
      throw StockValidationException('Komponen saham tidak ditemukan.');
    }
    if (comp.mechanism != StockLotCalc.mechanismLotBased) {
      throw StockValidationException(
        'Komponen "${comp.instrumentType}" tidak menggunakan mekanisme lot.',
      );
    }
    return comp;
  }

  Future<StockLedgerComputation> _syncComponentAfterChangeInTx({
    required PortfolioComponent comp,
    required int legacyOpeningAmount,
    required String nowIso,
  }) async {
    final txs = await getTransactionsForComponent(comp.id);
    final ledger = StockLotCalc.computeLedger(txs.map(_toRecord));

    for (final tx in txs) {
      final linked = await (_db.select(_db.contributions)
            ..where((c) => c.stockTransactionId.equals(tx.id)))
          .getSingleOrNull();
      if (linked == null) continue;

      final expectedAmount = tx.side == StockLotCalc.sideBuy
          ? tx.totalAmount
          : -(ledger.sellExitModalByTxId[tx.id] ?? 0);
      final expectedNote = _buildContributionNote(
        side: tx.side,
        ticker: tx.ticker,
        lots: tx.lots,
        pricePerShare: tx.pricePerShare,
        userNote: tx.note,
      );

      if (linked.amount != expectedAmount ||
          linked.date != tx.transactionDate ||
          linked.note != expectedNote) {
        await (_db.update(_db.contributions)
              ..where((c) => c.id.equals(linked.id)))
            .write(
          ContributionsCompanion(
            amount: Value(expectedAmount),
            date: Value(tx.transactionDate),
            note: Value(expectedNote),
            updatedAt: Value(nowIso),
          ),
        );
      }
    }

    final nextActual = StockLotCalc.componentActualAmount(
      totalPositionsModal: ledger.totalPositionsModal,
      legacyOpeningAmount: legacyOpeningAmount,
    );
    await (_db.update(_db.portfolioComponents)
          ..where((c) => c.id.equals(comp.id)))
        .write(
      PortfolioComponentsCompanion(
        actualAmount: Value(nextActual),
        legacyOpeningAmount: Value(legacyOpeningAmount),
        updatedAt: Value(nowIso),
      ),
    );
    return ledger;
  }

  String _buildContributionNote({
    required String side,
    required String ticker,
    required int lots,
    required int pricePerShare,
    String? userNote,
  }) {
    final prefix = side == StockLotCalc.sideBuy
        ? 'Beli $ticker $lots lot @ ${AppFormatters.rupiah(pricePerShare)}'
        : 'Jual $ticker $lots lot';
    final cleanNote = userNote?.trim();
    if (cleanNote != null && cleanNote.isNotEmpty) {
      return '$prefix • $cleanNote';
    }
    return prefix;
  }

  Future<String> buyStock({
    required String componentId,
    required String ticker,
    required int lots,
    required int pricePerShare,
    required DateTime transactionDate,
    String? note,
    DateTime? now,
  }) async {
    final normTicker = StockLotCalc.normalizeTicker(ticker);
    final tickerErr = StockLotCalc.validateTicker(normTicker);
    if (tickerErr != null) throw StockValidationException(tickerErr);
    final lotErr = StockLotCalc.validateLots(lots);
    if (lotErr != null) throw StockValidationException(lotErr);
    final priceErr = StockLotCalc.validatePricePerShare(pricePerShare);
    if (priceErr != null) throw StockValidationException(priceErr);
    final dateErr = StockLotCalc.validateTransactionDate(
      transactionDate,
      now: now,
    );
    if (dateErr != null) throw StockValidationException(dateErr);

    final shares = StockLotCalc.sharesFromLots(lots);
    final totalAmount = StockLotCalc.transactionModal(
      lots: lots,
      pricePerShare: pricePerShare,
    );
    final txId = _uuid.v4();
    final dateIso = AppFormatters.toIsoDate(transactionDate);
    final nowIso = (now ?? DateTime.now()).toUtc().toIso8601String();
    final cleanNote = note?.trim().isEmpty ?? true ? null : note!.trim();

    await _db.transaction(() async {
      final comp = await _requireLotComponent(componentId);
      final ownerId = await _ownerId();

      await _db.into(_db.stockTransactions).insert(
            StockTransactionsCompanion.insert(
              id: txId,
              ownerId: ownerId,
              componentId: comp.id,
              portfolioId: comp.portfolioId,
              ticker: normTicker,
              side: StockLotCalc.sideBuy,
              lots: lots,
              shares: shares,
              pricePerShare: pricePerShare,
              totalAmount: totalAmount,
              transactionDate: dateIso,
              note: Value(cleanNote),
              createdAt: nowIso,
              updatedAt: nowIso,
              syncStatus: const Value('local_only'),
            ),
          );

      await _db.into(_db.contributions).insert(
            ContributionsCompanion.insert(
              id: _uuid.v4(),
              portfolioId: comp.portfolioId,
              ownerId: ownerId,
              amount: totalAmount,
              date: dateIso,
              note: Value(
                _buildContributionNote(
                  side: StockLotCalc.sideBuy,
                  ticker: normTicker,
                  lots: lots,
                  pricePerShare: pricePerShare,
                  userNote: cleanNote,
                ),
              ),
              componentId: Value(comp.id),
              stockTransactionId: Value(txId),
              source: const Value(StockLotCalc.sourceStockBuy),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      await _syncComponentAfterChangeInTx(
        comp: comp,
        legacyOpeningAmount: comp.legacyOpeningAmount,
        nowIso: nowIso,
      );
    });

    return txId;
  }

  Future<({String transactionId, int modalKeluar})> sellStock({
    required String componentId,
    required String ticker,
    required int lots,
    required int pricePerShare,
    required DateTime transactionDate,
    String? note,
    DateTime? now,
  }) async {
    final normTicker = StockLotCalc.normalizeTicker(ticker);
    final tickerErr = StockLotCalc.validateTicker(normTicker);
    if (tickerErr != null) throw StockValidationException(tickerErr);
    final lotErr = StockLotCalc.validateLots(lots);
    if (lotErr != null) throw StockValidationException(lotErr);
    final priceErr = StockLotCalc.validatePricePerShare(pricePerShare);
    if (priceErr != null) throw StockValidationException(priceErr);
    final dateErr = StockLotCalc.validateTransactionDate(
      transactionDate,
      now: now,
    );
    if (dateErr != null) throw StockValidationException(dateErr);

    final shares = StockLotCalc.sharesFromLots(lots);
    final totalAmount = StockLotCalc.transactionModal(
      lots: lots,
      pricePerShare: pricePerShare,
    );
    final txId = _uuid.v4();
    final dateIso = AppFormatters.toIsoDate(transactionDate);
    final nowIso = (now ?? DateTime.now()).toUtc().toIso8601String();
    final cleanNote = note?.trim().isEmpty ?? true ? null : note!.trim();

    var modalKeluar = 0;

    await _db.transaction(() async {
      final comp = await _requireLotComponent(componentId);
      final ownerId = await _ownerId();

      final existingTxs = await getTransactionsForComponent(comp.id);
      final currentLedger = StockLotCalc.computeLedger(
        existingTxs.map(_toRecord),
      );
      final availableLots =
          currentLedger.positionsByTicker[normTicker]?.totalLots ?? 0;
      final sellErr = StockLotCalc.validateSellLots(
        lots: lots,
        availableLots: availableLots,
      );
      if (sellErr != null) throw StockValidationException(sellErr);

      await _db.into(_db.stockTransactions).insert(
            StockTransactionsCompanion.insert(
              id: txId,
              ownerId: ownerId,
              componentId: comp.id,
              portfolioId: comp.portfolioId,
              ticker: normTicker,
              side: StockLotCalc.sideSell,
              lots: lots,
              shares: shares,
              pricePerShare: pricePerShare,
              totalAmount: totalAmount,
              transactionDate: dateIso,
              note: Value(cleanNote),
              createdAt: nowIso,
              updatedAt: nowIso,
              syncStatus: const Value('local_only'),
            ),
          );

      final nextTxs = await getTransactionsForComponent(comp.id);
      final nextLedger = StockLotCalc.computeLedger(nextTxs.map(_toRecord));
      modalKeluar = nextLedger.sellExitModalByTxId[txId] ?? 0;

      await _db.into(_db.contributions).insert(
            ContributionsCompanion.insert(
              id: _uuid.v4(),
              portfolioId: comp.portfolioId,
              ownerId: ownerId,
              amount: -modalKeluar,
              date: dateIso,
              note: Value(
                _buildContributionNote(
                  side: StockLotCalc.sideSell,
                  ticker: normTicker,
                  lots: lots,
                  pricePerShare: pricePerShare,
                  userNote: cleanNote,
                ),
              ),
              componentId: Value(comp.id),
              stockTransactionId: Value(txId),
              source: const Value(StockLotCalc.sourceStockSell),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      await _syncComponentAfterChangeInTx(
        comp: comp,
        legacyOpeningAmount: comp.legacyOpeningAmount,
        nowIso: nowIso,
      );
    });

    return (transactionId: txId, modalKeluar: modalKeluar);
  }

  Future<String> convertLegacyOpeningToLot({
    required String componentId,
    required String ticker,
    required int lots,
    required int pricePerShare,
    required DateTime transactionDate,
    String? note,
    DateTime? now,
  }) async {
    final normTicker = StockLotCalc.normalizeTicker(ticker);
    final tickerErr = StockLotCalc.validateTicker(normTicker);
    if (tickerErr != null) throw StockValidationException(tickerErr);
    final lotErr = StockLotCalc.validateLots(lots);
    if (lotErr != null) throw StockValidationException(lotErr);
    final priceErr = StockLotCalc.validatePricePerShare(pricePerShare);
    if (priceErr != null) throw StockValidationException(priceErr);
    final dateErr = StockLotCalc.validateTransactionDate(
      transactionDate,
      now: now,
    );
    if (dateErr != null) throw StockValidationException(dateErr);

    final shares = StockLotCalc.sharesFromLots(lots);
    final totalAmount = StockLotCalc.transactionModal(
      lots: lots,
      pricePerShare: pricePerShare,
    );
    final txId = _uuid.v4();
    final dateIso = AppFormatters.toIsoDate(transactionDate);
    final nowIso = (now ?? DateTime.now()).toUtc().toIso8601String();
    final cleanNote = note?.trim().isEmpty ?? true ? null : note!.trim();

    await _db.transaction(() async {
      final comp = await _requireLotComponent(componentId);
      if (comp.legacyOpeningAmount <= 0) {
        throw StockValidationException(
          'Tidak ada saldo awal non-lot yang tersisa untuk dirinci.',
        );
      }
      if (totalAmount > comp.legacyOpeningAmount) {
        throw StockValidationException(
          'Total modal rincian (${AppFormatters.rupiah(totalAmount)}) melebihi sisa saldo awal (${AppFormatters.rupiah(comp.legacyOpeningAmount)}).',
        );
      }
      final ownerId = await _ownerId();

      await _db.into(_db.stockTransactions).insert(
            StockTransactionsCompanion.insert(
              id: txId,
              ownerId: ownerId,
              componentId: comp.id,
              portfolioId: comp.portfolioId,
              ticker: normTicker,
              side: StockLotCalc.sideBuy,
              lots: lots,
              shares: shares,
              pricePerShare: pricePerShare,
              totalAmount: totalAmount,
              transactionDate: dateIso,
              note: Value(cleanNote ?? 'Rincian saldo awal'),
              createdAt: nowIso,
              updatedAt: nowIso,
              syncStatus: const Value('local_only'),
            ),
          );

      final nextLegacy = comp.legacyOpeningAmount - totalAmount;
      await _syncComponentAfterChangeInTx(
        comp: comp,
        legacyOpeningAmount: nextLegacy,
        nowIso: nowIso,
      );
    });

    return txId;
  }

  Future<void> updateStockTransaction({
    required String transactionId,
    required String ticker,
    required int lots,
    required int pricePerShare,
    required DateTime transactionDate,
    String? note,
    DateTime? now,
  }) async {
    final normTicker = StockLotCalc.normalizeTicker(ticker);
    final tickerErr = StockLotCalc.validateTicker(normTicker);
    if (tickerErr != null) throw StockValidationException(tickerErr);
    final lotErr = StockLotCalc.validateLots(lots);
    if (lotErr != null) throw StockValidationException(lotErr);
    final priceErr = StockLotCalc.validatePricePerShare(pricePerShare);
    if (priceErr != null) throw StockValidationException(priceErr);
    final dateErr = StockLotCalc.validateTransactionDate(
      transactionDate,
      now: now,
    );
    if (dateErr != null) throw StockValidationException(dateErr);

    final shares = StockLotCalc.sharesFromLots(lots);
    final totalAmount = StockLotCalc.transactionModal(
      lots: lots,
      pricePerShare: pricePerShare,
    );
    final dateIso = AppFormatters.toIsoDate(transactionDate);
    final nowIso = (now ?? DateTime.now()).toUtc().toIso8601String();
    final cleanNote = note?.trim().isEmpty ?? true ? null : note!.trim();

    await _db.transaction(() async {
      final existing = await (_db.select(_db.stockTransactions)
            ..where((t) => t.id.equals(transactionId)))
          .getSingleOrNull();
      if (existing == null) {
        throw StockValidationException('Transaksi saham tidak ditemukan.');
      }
      final comp = await _requireLotComponent(existing.componentId);
      final allTxs = await getTransactionsForComponent(comp.id);

      final candidateRecords = allTxs.map((t) {
        if (t.id == transactionId) {
          return StockTxRecord(
            id: t.id,
            ticker: normTicker,
            side: t.side,
            lots: lots,
            shares: shares,
            pricePerShare: pricePerShare,
            totalAmount: totalAmount,
            transactionDate: dateIso,
            createdAt: t.createdAt,
          );
        }
        return _toRecord(t);
      }).toList();

      StockLotCalc.computeLedger(candidateRecords);

      await (_db.update(_db.stockTransactions)
            ..where((t) => t.id.equals(transactionId)))
          .write(
        StockTransactionsCompanion(
          ticker: Value(normTicker),
          lots: Value(lots),
          shares: Value(shares),
          pricePerShare: Value(pricePerShare),
          totalAmount: Value(totalAmount),
          transactionDate: Value(dateIso),
          note: Value(cleanNote),
          updatedAt: Value(nowIso),
        ),
      );

      await _syncComponentAfterChangeInTx(
        comp: comp,
        legacyOpeningAmount: comp.legacyOpeningAmount,
        nowIso: nowIso,
      );
    });
  }

  Future<void> deleteStockTransaction(
    String transactionId, {
    DateTime? now,
  }) async {
    final nowIso = (now ?? DateTime.now()).toUtc().toIso8601String();

    await _db.transaction(() async {
      final existing = await (_db.select(_db.stockTransactions)
            ..where((t) => t.id.equals(transactionId)))
          .getSingleOrNull();
      if (existing == null) return;

      final comp = await _requireLotComponent(existing.componentId);
      final allTxs = await getTransactionsForComponent(comp.id);
      final remaining = allTxs.where((t) => t.id != transactionId).toList();

      StockLotCalc.computeLedger(remaining.map(_toRecord));

      await (_db.delete(_db.contributions)
            ..where((c) => c.stockTransactionId.equals(transactionId)))
          .go();

      await (_db.delete(_db.stockTransactions)
            ..where((t) => t.id.equals(transactionId)))
          .go();

      await _syncComponentAfterChangeInTx(
        comp: comp,
        legacyOpeningAmount: comp.legacyOpeningAmount,
        nowIso: nowIso,
      );
    });
  }
}

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  return StockRepository(ref.watch(appDatabaseProvider));
});
