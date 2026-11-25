import 'package:drift/drift.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:uuid/uuid.dart';

/// Seed kosong v3 (DS-PLN-2026-001 FR-01 / Bab A.4).
///
/// Instal baru menghasilkan:
/// - 1 baris `user_profiles` kosong (UUID lokal baru, semua identitas NULL)
/// - 1 baris `settings` kosong (gaji & biaya hidup NULL, return 5%, batas fase nonaktif, seed_version = 3)
/// - 0 porto, 0 komponen, 0 setoran, 0 fase, 0 alokasi, 0 referensi harga.
Future<void> ensureEmptyInitialState(AppDatabase db, {DateTime? now}) async {
  const uuid = Uuid();
  final isoNow = (now ?? DateTime.now()).toUtc().toIso8601String();

  await db.transaction(() async {
    final existingSettings = await db.select(db.settings).get();
    if (existingSettings.isNotEmpty) {
      return;
    }

    final existingProfiles = await db.select(db.userProfiles).get();
    final String profileId;
    if (existingProfiles.isEmpty) {
      profileId = uuid.v4();
      await db.into(db.userProfiles).insert(
            UserProfilesCompanion.insert(
              id: profileId,
              themePref: const Value('ikut_sistem'),
              currency: const Value('IDR'),
              locale: const Value('id_ID'),
              isLocalOnly: const Value(true),
              createdAt: isoNow,
              updatedAt: isoNow,
              syncStatus: const Value('local'),
            ),
          );
    } else {
      profileId = existingProfiles.first.id;
    }

    await db.into(db.settings).insert(
          SettingsCompanion.insert(
            id: uuid.v4(),
            ownerId: profileId,
            monthlySalary: const Value(null),
            minimumLivingCost: const Value(null),
            currentLivingCost: const Value(null),
            defaultAnnualReturnPct: const Value(5.0),
            phaseLimitEnabled: const Value(false),
            phaseLimitAmount: const Value(null),
            onboardingDone: const Value(false),
            seedVersion: const Value(3),
            createdAt: isoNow,
            updatedAt: isoNow,
            syncStatus: const Value('local'),
          ),
        );
  });
}
