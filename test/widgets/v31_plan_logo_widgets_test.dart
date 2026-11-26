import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:planora/data/repositories/plan_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/features/plans/plan_form_screen.dart';
import 'package:planora/features/plans/plans_screen.dart';
import 'package:planora/widgets/planora_logo.dart';
import 'package:planora/widgets/planora_widgets.dart';

Future<void> _disposeDb(WidgetTester tester, AppDatabase db) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 50));
  await db.close();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Bab 11.3 & 11.4 — Widget test Plan %, Navigasi, dan Logo Tangga Tujuan', () {
    testWidgets('BottomNav menampilkan tab Plan (bukan Fase)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            bottomNavigationBar: PlanoraBottomNavBar(
              currentIndex: 2,
              onTap: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Plan'), findsOneWidget);
      expect(find.text('Fase'), findsNothing);
    });

    testWidgets('PlanoraLogo Tangga Tujuan render mulus di semua varian & ukuran 16dp/24dp', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Row(
              children: [
                PlanoraLogo(size: 64, variant: PlanoraLogoVariant.tile),
                PlanoraLogo(size: 24, variant: PlanoraLogoVariant.mono),
                PlanoraLogo(size: 16, variant: PlanoraLogoVariant.mono),
                PlanoraLogo(size: 40, variant: PlanoraLogoVariant.onLight),
              ],
            ),
          ),
        ),
      );
      expect(find.byType(PlanoraLogo), findsNWidgets(4));
    });

    testWidgets('PlansScreen menampilkan status Draf untuk Plan belum 100%', (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      await db.ensureInitialized();

      final portoRepo = PortfolioRepository(db);
      final planRepo = PlanRepository(db);
      final pid = await portoRepo.createPortfolio(
        name: 'Rumah',
        category: 'cash',
        savedTarget: 100000000,
        monthlyPlan: 0,
        annualReturnPct: 5,
        icon: 'home',
        color: 0xFF0E7C66,
      );
      await planRepo.savePlan(
        name: 'Plan Draf Uji',
        totalAmount: 2000000,
        sharePercentX100ByPortfolioId: {pid: 8500},
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const PlansScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Plan'), findsOneWidget);
      expect(find.text('Plan Draf Uji'), findsOneWidget);
      expect(find.textContaining('Draf — baru 85%'), findsOneWidget);
      expect(find.textContaining('Fase'), findsNothing);

      await _disposeDb(tester, db);
    });

    testWidgets('PlanFormScreen: preset Seimbang & mode gelap berjalan bersih', (tester) async {
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
      await portoRepo.createPortfolio(
        name: 'Darurat',
        category: 'cash',
        savedTarget: 20000000,
        monthlyPlan: 0,
        annualReturnPct: 5,
        icon: 'shield',
        color: 0xFF2F6DB3,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const PlanFormScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Buat Plan Baru'), findsOneWidget);
      final seimbangFinder = find.text('Seimbang');
      await tester.scrollUntilVisible(
        seimbangFinder,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(seimbangFinder);
      await tester.tap(seimbangFinder);
      await tester.pumpAndSettle();

      final total100Finder = find.textContaining('Total 100%');
      await tester.scrollUntilVisible(
        total100Finder,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(total100Finder, findsOneWidget);

      await _disposeDb(tester, db);
    });
  });
}
