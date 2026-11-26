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
  });
}
