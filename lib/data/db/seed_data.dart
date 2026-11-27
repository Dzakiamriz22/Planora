import 'package:drift/drift.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:uuid/uuid.dart';

class DefaultCashFlowCategorySpec {
  const DefaultCashFlowCategorySpec({
    required this.type,
    required this.name,
    required this.icon,
    required this.color,
    required this.sortOrder,
  });

  final String type;
  final String name;
  final String icon;
  final int color;
  final int sortOrder;
}

const List<DefaultCashFlowCategorySpec> defaultIncomeCategories = [
  DefaultCashFlowCategorySpec(
    type: 'income',
    name: 'Gaji',
    icon: 'payments',
    color: 0xFF0E7C66,
    sortOrder: 0,
  ),
  DefaultCashFlowCategorySpec(
    type: 'income',
    name: 'Freelance',
    icon: 'work',
    color: 0xFF2F6DB3,
    sortOrder: 1,
  ),
  DefaultCashFlowCategorySpec(
    type: 'income',
    name: 'Bonus/THR',
    icon: 'card_giftcard',
    color: 0xFFD97706,
    sortOrder: 2,
  ),
  DefaultCashFlowCategorySpec(
    type: 'income',
    name: 'Dividen',
    icon: 'trending_up',
    color: 0xFF7C3AED,
    sortOrder: 3,
  ),
  DefaultCashFlowCategorySpec(
    type: 'income',
    name: 'Lainnya',
    icon: 'category',
    color: 0xFF64748B,
    sortOrder: 4,
  ),
];

const List<DefaultCashFlowCategorySpec> defaultExpenseCategories = [
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Makan & Minum',
    icon: 'restaurant',
    color: 0xFFE11D48,
    sortOrder: 0,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Jajan',
    icon: 'local_cafe',
    color: 0xFFEA580C,
    sortOrder: 1,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Transportasi',
    icon: 'directions_bus',
    color: 0xFF2563EB,
    sortOrder: 2,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Bensin',
    icon: 'local_gas_station',
    color: 0xFFD97706,
    sortOrder: 3,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Parkir',
    icon: 'local_parking',
    color: 0xFF0891B2,
    sortOrder: 4,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Belanja Harian',
    icon: 'shopping_bag',
    color: 0xFF7C3AED,
    sortOrder: 5,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Kesehatan',
    icon: 'medical_services',
    color: 0xFF059669,
    sortOrder: 6,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Hiburan',
    icon: 'movie',
    color: 0xFFDB2777,
    sortOrder: 7,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Tagihan Rutin',
    icon: 'receipt_long',
    color: 0xFF4F46E5,
    sortOrder: 8,
  ),
  DefaultCashFlowCategorySpec(
    type: 'expense',
    name: 'Lainnya',
    icon: 'category',
    color: 0xFF64748B,
    sortOrder: 9,
  ),
];

Future<void> ensureDefaultCashFlowCategories(
  AppDatabase db, {
  required String ownerId,
  DateTime? now,
}) async {
  const uuid = Uuid();
  final isoNow = (now ?? DateTime.now()).toUtc().toIso8601String();

  final existing = await db.select(db.cashFlowCategories).get();
  final hasIncome = existing.any((c) => c.type == 'income' && c.deletedAt == null);
  final hasExpense = existing.any((c) => c.type == 'expense' && c.deletedAt == null);

  if (!hasIncome) {
    for (final spec in defaultIncomeCategories) {
      await db.into(db.cashFlowCategories).insert(
            CashFlowCategoriesCompanion.insert(
              id: uuid.v4(),
              ownerId: ownerId,
              type: spec.type,
              name: spec.name,
              icon: Value(spec.icon),
              color: Value(spec.color),
              isDefault: const Value(true),
              sortOrder: Value(spec.sortOrder),
              isHidden: const Value(false),
              createdAt: isoNow,
              updatedAt: isoNow,
            ),
          );
    }
  }

  if (!hasExpense) {
    for (final spec in defaultExpenseCategories) {
      await db.into(db.cashFlowCategories).insert(
            CashFlowCategoriesCompanion.insert(
              id: uuid.v4(),
              ownerId: ownerId,
              type: spec.type,
              name: spec.name,
              icon: Value(spec.icon),
              color: Value(spec.color),
              isDefault: const Value(true),
              sortOrder: Value(spec.sortOrder),
              isHidden: const Value(false),
              createdAt: isoNow,
              updatedAt: isoNow,
            ),
          );
    }
  }
}

Future<void> ensureEmptyInitialState(AppDatabase db, {DateTime? now}) async {
  const uuid = Uuid();
  final isoNow = (now ?? DateTime.now()).toUtc().toIso8601String();

  await db.transaction(() async {
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

    final existingSettings = await db.select(db.settings).get();
    if (existingSettings.isEmpty) {
      await db.into(db.settings).insert(
            SettingsCompanion.insert(
              id: uuid.v4(),
              ownerId: profileId,
              monthlySalary: const Value(null),
              minimumLivingCost: const Value(null),
              currentLivingCost: const Value(null),
              defaultAnnualReturnPct: const Value(5.0),
              planLimitEnabled: const Value(false),
              planLimitAmount: const Value(null),
              onboardingDone: const Value(false),
              seedVersion: const Value(3),
              createdAt: isoNow,
              updatedAt: isoNow,
              syncStatus: const Value('local'),
            ),
          );
    }

    await ensureDefaultCashFlowCategories(
      db,
      ownerId: profileId,
      now: now,
    );
  });
}
