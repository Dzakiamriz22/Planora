import 'package:drift/drift.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:uuid/uuid.dart';

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

