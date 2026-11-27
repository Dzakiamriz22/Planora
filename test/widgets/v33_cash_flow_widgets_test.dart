import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/calc/cash_flow_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:planora/data/repositories/cash_flow_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/features/cashflow/cash_flow_screen.dart';
import 'package:planora/widgets/planora_widgets.dart';

Future<void> _disposeDb(WidgetTester tester, AppDatabase db) async {
  AppFormatters.hideAmounts = false;
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 50));
  await db.close();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  tearDown(() {
    AppFormatters.hideAmounts = false;
  });

  group('v3.3 — Widget Test Arus Kas, 5 Tab, Mode Privasi, & 500 Transaksi', () {
    testWidgets('BottomNav menampilkan 5 tab termasuk Arus Kas', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            bottomNavigationBar: PlanoraBottomNavBar(
              currentIndex: 3,
              onTap: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Porto'), findsOneWidget);
      expect(find.text('Plan'), findsOneWidget);
      expect(find.text('Arus Kas'), findsOneWidget);
      expect(find.text('Pengaturan'), findsOneWidget);
    });

    testWidgets(
      'Entri cepat Arus Kas: kategori terpisah per jenis, budget kosong tampilkan tombol Pengaturan, & Mode Privasi menyamarkan nominal',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const CashFlowScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Profil kosong -> muncul tombol Atur di Pengaturan
        expect(
          find.byKey(const Key('cashflow_setup_budget_button')),
          findsOneWidget,
        );

        // Ketukan 1: buka bottom sheet Catat
        await tester.tap(find.byKey(const Key('cashflow_fab_add')));
        await tester.pumpAndSettle();

        // Mode Pengeluaran: kategori pengeluaran tampil, kategori pemasukan (Gaji) tidak tampil
        expect(find.text('Makan & Minum'), findsOneWidget);
        expect(find.text('Gaji'), findsNothing);

        // Ketukan 2: isi nominal & langsung Simpan (kategori default terpilih otomatis)
        await tester.enterText(
          find.byKey(const Key('cashflow_amount_field')),
          '75000',
        );
        final saveBtn = find.byKey(const Key('cashflow_save_button'));
        await tester.ensureVisible(saveBtn);
        await tester.pumpAndSettle();
        await tester.tap(saveBtn);
        await tester.pumpAndSettle();

        expect(find.text('Rp 75.000'), findsWidgets);

        // Aktifkan Mode Privasi -> nominal di Arus Kas tersamarkan
        await SettingsRepository(db).setHideAmounts(true);
        await tester.pumpAndSettle();

        expect(find.text(AppFormatters.maskedRupiah), findsWidgets);
        expect(find.text('Rp 75.000'), findsNothing);

        await _disposeDb(tester, db);
      },
    );

    testWidgets('500 transaksi arus kas ter-render mulus di CashFlowScreen', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      await db.ensureInitialized();

      final cfRepo = CashFlowRepository(db);
      final cats = await db.select(db.cashFlowCategories).get();
      final expCat =
          cats.firstWhere((c) => c.type == CashFlowCalc.typeExpense);
      final now = DateTime.now();

      for (var i = 0; i < 500; i++) {
        final day = (i % 20) + 1;
        final dt = DateTime(now.year, now.month, day > now.day ? now.day : day);
        await cfRepo.addTransaction(
          type: CashFlowCalc.typeExpense,
          amount: 10000,
          categoryId: expCat.id,
          transactionDate: dt,
          now: now,
        );
      }

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const CashFlowScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Total 500 x 10.000 = Rp 5.000.000 tampil mulus
      expect(find.text('Rp 5.000.000'), findsWidgets);

      await _disposeDb(tester, db);
    });
  });
}
