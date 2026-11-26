import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/notifications/reminder_service.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/plans/plan_form_screen.dart';
import 'package:planora/features/plans/plans_screen.dart';
import 'package:planora/features/portfolios/portfolio_form_screen.dart';
import 'package:planora/widgets/component_allocation_editor.dart';

class _SilentGateway implements NotificationGateway {
  @override
  Future<bool> areNotificationsEnabled() async => true;
  @override
  Future<void> cancel(int id) async {}
  @override
  Future<void> initialize() async {}
  @override
  Future<bool> openSystemNotificationSettings() async => true;
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {}
  @override
  Future<void> scheduleMonthly({
    required int id,
    required String title,
    required String body,
    required int dayOfMonth,
    required int hour,
    required int minute,
  }) async {}
  @override
  Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
  }) async {}
}

Future<void> _disposeDb(WidgetTester tester, AppDatabase db) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 50));
  await db.close();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Audit UX Input & Interaksi Form', () {
    testWidgets(
      'PlanFormScreen: field persen dapat diketik bebas (hapus kosong & desimal tidak ditimpa)',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();
        final portoRepo = PortfolioRepository(db);
        await portoRepo.createPortfolio(
          name: 'Rumah',
          category: 'cash',
          savedTarget: 100000000,
          monthlyPlan: 0,
          annualReturnPct: 5,
          icon: 'home',
          color: 0xFF0E7C66,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PlanFormScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Cari TextField persen pada baris porto (bukan TextFormField nama/catatan/total)
        final rowFieldFinder = find.descendant(
          of: find.byType(ListView),
          matching: find.byWidgetPredicate(
            (w) => w is TextField && w.decoration?.suffixText == '%',
          ),
        );
        await tester.scrollUntilVisible(
          rowFieldFinder,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.tap(rowFieldFinder);
        await tester.pump();

        // Ketik desimal "33." -> tidak boleh langsung ditimpa jadi "33"
        await tester.enterText(rowFieldFinder, '33.');
        await tester.pump();
        final tf1 = tester.widget<TextField>(rowFieldFinder);
        expect(tf1.controller!.text, '33.');

        // Hapus sampai kosong -> tidak boleh langsung ditimpa balik jadi "0"
        await tester.enterText(rowFieldFinder, '');
        await tester.pump();
        final tf2 = tester.widget<TextField>(rowFieldFinder);
        expect(tf2.controller!.text, '');

        // Ketik "65" -> tetap "65"
        await tester.enterText(rowFieldFinder, '65');
        await tester.pump();
        final tf3 = tester.widget<TextField>(rowFieldFinder);
        expect(tf3.controller!.text, '65');

        await _disposeDb(tester, db);
      },
    );

    testWidgets(
      'ComponentAllocationEditor: tambah instrumen custom (Lainnya) & ketik persen bebas',
      (tester) async {
        var rows = [
          EditableComponentRow(
            key: 'k1',
            instrumentType: 'RDPU',
            targetPercent: 60,
          ),
        ];
        var mode = 'percent';

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) => SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ComponentAllocationEditor(
                    rows: rows,
                    portfolioTargetTotal: 10000000,
                    inputMode: mode,
                    onRowsChanged: (next) => setState(() => rows = next),
                    onInputModeChanged: (m) => setState(() => mode = m),
                  ),
                ),
              ),
            ),
          ),
        );

        // Tambah instrumen custom lewat "Lainnya"
        await tester.tap(find.text('Tambah'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Lainnya'));
        await tester.pumpAndSettle();

        // Tekan Tambahkan saat kosong -> muncul error inline
        await tester.tap(find.text('Tambahkan'));
        await tester.pumpAndSettle();
        expect(find.text('Masukkan nama instrumen.'), findsOneWidget);

        // Ketik nama custom lalu tambahkan
        await tester.enterText(
          find.byType(TextField).last,
          'SBN Ritel',
        );
        await tester.tap(find.text('Tambahkan'));
        await tester.pumpAndSettle();

        expect(find.text('SBN Ritel'), findsOneWidget);
        expect(rows.length, 2);
        expect(rows.last.instrumentType, 'SBN Ritel');

        // Ketik 40 di baris custom -> total jadi 100% pas
        final percentFields = find.byWidgetPredicate(
          (w) => w is TextField && w.decoration?.suffixText == '%',
        );
        await tester.tap(percentFields.last);
        await tester.pump();
        await tester.enterText(percentFields.last, '40');
        await tester.pump();
        expect(find.text('Total 100% — pas'), findsOneWidget);
      },
    );

    testWidgets(
      'PortfolioFormScreen baru: default komponen 100% & tombol Simpan Portofolio langsung aktif',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PortfolioFormScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final saveBtn = tester.widget<FilledButton>(
          find.widgetWithText(FilledButton, 'Simpan Portofolio'),
        );
        expect(saveBtn.onPressed, isNotNull);

        await _disposeDb(tester, db);
      },
    );

    testWidgets(
      'PlansScreen: Plan aktif dapat dinonaktifkan langsung',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();
        final portoRepo = PortfolioRepository(db);
        final planRepo = PlanRepository(db);

        final pid = await portoRepo.createPortfolio(
          name: 'Dana Darurat',
          category: 'cash',
          savedTarget: 20000000,
          monthlyPlan: 0,
          annualReturnPct: 4,
          icon: 'shield',
          color: 0xFF0E7C66,
        );
        final planId = await planRepo.savePlan(
          name: 'Plan Utama',
          totalAmount: 2000000,
          sharePercentX100ByPortfolioId: {pid: 10000},
        );
        await planRepo.applyPlan(planId);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appDatabaseProvider.overrideWithValue(db),
              notificationGatewayProvider.overrideWithValue(_SilentGateway()),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PlansScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Aktif'), findsOneWidget);
        expect(find.text('Nonaktifkan'), findsOneWidget);

        await tester.tap(find.text('Nonaktifkan'));
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(FilledButton, 'Nonaktifkan'));
        await tester.pumpAndSettle();

        expect(find.text('Aktif'), findsNothing);
        expect(find.text('Pakai Plan ini'), findsOneWidget);

        await _disposeDb(tester, db);
      },
    );

    testWidgets(
      'Plan mode Rp Nominal: 1jt + 400k + 500k + 200k tersimpan & diterapkan EXACT tanpa bergeser',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();
        final portoRepo = PortfolioRepository(db);
        final planRepo = PlanRepository(db);

        final pSaham = await portoRepo.createPortfolio(
          name: 'Saham',
          category: 'no_target',
          monthlyPlan: 0,
          annualReturnPct: 8,
          icon: 'trending_up',
          color: 0xFF0E7C66,
        );
        final pRumah = await portoRepo.createPortfolio(
          name: 'Rumah',
          category: 'cash',
          savedTarget: 100000000,
          monthlyPlan: 0,
          annualReturnPct: 6,
          icon: 'home',
          color: 0xFF2F6DB3,
        );
        final pNikah = await portoRepo.createPortfolio(
          name: 'Nikah',
          category: 'cash',
          savedTarget: 50000000,
          monthlyPlan: 0,
          annualReturnPct: 5,
          icon: 'favorite',
          color: 0xFFD97706,
        );
        final pKendaraan = await portoRepo.createPortfolio(
          name: 'Kendaraan',
          category: 'cash',
          savedTarget: 30000000,
          monthlyPlan: 0,
          annualReturnPct: 5,
          icon: 'directions_car',
          color: 0xFF7C3AED,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appDatabaseProvider.overrideWithValue(db),
              notificationGatewayProvider.overrideWithValue(_SilentGateway()),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PlanFormScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('plan_name_field')),
          'Plan Bulanan',
        );

        final rpModeFinder = find.text('Rp Nominal');
        await tester.scrollUntilVisible(
          rpModeFinder,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.tap(rpModeFinder);
        await tester.pumpAndSettle();

        final targets = [
          (pSaham, '1000000'),
          (pRumah, '400000'),
          (pNikah, '500000'),
          (pKendaraan, '200000'),
        ];
        for (final (pid, val) in targets) {
          final fieldFinder = find.byKey(Key('plan_row_input_$pid'));
          await tester.scrollUntilVisible(
            fieldFinder,
            200,
            scrollable: find.byType(Scrollable).first,
          );
          await tester.enterText(fieldFinder, val);
          await tester.pump();
        }

        // Simpan Plan (karena belum ada Plan aktif, otomatis aktif & langsung update monthlyPlan semua porto!)
        await tester.tap(find.byKey(const Key('plan_save_button')));
        await tester.pumpAndSettle();

        final savedPlan = (await db.select(db.plans).get()).single;
        expect(savedPlan.totalAmount, 2100000);
        expect(savedPlan.isActive, isTrue);

        // Tanpa perlu klik applyPlan manual, monthlyPlan tiap porto harus SUDAH EXACT!
        final allPortos = await db.select(db.portfolios).get();
        final byId = {for (final p in allPortos) p.id: p.monthlyPlan};
        expect(byId[pSaham], 1000000);
        expect(byId[pRumah], 400000);
        expect(byId[pNikah], 500000);
        expect(byId[pKendaraan], 200000);

        // Edit Plan aktif -> ubah Rumah jadi 600k (total 2.3jt) -> monthlyPlan Rumah otomatis ikut 600k!
        await planRepo.savePlan(
          id: savedPlan.id,
          name: 'Plan Bulanan',
          totalAmount: 2300000,
          sharePercentX100ByPortfolioId: {
            pSaham: 4348,
            pRumah: 2609,
            pNikah: 2174,
            pKendaraan: 869,
          },
          fixedAmountsByPortfolioId: {
            pSaham: 1000000,
            pRumah: 600000,
            pNikah: 500000,
            pKendaraan: 200000,
          },
        );
        final updatedPortos = await db.select(db.portfolios).get();
        final updatedById = {for (final p in updatedPortos) p.id: p.monthlyPlan};
        expect(updatedById[pRumah], 600000);
        expect(updatedById[pSaham], 1000000);
        expect(updatedById[pNikah], 500000);
        expect(updatedById[pKendaraan], 200000);

        await _disposeDb(tester, db);
      },
    );
  });
}
