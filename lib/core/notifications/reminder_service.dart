import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationGateway {
  Future<void> initialize();
  Future<bool> areNotificationsEnabled();
  Future<bool> requestPermission();
  Future<bool> openSystemNotificationSettings();
  Future<void> scheduleMonthly({
    required int id,
    required String title,
    required String body,
    required int dayOfMonth,
    required int hour,
    required int minute,
  });
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  });
  Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
  });
  Future<void> cancel(int id);
}

class FlutterLocalNotificationGateway implements NotificationGateway {
  FlutterLocalNotificationGateway();

  static const _channel = MethodChannel('com.planora.app/notifications');
  static const _androidChannelId = 'planora_reminders';
  static const _androidChannelName = 'Pengingat Planora';
  static const _androidChannelDesc =
      'Pengingat lokal setoran bulanan dan milestone portofolio';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  bool _tzInitialized = false;

  void _ensureTimeZone() {
    if (_tzInitialized) return;
    tz_data.initializeTimeZones();
    final offset = DateTime.now().timeZoneOffset;
    tz.Location chosen = tz.UTC;
    for (final loc in tz.timeZoneDatabase.locations.values) {
      if (loc.currentTimeZone.offset == offset) {
        chosen = loc;
        break;
      }
    }
    tz.setLocalLocation(chosen);
    _tzInitialized = true;
  }

  NotificationDetails get _details => const NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannelId,
          _androidChannelName,
          channelDescription: _androidChannelDesc,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      );

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _ensureTimeZone();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      _initialized = true;
      return;
    }
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _plugin.initialize(settings: initSettings);
    _initialized = true;
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    await initialize();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return (await android?.areNotificationsEnabled()) ?? false;
  }

  @override
  Future<bool> requestPermission() async {
    await initialize();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    return (await android?.requestNotificationsPermission()) ?? false;
  }

  @override
  Future<bool> openSystemNotificationSettings() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }
    try {
      final res =
          await _channel.invokeMethod<bool>('openNotificationSettings');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  tz.TZDateTime _nextMonthlyDate(int dayOfMonth, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    final safeDay = dayOfMonth.clamp(1, 28);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      safeDay,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = tz.TZDateTime(
        tz.local,
        now.year,
        now.month + 1,
        safeDay,
        hour,
        minute,
      );
    }
    return scheduled;
  }

  tz.TZDateTime _nextDailyDate(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
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
    await initialize();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: _nextMonthlyDate(dayOfMonth, hour, minute),
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  @override
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await initialize();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: _nextDailyDate(hour, minute),
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
  }) async {
    await initialize();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _details,
    );
  }

  @override
  Future<void> cancel(int id) async {
    await initialize();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    await _plugin.cancel(id: id);
  }
}

class ReminderService {
  ReminderService(this._gateway);

  static const bool expenseModuleEnabled = false;
  static const int monthlyReminderId = 1001;
  static const int dailyExpenseReminderId = 1002;
  static const int milestoneBaseId = 2000;

  final NotificationGateway _gateway;

  Future<void> initializeWithoutRequestingPermission() {
    return _gateway.initialize();
  }

  Future<bool> areNotificationsEnabled() => _gateway.areNotificationsEnabled();

  Future<bool> requestPermission() => _gateway.requestPermission();

  Future<bool> openSystemSettings() =>
      _gateway.openSystemNotificationSettings();

  Future<bool> syncSchedules({
    required Setting setting,
    required String? activePlanName,
    required int activePlanTotal,
  }) async {
    final allowed = await _gateway.areNotificationsEnabled();
    if (!allowed) {
      await _gateway.cancel(monthlyReminderId);
      await _gateway.cancel(dailyExpenseReminderId);
      return false;
    }

    if (setting.reminderMonthlyEnabled) {
      final planLabel = activePlanName != null && activePlanName.isNotEmpty
          ? '$activePlanName (${AppFormatters.rupiah(activePlanTotal)})'
          : (activePlanTotal > 0
              ? 'rencana setoran ${AppFormatters.rupiah(activePlanTotal)}'
              : 'rencana setoran bulananmu');
      await _gateway.scheduleMonthly(
        id: monthlyReminderId,
        title: 'Waktunya setor bulan ini',
        body: 'Cek dan catat setoran sesuai $planLabel.',
        dayOfMonth: setting.reminderMonthlyDay.clamp(1, 28),
        hour: setting.reminderMonthlyHour.clamp(0, 23),
        minute: setting.reminderMonthlyMinute.clamp(0, 59),
      );
    } else {
      await _gateway.cancel(monthlyReminderId);
    }

    if (expenseModuleEnabled && setting.reminderExpenseEnabled) {
      await _gateway.scheduleDaily(
        id: dailyExpenseReminderId,
        title: 'Catat pengeluaran hari ini',
        body: 'Luangkan sebentar untuk mencatat pengeluaran harianmu.',
        hour: setting.reminderExpenseHour.clamp(0, 23),
        minute: setting.reminderExpenseMinute.clamp(0, 59),
      );
    } else {
      await _gateway.cancel(dailyExpenseReminderId);
    }

    return true;
  }

  Future<int?> notifyMilestoneIfCrossed({
    required Setting setting,
    required String portfolioName,
    required double previousProgressPct,
    required double nextProgressPct,
  }) async {
    if (!setting.reminderMilestoneEnabled) return null;
    final allowed = await _gateway.areNotificationsEnabled();
    if (!allowed) return null;

    int? hit;
    for (final threshold in const [25, 50, 75, 100]) {
      if (previousProgressPct < threshold && nextProgressPct >= threshold) {
        hit = threshold;
      }
    }
    if (hit == null) return null;

    await _gateway.showImmediate(
      id: milestoneBaseId + hit,
      title: 'Milestone $portfolioName tercapai!',
      body: hit == 100
          ? '$portfolioName sudah mencapai 100% target simpan.'
          : '$portfolioName sudah melewati $hit% dari target simpan.',
    );
    return hit;
  }
}

final notificationGatewayProvider = Provider<NotificationGateway>((ref) {
  return FlutterLocalNotificationGateway();
});

final reminderServiceProvider = Provider<ReminderService>((ref) {
  return ReminderService(ref.watch(notificationGatewayProvider));
});

final notificationPermissionStatusProvider = FutureProvider<bool>((ref) {
  return ref.watch(reminderServiceProvider).areNotificationsEnabled();
});
