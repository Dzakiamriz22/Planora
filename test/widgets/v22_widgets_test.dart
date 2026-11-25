import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/home/home_screen.dart';
import 'package:planora/features/portfolios/portfolio_detail_screen.dart';
import 'package:planora/widgets/component_allocation_editor.dart';
import 'package:planora/widgets/planora_charts.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Bab 11.3 — Widget Test Komponen, Chart, Detail Porto & Beranda', () {
    testWidgets(
      'Form komponen: mode Persen -> Nominal -> Persen tidak mengubah nilai; auto-balance 85% -> 100%',
      (tester) async {
        var rows = [
          EditableComponentRow(
            key: 'k1',
            instrumentType: 'RDPU',
            targetPercent: 50,
          ),
          EditableComponentRow(
            key: 'k2',
            instrumentType: 'RD Obligasi',
            targetPercent: 35,
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
                    portfolioTargetTotal: 140000000,
                    inputMode: mode,
                    onRowsChanged: (next) => setState(() => rows = next),
                    onInputModeChanged: (m) => setState(() => mode = m),
                  ),
                ),
              ),
            ),
          ),
        );

        // Awal total 85% -> indikator kurang 15% & tombol Pas-kan ke 100% muncul
        expect(find.textContaining('kurang 15%'), findsOneWidget);
        expect(find.text('Pas-kan ke 100%'), findsOneWidget);

        // Pindah Persen -> Nominal -> Persen tidak mengubah nilai tersimpan
        await tester.tap(find.text('Rp Nominal'));
        await tester.pumpAndSettle();
        expect(rows[0].targetPercent, 50.0);
        expect(rows[1].targetPercent, 35.0);

        await tester.tap(find.text('% Persen'));
        await tester.pumpAndSettle();
        expect(rows[0].targetPercent, 50.0);
        expect(rows[1].targetPercent, 35.0);

        // Tekan auto-balance -> total menjadi 100% pas
        await tester.tap(find.text('Pas-kan ke 100%'));
        await tester.pumpAndSettle();
        expect(find.text('Total 100% — pas'), findsOneWidget);
        expect(find.text('Pas-kan ke 100%'), findsNothing);
      },
    );

    testWidgets('Chart dalam keadaan kosong menampilkan pesan sopan', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                PlanoraAllocationDonutChart(
                  slices: [],
                  centerLabel: 'Aktual',
                  centerValue: 'Rp 0',
                ),
                PlanoraBalanceAreaChart(points: []),
              ],
            ),
          ),
        ),
      );
      expect(
        find.text('Belum ada data — catat setoran pertama'),
        findsNWidgets(2),
      );
    });

    testWidgets(
      'Detail Porto: alih donut Aktual | Target mengganti segmen di layar yang sama',
      (tester) async {
        late AppDatabase db;
        late String pid;

        await tester.runAsync(() async {
          db = AppDatabase(NativeDatabase.memory());
          await db.ensureInitialized(now: DateTime(2026, 11, 25));
          final repo = PortfolioRepository(db);
          pid = await repo.createPortfolio(
            name: 'Uji Rumah',
            category: 'down_payment',
            platformPreset: 'aperd',
            platformName: 'Tempat Uji',
            fullPrice: 500000000,
            savedTarget: 140000000,
            monthlyPlan: 1000000,
            annualReturnPct: 5.0,
            icon: 'home',
            color: 0xFF2F6DB3,
            initialComponents: const [
              ComponentDraft(
                instrumentType: 'RDPU',
                targetPercent: 20,
                actualAmount: 80000,
              ),
              ComponentDraft(
                instrumentType: 'RD Obligasi',
                targetPercent: 70,
                actualAmount: 280000,
              ),
              ComponentDraft(
                instrumentType: 'Saham langsung',
                targetPercent: 10,
                actualAmount: 40000,
              ),
            ],
          );
          await repo.addContribution(
            portfolioId: pid,
            amount: 400000,
            dateIso: '2026-11-25',
          );
        });

        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: PortfolioDetailScreen(portfolioId: pid),
            ),
          ),
        );
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 120)));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Uji Rumah'), findsOneWidget);
        expect(find.text('Aktual'), findsWidgets);
        expect(find.text('Target'), findsWidgets);

        // Ketuk segmen Target -> berpindah ke tampilan Target tanpa pindah layar
        await tester.tap(find.text('Target').first);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.text('Rp 140 jt'), findsOneWidget);

        // Unmount tree & flush Drift stream close timer sebelum close DB
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump(const Duration(milliseconds: 50));
        await db.close();
      },
    );

    testWidgets('Beranda keadaan kosong tampil bersih tanpa chart palsu (mode terang & gelap)', (tester) async {
      late AppDatabase db;
      await tester.runAsync(() async {
        db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized(now: DateTime(2026, 11, 25));
      });

      for (final theme in [AppTheme.light(), AppTheme.dark()]) {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              theme: theme,
              home: const HomeScreen(),
            ),
          ),
        );
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
        await tester.pump();

        expect(find.text('Buat porto pertama'), findsOneWidget);
        expect(find.text('Pertumbuhan Saldo'), findsNothing);
      }

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 50));
      await db.close();
    });
  });
}
