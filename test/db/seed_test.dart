import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planora/data/db/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('FR-01: Instal baru menghasilkan keadaan kosong total (seed_version = 3) dan idempoten', () async {
    final fixedNow = DateTime(2026, 11, 25);

    await db.ensureInitialized(now: fixedNow);
    await db.ensureInitialized(now: fixedNow);

    final profiles = await db.select(db.userProfiles).get();
    expect(profiles.length, 1);
    expect(profiles.first.displayName, isNull);
    expect(profiles.first.displayNameFull, isNull);
    expect(profiles.first.themePref, 'ikut_sistem');
    expect(profiles.first.isLocalOnly, isTrue);

    final settingsRows = await db.select(db.settings).get();
    expect(settingsRows.length, 1);
    expect(settingsRows.first.monthlySalary, isNull);
    expect(settingsRows.first.minimumLivingCost, isNull);
    expect(settingsRows.first.defaultAnnualReturnPct, 5.0);
    expect(settingsRows.first.phaseLimitEnabled, isFalse);
    expect(settingsRows.first.onboardingDone, isFalse);
    expect(settingsRows.first.seedVersion, 3);

    expect(await db.select(db.portfolios).get(), isEmpty);
    expect(await db.select(db.portfolioComponents).get(), isEmpty);
    expect(await db.select(db.contributions).get(), isEmpty);
    expect(await db.select(db.phases).get(), isEmpty);
    expect(await db.select(db.phaseAllocations).get(), isEmpty);
    expect(await db.select(db.priceReferences).get(), isEmpty);
  });
}
