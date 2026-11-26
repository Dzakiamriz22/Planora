import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/stock_repository.dart';
import 'package:planora/features/home/home_screen.dart';
import 'package:planora/features/portfolios/portfolio_detail_screen.dart';
import 'package:planora/features/portfolios/stock_transaction_sheets.dart';

Future<void> _disposeDbAfterWidgetTest(
  WidgetTester tester,
  AppDatabase db,
) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 50));
  await db.close();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Bab 10.4 — Widget test mekanisme saham lot v2.3', () {
    testWidgets(
      'Form Beli: ubah lot 1 -> 10 perbarui lembar 1.000 & total modal, tombol Simpan aktif/nonaktif',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const Scaffold(
                body: BuyStockSheet(componentId: 'comp_1'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Awal: kode kosong & harga kosong -> Simpan nonaktif
        FilledButton saveBtn = tester.widget(
          find.byKey(const Key('stock_save_button')),
        );
        expect(saveBtn.onPressed, isNull);

        // Isi kode, lot = 10, harga = 2000
        await tester.enterText(
          find.byKey(const Key('stock_ticker_field')),
          'adro',
        );
        await tester.enterText(
          find.byKey(const Key('stock_lot_field')),
          '10',
        );
        await tester.enterText(
          find.byKey(const Key('stock_price_field')),
          '2000',
        );
        await tester.pump();

        expect(find.text('1.000 lembar'), findsOneWidget);
        expect(
          find.textContaining('10 lot × 100 × Rp 2.000 = Rp 2.000.000'),
          findsOneWidget,
        );
        saveBtn = tester.widget(find.byKey(const Key('stock_save_button')));
        expect(saveBtn.onPressed, isNotNull);

        // Lot kosong -> Simpan nonaktif
        await tester.enterText(find.byKey(const Key('stock_lot_field')), '');
        await tester.pump();
        saveBtn = tester.widget(find.byKey(const Key('stock_save_button')));
        expect(saveBtn.onPressed, isNull);

        // Kembalikan lot valid, harga 0 -> Simpan nonaktif
        await tester.enterText(find.byKey(const Key('stock_lot_field')), '5');
        await tester.enterText(find.byKey(const Key('stock_price_field')), '0');
        await tester.pump();
        saveBtn = tester.widget(find.byKey(const Key('stock_save_button')));
        expect(saveBtn.onPressed, isNull);

        await _disposeDbAfterWidgetTest(tester, db);
      },
    );

    testWidgets(
      'Form Jual: lot melebihi posisi menampilkan penolakan & Simpan nonaktif',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();

        const position = StockPosition(
          ticker: 'ADRO',
          totalLots: 10,
          totalShares: 1000,
          totalModal: 2000000,
          averagePrice: 2000.0,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const Scaffold(
                body: SellStockSheet(
                  componentId: 'comp_1',
                  position: position,
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('sell_price_field')),
          '2500',
        );
        await tester.enterText(
          find.byKey(const Key('sell_lot_field')),
          '11',
        );
        await tester.pump();

        expect(find.textContaining('tersedia 10 lot'), findsOneWidget);
        final saveBtn = tester.widget<FilledButton>(
          find.byKey(const Key('sell_save_button')),
        );
        expect(saveBtn.onPressed, isNull);

        await _disposeDbAfterWidgetTest(tester, db);
      },
    );

    testWidgets(
      'Detail Porto: perluas komponen Saham tampilkan posisi per kode & baris saldo awal hanya bila > 0',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();

        final portoRepo = PortfolioRepository(db);
        final stockRepo = StockRepository(db);

        final pid = await portoRepo.createPortfolio(
          name: 'Porto Uji Detail',
          category: 'cash',
          savedTarget: 10000000,
          monthlyPlan: 500000,
          annualReturnPct: 8,
          icon: 'savings',
          color: 0xFF0E7C66,
          initialComponents: const [
            ComponentDraft(instrumentType: 'Saham langsung', targetPercent: 100),
          ],
        );
        final comp = (await db.select(db.portfolioComponents).get())
            .firstWhere((c) => c.portfolioId == pid);

        // Set legacyOpeningAmount = 40.000 + beli ADRO 2 lot
        await (db.update(db.portfolioComponents)
              ..where((t) => t.id.equals(comp.id)))
            .write(
          const PortfolioComponentsCompanion(
            legacyOpeningAmount: drift.Value(40000),
            actualAmount: drift.Value(40000),
          ),
        );
        await stockRepo.buyStock(
          componentId: comp.id,
          ticker: 'ADRO',
          lots: 2,
          pricePerShare: 2000,
          transactionDate: DateTime(2026, 1, 10),
          now: DateTime(2026, 1, 15),
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: PortfolioDetailScreen(portfolioId: pid),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final toggleFinder = find.byKey(Key('stock_component_toggle_${comp.id}'));
        await tester.scrollUntilVisible(
          toggleFinder,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.ensureVisible(toggleFinder);
        await tester.pumpAndSettle();
        await tester.tap(toggleFinder);
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('legacy_opening_row')), findsOneWidget);
        expect(find.text('Saldo awal (belum dirinci per lot)'), findsOneWidget);
        expect(find.text('ADRO'), findsWidgets);

        // Tutup kembali tidak mengubah data
        await tester.tap(toggleFinder);
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('legacy_opening_row')), findsNothing);
        final compsAfterCollapse = await db.select(db.portfolioComponents).get();
        expect(compsAfterCollapse.single.actualAmount, 440000);

        // Kosongkan legacyOpeningAmount -> baris saldo awal tidak tampil saat diperluas
        await (db.update(db.portfolioComponents)
              ..where((t) => t.id.equals(comp.id)))
            .write(
          const PortfolioComponentsCompanion(
            legacyOpeningAmount: drift.Value(0),
            actualAmount: drift.Value(400000),
          ),
        );
        await tester.tap(toggleFinder);
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('legacy_opening_row')), findsNothing);

        await _disposeDbAfterWidgetTest(tester, db);
      },
    );

    testWidgets(
      'Beranda keadaan kosong mode gelap tanpa kode saham contoh',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.dark(),
              home: const HomeScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Belum ada portofolio'), findsOneWidget);
        expect(find.textContaining('ADRO'), findsNothing);
        expect(find.textContaining('BBCA'), findsNothing);
        expect(find.textContaining('BBRI'), findsNothing);

        await _disposeDbAfterWidgetTest(tester, db);
      },
    );
  });
}
