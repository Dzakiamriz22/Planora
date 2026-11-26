import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/data/repositories/stock_repository.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Bab 10.1 — Unit test perhitungan lot (L-01..L-11)', () {
    test('L-01: Beli 10 lot pada Rp 2.000 -> 1.000 lembar, modal Rp 2.000.000', () {
      expect(StockLotCalc.sharesFromLots(10), 1000);
      expect(
        StockLotCalc.transactionModal(lots: 10, pricePerShare: 2000),
        2000000,
      );
    });

    test('L-02: Beli 1 lot pada Rp 350 -> 100 lembar, modal Rp 35.000', () {
      expect(StockLotCalc.sharesFromLots(1), 100);
      expect(
        StockLotCalc.transactionModal(lots: 1, pricePerShare: 350),
        35000,
      );
    });

    test('L-03: Dua beli satu kode (10 lot @ 2.000 + 5 lot @ 2.400)', () {
      final ledger = StockLotCalc.computeLedger([
        const StockTxRecord(
          id: 'tx1',
          ticker: 'ADRO',
          side: 'buy',
          lots: 10,
          shares: 1000,
          pricePerShare: 2000,
          totalAmount: 2000000,
          transactionDate: '2026-01-10',
          createdAt: '2026-01-10T01:00:00Z',
        ),
        const StockTxRecord(
          id: 'tx2',
          ticker: 'ADRO',
          side: 'buy',
          lots: 5,
          shares: 500,
          pricePerShare: 2400,
          totalAmount: 1200000,
          transactionDate: '2026-01-15',
          createdAt: '2026-01-15T01:00:00Z',
        ),
      ]);

      final pos = ledger.positionsByTicker['ADRO']!;
      expect(pos.totalLots, 15);
      expect(pos.totalShares, 1500);
      expect(pos.totalModal, 3200000);
      expect(pos.averagePrice, closeTo(2133.33, 0.001));
    });

    test('L-04 & L-05: Jual 5 lot dari L-03 (biaya rata-rata & tanpa selisih)', () {
      final ledger = StockLotCalc.computeLedger([
        const StockTxRecord(
          id: 'tx1',
          ticker: 'ADRO',
          side: 'buy',
          lots: 10,
          shares: 1000,
          pricePerShare: 2000,
          totalAmount: 2000000,
          transactionDate: '2026-01-10',
          createdAt: '2026-01-10T01:00:00Z',
        ),
        const StockTxRecord(
          id: 'tx2',
          ticker: 'ADRO',
          side: 'buy',
          lots: 5,
          shares: 500,
          pricePerShare: 2400,
          totalAmount: 1200000,
          transactionDate: '2026-01-15',
          createdAt: '2026-01-15T01:00:00Z',
        ),
        const StockTxRecord(
          id: 'tx3',
          ticker: 'ADRO',
          side: 'sell',
          lots: 5,
          shares: 500,
          pricePerShare: 2600,
          totalAmount: 1300000,
          transactionDate: '2026-01-20',
          createdAt: '2026-01-20T01:00:00Z',
        ),
      ]);

      final modalKeluar = ledger.sellExitModalByTxId['tx3']!;
      final pos = ledger.positionsByTicker['ADRO']!;

      expect(modalKeluar, 1066667);
      expect(pos.totalLots, 10);
      expect(pos.totalShares, 1000);
      expect(pos.totalModal, 2133333);
      expect(pos.averagePrice, closeTo(2133.33, 0.001));
      expect(modalKeluar + pos.totalModal, 3200000);
    });

    test('L-06: Jual seluruh lot -> posisi tertutup 0 tanpa NaN', () {
      final ledger = StockLotCalc.computeLedger([
        const StockTxRecord(
          id: 'tx1',
          ticker: 'BBCA',
          side: 'buy',
          lots: 10,
          shares: 1000,
          pricePerShare: 9000,
          totalAmount: 9000000,
          transactionDate: '2026-01-10',
          createdAt: '2026-01-10T01:00:00Z',
        ),
        const StockTxRecord(
          id: 'tx2',
          ticker: 'BBCA',
          side: 'sell',
          lots: 10,
          shares: 1000,
          pricePerShare: 9500,
          totalAmount: 9500000,
          transactionDate: '2026-02-01',
          createdAt: '2026-02-01T01:00:00Z',
        ),
      ]);

      final pos = ledger.positionsByTicker['BBCA']!;
      expect(pos.totalLots, 0);
      expect(pos.totalShares, 0);
      expect(pos.totalModal, 0);
      expect(pos.averagePrice, 0.0);
      expect(pos.averagePrice.isNaN, isFalse);
      expect(ledger.activePositions, isEmpty);
      expect(ledger.sellExitModalByTxId['tx2'], 9000000);
    });

    test('L-07: Dua kode dalam satu komponen -> actual_amount & persen dalam saham', () {
      final ledger = StockLotCalc.computeLedger([
        const StockTxRecord(
          id: 'tx1',
          ticker: 'ADRO',
          side: 'buy',
          lots: 16,
          shares: 1600,
          pricePerShare: 2000,
          totalAmount: 3200000,
          transactionDate: '2026-01-10',
          createdAt: '2026-01-10T01:00:00Z',
        ),
        const StockTxRecord(
          id: 'tx2',
          ticker: 'TLKM',
          side: 'buy',
          lots: 2,
          shares: 200,
          pricePerShare: 4000,
          totalAmount: 800000,
          transactionDate: '2026-01-11',
          createdAt: '2026-01-11T01:00:00Z',
        ),
      ]);

      final compActual = StockLotCalc.componentActualAmount(
        totalPositionsModal: ledger.totalPositionsModal,
        legacyOpeningAmount: 0,
      );
      expect(compActual, 4000000);
      expect(
        StockLotCalc.percentWithinStockComponent(
          tickerModal: ledger.positionsByTicker['ADRO']!.totalModal,
          stockComponentActual: compActual,
        ),
        80.0,
      );
      expect(
        StockLotCalc.percentWithinStockComponent(
          tickerModal: ledger.positionsByTicker['TLKM']!.totalModal,
          stockComponentActual: compActual,
        ),
        20.0,
      );
    });

    test('L-08: actual_percent komponen saham 4jt dari porto 10jt = 40%', () {
      expect(
        PlanoraV22Calc.actualPercent(
          actualAmount: 4000000,
          totalActualPortfolio: 10000000,
        ),
        40.0,
      );
    });

    test('L-09: target_amount komponen saham 10% dari Rp 140jt = Rp 14jt', () {
      expect(
        PlanoraV22Calc.targetAmountFromPercent(
          targetPercent: 10.0,
          portfolioTargetTotal: 140000000,
        ),
        14000000,
      );
    });

    test('L-10 & L-11: Hapus beli pertama & edit harga beli ubah posisi + setoran', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final portoRepo = PortfolioRepository(db);
      final stockRepo = StockRepository(db);

      final pid = await portoRepo.createPortfolio(
        name: 'Porto Saham',
        category: 'cash',
        savedTarget: 100000000,
        monthlyPlan: 0,
        annualReturnPct: 10,
        icon: 'savings',
        color: 0xFF0E7C66,
        initialComponents: const [
          ComponentDraft(instrumentType: 'Saham langsung', targetPercent: 100),
        ],
      );
      final comp = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.portfolioId == pid);

      final tx1 = await stockRepo.buyStock(
        componentId: comp.id,
        ticker: 'ADRO',
        lots: 10,
        pricePerShare: 2000,
        transactionDate: DateTime(2026, 1, 10),
        now: DateTime(2026, 1, 20),
      );
      final tx2 = await stockRepo.buyStock(
        componentId: comp.id,
        ticker: 'ADRO',
        lots: 5,
        pricePerShare: 2400,
        transactionDate: DateTime(2026, 1, 15),
        now: DateTime(2026, 1, 20),
      );

      // L-11: Edit harga beli tx2 dari 2.400 ke 2.600 -> modal 1.300.000
      await stockRepo.updateStockTransaction(
        transactionId: tx2,
        ticker: 'ADRO',
        lots: 5,
        pricePerShare: 2600,
        transactionDate: DateTime(2026, 1, 15),
        now: DateTime(2026, 1, 20),
      );

      var updatedComp = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.id == comp.id);
      var linkedContrib = (await db.select(db.contributions).get())
          .firstWhere((c) => c.stockTransactionId == tx2);
      expect(updatedComp.actualAmount, 3300000);
      expect(linkedContrib.amount, 1300000);

      // L-10: Hapus transaksi beli pertama -> sisa hanya tx2 (5 lot @ 2.600 = 1.300.000)
      await stockRepo.deleteStockTransaction(tx1, now: DateTime(2026, 1, 20));
      updatedComp = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.id == comp.id);
      final remainingTxs = await stockRepo.getTransactionsForComponent(comp.id);
      final ledger = StockLotCalc.computeLedger(
        remainingTxs.map(
          (t) => StockTxRecord(
            id: t.id,
            ticker: t.ticker,
            side: t.side,
            lots: t.lots,
            shares: t.shares,
            pricePerShare: t.pricePerShare,
            totalAmount: t.totalAmount,
            transactionDate: t.transactionDate,
            createdAt: t.createdAt,
          ),
        ),
      );
      expect(updatedComp.actualAmount, 1300000);
      expect(ledger.positionsByTicker['ADRO']!.totalLots, 5);
      expect(ledger.positionsByTicker['ADRO']!.averagePrice, 2600.0);
    });
  });

  group('Bab 10.2 — Unit test validasi (V-01..V-08)', () {
    test('V-01: Lot 0, negatif, desimal ditolak', () {
      expect(StockLotCalc.validateLotsText(''), isNotNull);
      expect(StockLotCalc.validateLotsText('0'), isNotNull);
      expect(StockLotCalc.validateLotsText('-3'), isNotNull);
      expect(StockLotCalc.validateLotsText('1,5'), isNotNull);
      expect(StockLotCalc.validateLotsText('1.5'), isNotNull);
      expect(StockLotCalc.validateLotsText('1'), isNull);
    });

    test('V-02: Harga per lembar 0 atau negatif ditolak', () {
      expect(StockLotCalc.validatePricePerShare(0), isNotNull);
      expect(StockLotCalc.validatePricePerShare(-500), isNotNull);
      expect(StockLotCalc.validatePricePerShare(null), isNotNull);
      expect(StockLotCalc.validatePricePerShare(50), isNull);
    });

    test('V-03: Kode huruf kecil otomatis kapital saat disimpan', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final portoRepo = PortfolioRepository(db);
      final stockRepo = StockRepository(db);

      final pid = await portoRepo.createPortfolio(
        name: 'Test Kapital',
        category: 'no_target',
        monthlyPlan: 0,
        annualReturnPct: 10,
        icon: 'savings',
        color: 0xFF0E7C66,
        initialComponents: const [
          ComponentDraft(instrumentType: 'Saham langsung', targetPercent: 100),
        ],
      );
      final comp = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.portfolioId == pid);

      await stockRepo.buyStock(
        componentId: comp.id,
        ticker: 'adro',
        lots: 1,
        pricePerShare: 2000,
        transactionDate: DateTime(2026, 1, 10),
        now: DateTime(2026, 1, 10),
      );

      final txs = await stockRepo.getTransactionsForComponent(comp.id);
      expect(txs.single.ticker, 'ADRO');
    });

    test('V-04: Kode 3 karakter, 5 karakter, atau berisi simbol ditolak', () {
      expect(StockLotCalc.validateTicker('ADR'), isNotNull);
      expect(StockLotCalc.validateTicker('ADROO'), isNotNull);
      expect(StockLotCalc.validateTicker('AD-O'), isNotNull);
      expect(StockLotCalc.validateTicker('AD O'), isNotNull);
      expect(StockLotCalc.validateTicker('ADRO'), isNull);
      expect(StockLotCalc.validateTicker('bbca'), isNull);
    });

    test('V-05: Jual 11 lot dari posisi 10 lot ditolak dengan info lot tersedia', () {
      final err = StockLotCalc.validateSellLots(lots: 11, availableLots: 10);
      expect(err, isNotNull);
      expect(err, contains('10'));
    });

    test('V-06: Tanggal transaksi besok ditolak', () {
      final now = DateTime(2026, 5, 10);
      final tomorrow = DateTime(2026, 5, 11);
      expect(StockLotCalc.validateTransactionDate(tomorrow, now: now), isNotNull);
      expect(StockLotCalc.validateTransactionDate(now, now: now), isNull);
    });

    test('V-07: Mengganti instrumen komponen yang punya transaksi lot ditolak', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final portoRepo = PortfolioRepository(db);
      final stockRepo = StockRepository(db);

      final pid = await portoRepo.createPortfolio(
        name: 'Test Lock',
        category: 'no_target',
        monthlyPlan: 0,
        annualReturnPct: 10,
        icon: 'savings',
        color: 0xFF0E7C66,
        initialComponents: const [
          ComponentDraft(instrumentType: 'Saham langsung', targetPercent: 100),
        ],
      );
      final comp = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.portfolioId == pid);

      await stockRepo.buyStock(
        componentId: comp.id,
        ticker: 'BBCA',
        lots: 1,
        pricePerShare: 9000,
        transactionDate: DateTime(2026, 1, 10),
        now: DateTime(2026, 1, 10),
      );

      await expectLater(
        () => portoRepo.replacePortfolioComponents(
          portfolioId: pid,
          drafts: [
            ComponentDraft(
              id: comp.id,
              instrumentType: 'RD Saham',
              targetPercent: 100,
            ),
          ],
        ),
        throwsA(isA<ComponentLimitException>()),
      );
    });

    test('V-08: Impor transaksi dengan snapshot shares/total_amount salah ditolak', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();
      final settingsRepo = SettingsRepository(db);

      final badJson = jsonEncode({
        'app': 'planora',
        'schema_version': 5,
        'profile': {'id': 'u1'},
        'settings': {'onboarding_done': true},
        'portfolios': [
          {
            'id': 'p1',
            'name': 'Porto Uji',
            'category': 'no_target',
            'components': [
              {
                'id': 'c1',
                'instrument_type': 'Saham langsung',
                'target_percent': 100,
                'actual_amount': 2000000,
                'mechanism': 'lot_based',
                'legacy_opening_amount': 0,
              }
            ],
            'contributions': [],
          }
        ],
        'stock_transactions': [
          {
            'id': 'tx1',
            'component_id': 'c1',
            'portfolio_id': 'p1',
            'ticker': 'ADRO',
            'side': 'buy',
            'lots': 10,
            'shares': 999, // salah, harus 1000
            'price_per_share': 2000,
            'total_amount': 2000000,
            'transaction_date': '2026-01-10',
          }
        ],
      });

      await expectLater(
        () => settingsRepo.importAllFromJson(badJson),
        throwsA(isA<StockValidationException>()),
      );
    });
  });

  group('Bab 10.5 — Skenario angka ujung ke ujung', () {
    test('Skenario 1: Pasar Uang 20%, Obligasi 70%, Saham 10% + 2x beli + jual 5 lot', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final portoRepo = PortfolioRepository(db);
      final stockRepo = StockRepository(db);

      final pid = await portoRepo.createPortfolio(
        name: 'Rumah Impian',
        category: 'cash',
        savedTarget: 140000000,
        monthlyPlan: 2000000,
        annualReturnPct: 7,
        icon: 'home',
        color: 0xFF0E7C66,
        initialComponents: const [
          ComponentDraft(instrumentType: 'RDPU', targetPercent: 20),
          ComponentDraft(instrumentType: 'RD Obligasi', targetPercent: 70),
          ComponentDraft(instrumentType: 'Saham langsung', targetPercent: 10),
        ],
      );

      final comps = await db.select(db.portfolioComponents).get();
      final rdpu = comps.firstWhere((c) => c.instrumentType == 'RDPU');
      final obli = comps.firstWhere((c) => c.instrumentType == 'RD Obligasi');
      final saham =
          comps.firstWhere((c) => c.instrumentType == 'Saham langsung');

      await portoRepo.addContribution(
        portfolioId: pid,
        amount: 80000,
        dateIso: '2026-01-05',
        componentId: rdpu.id,
      );
      await portoRepo.addContribution(
        portfolioId: pid,
        amount: 280000,
        dateIso: '2026-01-05',
        componentId: obli.id,
      );

      await stockRepo.buyStock(
        componentId: saham.id,
        ticker: 'ADRO',
        lots: 10,
        pricePerShare: 2000,
        transactionDate: DateTime(2026, 1, 10),
        now: DateTime(2026, 1, 25),
      );
      await stockRepo.buyStock(
        componentId: saham.id,
        ticker: 'ADRO',
        lots: 5,
        pricePerShare: 2400,
        transactionDate: DateTime(2026, 1, 15),
        now: DateTime(2026, 1, 25),
      );

      final sahamAfterBuy = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.id == saham.id);
      final contribsAfterBuy = await db.select(db.contributions).get();
      final totalPortoAfterBuy =
          contribsAfterBuy.fold<int>(0, (s, c) => s + c.amount);

      expect(sahamAfterBuy.actualAmount, 3200000);
      expect(totalPortoAfterBuy, 3560000);
      expect(
        contribsAfterBuy.where((c) => c.source == StockLotCalc.sourceStockBuy).length,
        2,
      );

      // Jual ADRO 5 lot
      final sellRes = await stockRepo.sellStock(
        componentId: saham.id,
        ticker: 'ADRO',
        lots: 5,
        pricePerShare: 2500,
        transactionDate: DateTime(2026, 1, 20),
        now: DateTime(2026, 1, 25),
      );

      expect(sellRes.modalKeluar, 1066667);

      final sahamAfterSell = (await db.select(db.portfolioComponents).get())
          .firstWhere((c) => c.id == saham.id);
      final contribsAfterSell = await db.select(db.contributions).get();
      final totalPortoAfterSell =
          contribsAfterSell.fold<int>(0, (s, c) => s + c.amount);

      expect(sahamAfterSell.actualAmount, 2133333);
      expect(totalPortoAfterSell, 3560000 - 1066667);
    });
  });
}
