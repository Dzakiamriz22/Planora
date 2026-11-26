import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:planora/core/notifications/reminder_service.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/features/home/home_screen.dart';
import 'package:planora/features/settings/settings_screen.dart';

class _FakeNotificationGateway implements NotificationGateway {
  bool granted = false;
  int initializeCalls = 0;
  int requestPermissionCalls = 0;
  int openSettingsCalls = 0;
  final List<({int id, String title, String body, int day, int hour, int min})>
      scheduledMonthly = [];
  final List<({int id, String title, String body})> shownImmediate = [];
  final List<int> cancelledIds = [];

  @override
  Future<void> initialize() async {
    initializeCalls++;
  }

  @override
  Future<bool> areNotificationsEnabled() async => granted;

  @override
  Future<bool> requestPermission() async {
    requestPermissionCalls++;
    return granted;
  }

  @override
  Future<bool> openSystemNotificationSettings() async {
    openSettingsCalls++;
    return true;
  }

  @override
  Future<void> scheduleMonthly({
    required int id,
    required String title,
    required String body,
    required int dayOfMonth,
    required int hour,
    required int minute,
  }) async {
    scheduledMonthly.add((
      id: id,
      title: title,
      body: body,
      day: dayOfMonth,
      hour: hour,
      min: minute,
    ));
  }

  @override
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {}

  @override
  Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
  }) async {
    shownImmediate.add((id: id, title: title, body: body));
  }

  @override
  Future<void> cancel(int id) async {
    cancelledIds.add(id);
  }
}

Future<void> _disposeDb(WidgetTester tester, AppDatabase db) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 50));
  await db.close();
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Pengingat Lokal & Izin Notifikasi Resmi', () {
    test('Cold start: initializeWithoutRequestingPermission TIDAK pernah meminta izin', () async {
      final gateway = _FakeNotificationGateway();
      final service = ReminderService(gateway);

      await service.initializeWithoutRequestingPermission();
      expect(gateway.initializeCalls, 1);
      expect(gateway.requestPermissionCalls, 0);
    });

    test('Jadwal bulanan terpasang sesuai Plan aktif & milestone 25/50/75/100% terpicu', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await db.ensureInitialized();

      final settingsRepo = SettingsRepository(db);
      await settingsRepo.updateReminderSettings(
        reminderMonthlyEnabled: true,
        reminderMonthlyDay: 5,
        reminderMonthlyHour: 9,
        reminderMonthlyMinute: 0,
        reminderMilestoneEnabled: true,
      );
      final setting = await settingsRepo.getSettings();

      final gateway = _FakeNotificationGateway()..granted = true;
      final service = ReminderService(gateway);

      final synced = await service.syncSchedules(
        setting: setting,
        activePlanName: 'Plan Fokus Rumah',
        activePlanTotal: 3500000,
      );
      expect(synced, isTrue);
      expect(gateway.scheduledMonthly.length, 1);
      expect(gateway.scheduledMonthly.single.day, 5);
      expect(gateway.scheduledMonthly.single.hour, 9);
      expect(gateway.scheduledMonthly.single.body, contains('Plan Fokus Rumah'));

      final hit50 = await service.notifyMilestoneIfCrossed(
        setting: setting,
        portfolioName: 'Rumah',
        previousProgressPct: 40,
        nextProgressPct: 52,
      );
      expect(hit50, 50);
      expect(gateway.shownImmediate.length, 1);
      expect(gateway.shownImmediate.single.body, contains('50%'));
    });

    testWidgets(
      'Dialog penjelasan muncul SEBELUM dialog sistem; penolakan menampilkan status & kartu di Beranda',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        await db.ensureInitialized();
        final gateway = _FakeNotificationGateway()..granted = false;

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

        // Cold start: belum ada permintaan izin
        expect(gateway.requestPermissionCalls, 0);

        final switchFinder = find.byKey(const Key('reminder_monthly_switch'));
        await tester.scrollUntilVisible(
          switchFinder,
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.ensureVisible(switchFinder);
        await tester.pumpAndSettle();
        await tester.tap(switchFinder);
        await tester.pumpAndSettle();

        // Dialog penjelasan muncul SEBELUM izin sistem diminta
        expect(
          find.byKey(const Key('notification_rationale_dialog')),
          findsOneWidget,
        );
        expect(gateway.requestPermissionCalls, 0);

        // Tekan Lanjutkan -> sistem dipanggil, ditolak (granted=false)
        await tester.tap(find.byKey(const Key('notification_rationale_continue')));
        await tester.pumpAndSettle();

        expect(gateway.requestPermissionCalls, 1);
        expect(
          find.byKey(const Key('notification_disabled_banner')),
          findsOneWidget,
        );
        expect(find.textContaining('Notifikasi belum aktif'), findsOneWidget);

        // Tombol buka pengaturan sistem bekerja
        await tester.tap(
          find.byKey(const Key('open_system_notification_settings')),
        );
        await tester.pumpAndSettle();
        expect(gateway.openSettingsCalls, 1);

        // Pastikan di Beranda muncul kartu pengingat lokal saat izin ditolak
        final portoRepo = PortfolioRepository(db);
        await portoRepo.createPortfolio(
          name: 'Dana Darurat',
          category: 'cash',
          savedTarget: 10000000,
          monthlyPlan: 1000000,
          annualReturnPct: 5,
          icon: 'shield',
          color: 0xFF0E7C66,
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

        expect(find.byKey(const Key('in_app_reminder_card')), findsOneWidget);

        await _disposeDb(tester, db);
      },
    );
  });
}
