import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/data/db/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
