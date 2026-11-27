import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/notifications/reminder_service.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/features/home/home_screen.dart';
import 'package:planora/features/settings/settings_screen.dart';
import 'package:planora/widgets/rupiah_text_field.dart';

class _CaptureGateway implements NotificationGateway {
  final List<String> scheduledBodies = [];

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
  }) async {
    scheduledBodies.add(body);
  }

  @override
  Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
  }) async {}
}

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

  group('v3.2 — Mode Privasi & Komposisi Semua Porto', () {
    test('Format samaran panjang tetap & tidak mengikuti jumlah digit asli', () {
      AppFormatters.hideAmounts = true;
      expect(AppFormatters.rupiah(500), AppFormatters.maskedRupiah);
      expect(AppFormatters.rupiah(500000000), AppFormatters.maskedRupiah);
      expect(
        AppFormatters.rupiah(500).length,
        AppFormatters.rupiah(500000000).length,
      );
      // Input angka (AppFormatters.number) & allowMask: false tetap tampil asli
      expect(AppFormatters.number(1500000), '1.500.000');
      expect(AppFormatters.rupiah(1500000, allowMask: false), 'Rp 1.500.000');
    });

    test('Notifikasi pengingat bulanan menyamarkan nominal saat hideAmounts aktif', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final settingsRepo = SettingsRepository(db);
      await settingsRepo.updateReminderSettings(
        reminderMonthlyEnabled: true,
        reminderMonthlyDay: 1,
        reminderMonthlyHour: 9,
        reminderMonthlyMinute: 0,
      );
      await settingsRepo.setHideAmounts(true);
      final setting = await settingsRepo.getSettings();

      final gateway = _CaptureGateway();
      final service = ReminderService(gateway);
      await service.syncSchedules(
        setting: setting,
        activePlanName: 'Plan Fokus Rumah',
        activePlanTotal: 3500000,
      );

      expect(gateway.scheduledBodies.length, 1);
      expect(gateway.scheduledBodies.single, contains('Plan Fokus Rumah'));
      expect(gateway.scheduledBodies.single, isNot(contains('3.500.000')));
    });

    testWidgets(
      'Beranda: tombol mata menyamarkan nominal tapi persen & Komposisi Semua Porto tetap tampil',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();
        final gateway = _CaptureGateway();
        final portoRepo = PortfolioRepository(db);

        final p1 = await portoRepo.createPortfolio(
          name: 'DP Rumah',
          category: 'cash',
          savedTarget: 100000000,
          monthlyPlan: 2000000,
          annualReturnPct: 6,
          icon: 'home',
          color: 0xFF0E7C66,
          initialComponents: const [
            ComponentDraft(instrumentType: 'RDPU', targetPercent: 40),
            ComponentDraft(instrumentType: 'RD Obligasi', targetPercent: 60),
          ],
        );
        await portoRepo.createPortfolio(
          name: 'Saham Bebas',
          category: 'no_target',
          monthlyPlan: 500000,
          annualReturnPct: 8,
          icon: 'trending_up',
          color: 0xFFC026D3,
          initialComponents: const [
            ComponentDraft(instrumentType: 'Saham langsung', targetPercent: 100),
          ],
        );
        await portoRepo.addContribution(
          portfolioId: p1,
          amount: 10000000,
          dateIso: '2026-11-10',
          componentId: PortfolioRepository.autoSplitComponentId,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appDatabaseProvider.overrideWithValue(db),
              notificationGatewayProvider.overrideWithValue(gateway),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const HomeScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Awal: nominal terlihat & kartu Komposisi Semua Porto + catatan Tanpa Target tampil
        expect(find.text('Rp 10.000.000'), findsWidgets);
        expect(find.byKey(const Key('global_composition_card')), findsOneWidget);
        expect(find.byKey(const Key('global_no_target_note')), findsOneWidget);

        // Ketuk tombol mata -> nominal tersamarkan, persen tetap tampil
        await tester.tap(find.byKey(const Key('privacy_toggle_button')));
        await tester.pumpAndSettle();

        expect(find.text(AppFormatters.maskedRupiah), findsWidgets);
        expect(find.text('Rp 10.000.000'), findsNothing);
        expect(find.textContaining('10% dari target'), findsOneWidget);

        // Persisten di DB
        final savedSetting = await SettingsRepository(db).getSettings();
        expect(savedSetting.hideAmounts, isTrue);

        await _disposeDb(tester, db);
      },
    );

    testWidgets(
      'Pengaturan: saklar Mode Privasi bekerja & RupiahTextField tetap tampilkan input pengguna',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();
        final gateway = _CaptureGateway();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              appDatabaseProvider.overrideWithValue(db),
              notificationGatewayProvider.overrideWithValue(gateway),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const SettingsScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final sw = find.byKey(const Key('privacy_mode_switch'));
        await tester.scrollUntilVisible(
          sw,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.tap(sw);
        await tester.pumpAndSettle();

        expect((await SettingsRepository(db).getSettings()).hideAmounts, isTrue);

        // Uji form input tetap menampilkan angka asli saat hideAmounts = true
        final ctrl = TextEditingController();
        addTearDown(ctrl.dispose);
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: RupiahTextField(controller: ctrl, label: 'Nominal'),
            ),
          ),
        );
        await tester.enterText(find.byType(TextFormField), '2500000');
        await tester.pump();
        expect(ctrl.text, '2.500.000');

        await _disposeDb(tester, db);
      },
    );
  });
}
