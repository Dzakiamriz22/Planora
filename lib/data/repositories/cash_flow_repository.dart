import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/cash_flow_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:uuid/uuid.dart';

class CashFlowValidationException implements Exception {
  CashFlowValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class CashFlowRepository {
  CashFlowRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<String> _ownerId() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    return profile.id;
  }

  Stream<List<CashFlowCategory>> watchCategories() {
    return (_db.select(_db.cashFlowCategories)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Stream<List<CashFlowTransaction>> watchTransactions() {
    return (_db.select(_db.cashFlowTransactions)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.desc(t.transactionDate),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  Future<String> addTransaction({
    required String type,
    required int amount,
    required String categoryId,
    required DateTime transactionDate,
    String? note,
    DateTime? now,
  }) async {
    if (type != CashFlowCalc.typeIncome && type != CashFlowCalc.typeExpense) {
      throw CashFlowValidationException('Jenis transaksi tidak valid.');
    }
    final amtErr = CashFlowCalc.validateAmount(amount);
    if (amtErr != null) throw CashFlowValidationException(amtErr);
    final dateErr = CashFlowCalc.validateTransactionDate(
      transactionDate,
      now: now,
    );
    if (dateErr != null) throw CashFlowValidationException(dateErr);

    final cat = await (_db.select(_db.cashFlowCategories)
          ..where((t) => t.id.equals(categoryId) & t.deletedAt.isNull()))
        .getSingleOrNull();
    if (cat == null) {
      throw CashFlowValidationException('Kategori tidak ditemukan.');
    }
    if (cat.type != type) {
      throw CashFlowValidationException(
        'Kategori tidak sesuai dengan jenis transaksi.',
      );
    }

    final id = _uuid.v4();
    final ownerId = await _ownerId();
    final isoNow = (now ?? DateTime.now()).toUtc().toIso8601String();
    final cleanNote = note?.trim();

    await _db.into(_db.cashFlowTransactions).insert(
          CashFlowTransactionsCompanion.insert(
            id: id,
            ownerId: ownerId,
            type: type,
            transactionDate: AppFormatters.toIsoDate(transactionDate),
            amount: amount,
            categoryId: categoryId,
            note: Value(cleanNote == null || cleanNote.isEmpty ? null : cleanNote),
            createdAt: isoNow,
            updatedAt: isoNow,
          ),
        );
    return id;
  }

  Future<void> updateTransaction({
    required String id,
    required String type,
    required int amount,
    required String categoryId,
    required DateTime transactionDate,
    String? note,
    DateTime? now,
  }) async {
    if (type != CashFlowCalc.typeIncome && type != CashFlowCalc.typeExpense) {
      throw CashFlowValidationException('Jenis transaksi tidak valid.');
    }
    final amtErr = CashFlowCalc.validateAmount(amount);
    if (amtErr != null) throw CashFlowValidationException(amtErr);
    final dateErr = CashFlowCalc.validateTransactionDate(
      transactionDate,
      now: now,
    );
    if (dateErr != null) throw CashFlowValidationException(dateErr);

    final cat = await (_db.select(_db.cashFlowCategories)
          ..where((t) => t.id.equals(categoryId) & t.deletedAt.isNull()))
        .getSingleOrNull();
    if (cat == null || cat.type != type) {
      throw CashFlowValidationException(
        'Kategori tidak sesuai dengan jenis transaksi.',
      );
    }

    final isoNow = (now ?? DateTime.now()).toUtc().toIso8601String();
    final cleanNote = note?.trim();

    await (_db.update(_db.cashFlowTransactions)..where((t) => t.id.equals(id)))
        .write(
      CashFlowTransactionsCompanion(
        type: Value(type),
        transactionDate: Value(AppFormatters.toIsoDate(transactionDate)),
        amount: Value(amount),
        categoryId: Value(categoryId),
        note: Value(cleanNote == null || cleanNote.isEmpty ? null : cleanNote),
        updatedAt: Value(isoNow),
      ),
    );
  }

  Future<void> deleteTransaction(String id, {DateTime? now}) async {
    final isoNow = (now ?? DateTime.now()).toUtc().toIso8601String();
    await (_db.update(_db.cashFlowTransactions)..where((t) => t.id.equals(id)))
        .write(
      CashFlowTransactionsCompanion(
        deletedAt: Value(isoNow),
        updatedAt: Value(isoNow),
      ),
    );
  }

  Future<String> createCategory({
    required String type,
    required String name,
    String icon = 'category',
    int color = 0xFF0E7C66,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw CashFlowValidationException('Nama kategori wajib diisi.');
    }
    if (type != CashFlowCalc.typeIncome && type != CashFlowCalc.typeExpense) {
      throw CashFlowValidationException('Jenis kategori tidak valid.');
    }

    final existing = await (_db.select(_db.cashFlowCategories)
          ..where((t) => t.type.equals(type) & t.deletedAt.isNull()))
        .get();
    final dup = existing.any(
      (c) => c.name.trim().toLowerCase() == trimmed.toLowerCase(),
    );
    if (dup) {
      throw CashFlowValidationException(
        'Kategori "$trimmed" sudah ada untuk jenis ini.',
      );
    }

    final nextOrder = existing.isEmpty
        ? 0
        : existing.map((e) => e.sortOrder).reduce((a, b) => a > b ? a : b) + 1;
    final id = _uuid.v4();
    final ownerId = await _ownerId();
    final isoNow = DateTime.now().toUtc().toIso8601String();

    await _db.into(_db.cashFlowCategories).insert(
          CashFlowCategoriesCompanion.insert(
            id: id,
            ownerId: ownerId,
            type: type,
            name: trimmed,
            icon: Value(icon),
            color: Value(color),
            isDefault: const Value(false),
            sortOrder: Value(nextOrder),
            isHidden: const Value(false),
            createdAt: isoNow,
            updatedAt: isoNow,
          ),
        );
    return id;
  }

  Future<void> setCategoryHidden(String categoryId, bool hidden) async {
    final isoNow = DateTime.now().toUtc().toIso8601String();
    await (_db.update(_db.cashFlowCategories)
          ..where((t) => t.id.equals(categoryId)))
        .write(
      CashFlowCategoriesCompanion(
        isHidden: Value(hidden),
        updatedAt: Value(isoNow),
      ),
    );
  }

  Future<int> countCategoryUsage(String categoryId) async {
    final rows = await (_db.select(_db.cashFlowTransactions)
          ..where(
            (t) => t.categoryId.equals(categoryId) & t.deletedAt.isNull(),
          ))
        .get();
    return rows.length;
  }

  /// Kategori yang masih dipakai transaksi TIDAK bisa dihapus — hanya disembunyikan.
  /// Mengembalikan `true` jika dihapus permanen, `false` jika dialihkan ke sembunyikan.
  Future<bool> deleteOrHideCategory(String categoryId) async {
    final usage = await countCategoryUsage(categoryId);
    if (usage > 0) {
      await setCategoryHidden(categoryId, true);
      return false;
    }
    await (_db.delete(_db.cashFlowCategories)
          ..where((t) => t.id.equals(categoryId)))
        .go();
    return true;
  }
}

final cashFlowRepositoryProvider = Provider<CashFlowRepository>((ref) {
  return CashFlowRepository(ref.watch(appDatabaseProvider));
});
