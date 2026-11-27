import 'package:drift/drift.dart';

class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get displayNameFull => text().nullable()();
  TextColumn get displayName => text().nullable()();
  TextColumn get emailLocal => text().nullable()();
  TextColumn get phoneLocal => text().nullable()();
  TextColumn get birthDate => text().nullable()();
  TextColumn get avatarPath => text().nullable()();

  TextColumn get themePref =>
      text().withDefault(const Constant('ikut_sistem'))();
  TextColumn get currency => text().withDefault(const Constant('IDR'))();
  TextColumn get locale => text().withDefault(const Constant('id_ID'))();
  BoolColumn get isLocalOnly => boolean().withDefault(const Constant(true))();

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
  BoolColumn get planLimitEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get planLimitAmount => integer().nullable()();
  BoolColumn get onboardingDone =>
      boolean().withDefault(const Constant(false))();
  IntColumn get seedVersion => integer().withDefault(const Constant(3))();

  TextColumn get componentInputMode =>
      text().withDefault(const Constant('percent'))();

  TextColumn get quoteCardDismissedMonth => text().nullable()();

  BoolColumn get reminderMonthlyEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get reminderMonthlyDay =>
      integer().withDefault(const Constant(1))();
  IntColumn get reminderMonthlyHour =>
      integer().withDefault(const Constant(9))();
  IntColumn get reminderMonthlyMinute =>
      integer().withDefault(const Constant(0))();

  BoolColumn get reminderExpenseEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get reminderExpenseHour =>
      integer().withDefault(const Constant(9))();
  IntColumn get reminderExpenseMinute =>
      integer().withDefault(const Constant(0))();

  BoolColumn get reminderMilestoneEnabled =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get hideAmounts =>
      boolean().withDefault(const Constant(false))();

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

  TextColumn get category => text()();

  TextColumn get platformPreset => text().nullable()();

  TextColumn get platformName => text().nullable()();

  IntColumn get fullPrice => integer().nullable()();
  IntColumn get downPayment => integer().nullable()();
  IntColumn get fees => integer().nullable()();
  IntColumn get savedTarget => integer().nullable()();
  TextColumn get targetDate => text().nullable()();
  IntColumn get monthlyPlan => integer().withDefault(const Constant(0))();
  RealColumn get annualReturnPct => real().withDefault(const Constant(5.0))();

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

  RealColumn get targetPercent =>
      real().withDefault(const Constant(0.0))();

  IntColumn get actualAmount => integer().withDefault(const Constant(0))();

  TextColumn get mechanism =>
      text().withDefault(const Constant('nominal'))();

  IntColumn get legacyOpeningAmount =>
      integer().withDefault(const Constant(0))();

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

  TextColumn get componentId => text().nullable()();
  TextColumn get stockTransactionId => text().nullable()();
  TextColumn get source => text().withDefault(const Constant('manual'))();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Plans extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get totalAmount => integer().withDefault(const Constant(0))();
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

class PlanAllocations extends Table {
  TextColumn get id => text()();
  TextColumn get planId => text().references(
        Plans,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get portfolioId => text().references(
        Portfolios,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  IntColumn get sharePercentX100 => integer().withDefault(const Constant(0))();
  IntColumn get fixedAmount => integer().nullable()();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('local'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {planId, portfolioId},
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

class StockTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get ownerId => text().references(UserProfiles, #id)();
  TextColumn get componentId => text().references(
        PortfolioComponents,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get portfolioId => text().references(
        Portfolios,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get ticker => text()();
  TextColumn get side => text()();
  IntColumn get lots => integer()();
  IntColumn get shares => integer()();
  IntColumn get pricePerShare => integer()();
  IntColumn get totalAmount => integer()();
  TextColumn get transactionDate => text()();
  TextColumn get note => text().nullable()();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('local_only'))();
  TextColumn get remoteId => text().nullable()();
  TextColumn get deletedAt => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
