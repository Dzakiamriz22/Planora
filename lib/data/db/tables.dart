import 'package:drift/drift.dart';

/// 8 entitas cloud-ready Planora v2.1 FINAL (DS-PLN-2026-001 Bab D.1–D.3).
/// Seluruh uang disimpan sebagai INTEGER rupiah; semua PK adalah UUID teks.

class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get displayNameFull => text().nullable()();
  TextColumn get displayName => text().nullable()();
  TextColumn get emailLocal => text().nullable()();
  TextColumn get phoneLocal => text().nullable()();
  TextColumn get birthDate => text().nullable()();
  TextColumn get avatarPath => text().nullable()();

  /// `ikut_sistem` | `terang` | `gelap`
  TextColumn get themePref =>
      text().withDefault(const Constant('ikut_sistem'))();
  TextColumn get currency => text().withDefault(const Constant('IDR'))();
  TextColumn get locale => text().withDefault(const Constant('id_ID'))();
  BoolColumn get isLocalOnly => boolean().withDefault(const Constant(true))();

  // Kolom standar cloud-ready (Bab D.2)
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Settings extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  IntColumn get monthlySalary => integer().nullable()();
  IntColumn get minimumLivingCost => integer().nullable()();
  IntColumn get currentLivingCost => integer().nullable()();
  RealColumn get defaultAnnualReturnPct =>
      real().withDefault(const Constant(5.0))();
  BoolColumn get phaseLimitEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get phaseLimitAmount => integer().nullable()();
  BoolColumn get onboardingDone =>
      boolean().withDefault(const Constant(false))();
  IntColumn get seedVersion => integer().withDefault(const Constant(3))();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Portfolios extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  TextColumn get name => text()();

  /// `cash`, `down_payment`, atau `no_target`
  TextColumn get category => text()();

  /// Enum generik: `aperd` | `broker` | `bank` | `ewallet` | `self_storage` | `other`
  TextColumn get platformPreset => text().nullable()();

  /// Nama platform teks bebas tulisan pengguna sendiri
  TextColumn get platformName => text().nullable()();

  IntColumn get fullPrice => integer().nullable()();
  IntColumn get downPayment => integer().nullable()();
  IntColumn get fees => integer().nullable()();
  IntColumn get savedTarget => integer().nullable()();
  TextColumn get targetDate => text().nullable()();
  IntColumn get monthlyPlan => integer().withDefault(const Constant(0))();
  RealColumn get annualReturnPct => real().withDefault(const Constant(5.0))();

  /// `target_driven` atau `deposit_driven`
  TextColumn get calcMode =>
      text().withDefault(const Constant('deposit_driven'))();
  TextColumn get icon => text().withDefault(const Constant('savings'))();
  IntColumn get color => integer().withDefault(const Constant(0xFF0E7C66))();
  TextColumn get note => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PortfolioComponents extends Table {
  TextColumn get id => text()();
  TextColumn get portfolioId => text().references(
        Portfolios,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  TextColumn get instrumentType => text()();
  TextColumn get name => text().nullable()();
  IntColumn get amount => integer()();
  TextColumn get codeNote => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Contributions extends Table {
  TextColumn get id => text()();
  TextColumn get portfolioId => text().references(
        Portfolios,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  IntColumn get amount => integer()();
  TextColumn get date => text()();
  TextColumn get note => text().nullable()();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Phases extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PhaseAllocations extends Table {
  TextColumn get id => text()();
  TextColumn get phaseId => text().references(
        Phases,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get portfolioId => text().references(
        Portfolios,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  IntColumn get monthlyAmount => integer().withDefault(const Constant(0))();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {phaseId, portfolioId},
      ];
}

class PriceReferences extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  TextColumn get name => text()();
  IntColumn get fullPrice => integer()();
  IntColumn get downPayment => integer()();
  IntColumn get fees => integer()();
  TextColumn get note => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
