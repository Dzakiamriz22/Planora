import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:planora/app.dart';
import 'package:planora/core/notifications/reminder_service.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');

  final db = AppDatabase();
  await db.ensureInitialized();

  final gateway = FlutterLocalNotificationGateway();
  await ReminderService(gateway).initializeWithoutRequestingPermission();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        notificationGatewayProvider.overrideWithValue(gateway),
      ],
      child: const PlanoraApp(),
    ),
  );
}

