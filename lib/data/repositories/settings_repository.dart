import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planora/core/calc/plan_percent_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';
import 'package:uuid/uuid.dart';

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Future<String> _ownerId() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    return profile.id;
  }

  Stream<Setting> watchSettings() {
    return _db.select(_db.settings).watchSingle();
  }

  Future<Setting> getSettings() {
    return _db.select(_db.settings).getSingle();
  }

  Future<void> markOnboardingDone() async {
    final current = await getSettings();
    await (_db.update(_db.settings)..where((t) => t.id.equals(current.id)))
        .write(
      SettingsCompanion(
        onboardingDone: const Value(true),
        updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );
  }

  Future<void> updateFinancialProfile({
    int? monthlySalary,
    int? minimumLivingCost,
    int? currentLivingCost,
    double? defaultAnnualReturnPct,
  }) async {
    final current = await getSettings();
    await (_db.update(_db.settings)..where((t) => t.id.equals(current.id)))
        .write(
      SettingsCompanion(
        monthlySalary: Value(monthlySalary),
        minimumLivingCost: Value(minimumLivingCost),
        currentLivingCost: Value(currentLivingCost),
        defaultAnnualReturnPct:
            Value(defaultAnnualReturnPct ?? current.defaultAnnualReturnPct),
        updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );
  }

  Future<void> updatePlanLimit({
    required bool enabled,
    int? amount,
  }) async {
    final current = await getSettings();
    await (_db.update(_db.settings)..where((t) => t.id.equals(current.id)))
        .write(
      SettingsCompanion(
        planLimitEnabled: Value(enabled),
        planLimitAmount: Value(enabled ? amount : null),
        updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );
  }

  Stream<List<PriceReference>> watchPriceReferences() {
    return (_db.select(_db.priceReferences)
          ..orderBy([
            (t) => OrderingTerm.asc(t.sortOrder),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch();
  }

  Future<void> upsertPriceReference({
    String? id,
    required String name,
    required int fullPrice,
    required int downPayment,
    required int fees,
    String? note,
  }) async {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    final ownerId = await _ownerId();

    if (id == null) {
      final existing = await _db.select(_db.priceReferences).get();
      final nextOrder = existing.isEmpty
          ? 0
          : existing.map((e) => e.sortOrder).reduce((a, b) => a > b ? a : b) +
              1;
      await _db.into(_db.priceReferences).insert(
            PriceReferencesCompanion.insert(
              id: _uuid.v4(),
              ownerId: ownerId,
              name: name.trim(),
              fullPrice: fullPrice,
              downPayment: downPayment,
              fees: fees,
              note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
              sortOrder: Value(nextOrder),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );
    } else {
      await (_db.update(_db.priceReferences)..where((t) => t.id.equals(id)))
          .write(
        PriceReferencesCompanion(
          name: Value(name.trim()),
          fullPrice: Value(fullPrice),
          downPayment: Value(downPayment),
          fees: Value(fees),
          note: Value(note?.trim().isEmpty ?? true ? null : note!.trim()),
          updatedAt: Value(nowIso),
        ),
      );
    }
  }

  Future<void> deletePriceReference(String id) async {
    await (_db.delete(_db.priceReferences)..where((t) => t.id.equals(id))).go();
  }

  Future<void> updateComponentInputMode(String mode) async {
    final normalized = mode == 'nominal' ? 'nominal' : 'percent';
    final current = await getSettings();
    await (_db.update(_db.settings)..where((t) => t.id.equals(current.id)))
        .write(
      SettingsCompanion(
        componentInputMode: Value(normalized),
        updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );
  }

  Future<void> dismissQuoteForMonth(String yearMonth) async {
    final current = await getSettings();
    await (_db.update(_db.settings)..where((t) => t.id.equals(current.id)))
        .write(
      SettingsCompanion(
        quoteCardDismissedMonth: Value(yearMonth),
        updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );
  }

  Future<void> updateReminderSettings({
    bool? reminderMonthlyEnabled,
    int? reminderMonthlyDay,
    int? reminderMonthlyHour,
    int? reminderMonthlyMinute,
    bool? reminderExpenseEnabled,
    int? reminderExpenseHour,
    int? reminderExpenseMinute,
    bool? reminderMilestoneEnabled,
  }) async {
    final current = await getSettings();
    await (_db.update(_db.settings)..where((t) => t.id.equals(current.id)))
        .write(
      SettingsCompanion(
        reminderMonthlyEnabled: reminderMonthlyEnabled != null
            ? Value(reminderMonthlyEnabled)
            : const Value.absent(),
        reminderMonthlyDay: reminderMonthlyDay != null
            ? Value(reminderMonthlyDay.clamp(1, 28))
            : const Value.absent(),
        reminderMonthlyHour: reminderMonthlyHour != null
            ? Value(reminderMonthlyHour.clamp(0, 23))
            : const Value.absent(),
        reminderMonthlyMinute: reminderMonthlyMinute != null
            ? Value(reminderMonthlyMinute.clamp(0, 59))
            : const Value.absent(),
        reminderExpenseEnabled: reminderExpenseEnabled != null
            ? Value(reminderExpenseEnabled)
            : const Value.absent(),
        reminderExpenseHour: reminderExpenseHour != null
            ? Value(reminderExpenseHour.clamp(0, 23))
            : const Value.absent(),
        reminderExpenseMinute: reminderExpenseMinute != null
            ? Value(reminderExpenseMinute.clamp(0, 59))
            : const Value.absent(),
        reminderMilestoneEnabled: reminderMilestoneEnabled != null
            ? Value(reminderMilestoneEnabled)
            : const Value.absent(),
        updatedAt: Value(DateTime.now().toUtc().toIso8601String()),
      ),
    );
  }

  Future<String> exportAllToJson() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    final settingsRow = await getSettings();
    final portfolios = await _db.select(_db.portfolios).get();
    final components = await _db.select(_db.portfolioComponents).get();
    final contributions = await _db.select(_db.contributions).get();
    final plans = await _db.select(_db.plans).get();
    final allocations = await _db.select(_db.planAllocations).get();
    final refs = await _db.select(_db.priceReferences).get();
    final stockTxs = await (_db.select(_db.stockTransactions)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.asc(t.transactionDate),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();

    final compsByPorto = <String, List<PortfolioComponent>>{};
    for (final c in components) {
      compsByPorto.putIfAbsent(c.portfolioId, () => []).add(c);
    }
    final contribsByPorto = <String, List<Contribution>>{};
    for (final c in contributions) {
      contribsByPorto.putIfAbsent(c.portfolioId, () => []).add(c);
    }

    final payload = {
      'app': 'planora',
      'schema_version': 7,
      'exported_at': DateTime.now().toUtc().toIso8601String(),
      'profile': {
        'id': profile.id,
        'display_name_full': profile.displayNameFull,
        'display_name': profile.displayName,
        'email_local': profile.emailLocal,
        'phone_local': profile.phoneLocal,
        'birth_date': profile.birthDate,
        'theme_pref': profile.themePref,
        'currency': profile.currency,
        'locale': profile.locale,
      },
      'settings': {
        'monthly_salary': settingsRow.monthlySalary,
        'minimum_living_cost': settingsRow.minimumLivingCost,
        'current_living_cost': settingsRow.currentLivingCost,
        'default_annual_return_pct': settingsRow.defaultAnnualReturnPct,
        'plan_limit_enabled': settingsRow.planLimitEnabled,
        'plan_limit_amount': settingsRow.planLimitAmount,
        'onboarding_done': settingsRow.onboardingDone,
        'component_input_mode': settingsRow.componentInputMode,
        'quote_card_dismissed_month': settingsRow.quoteCardDismissedMonth,
      },
      'portfolios': portfolios
          .map(
            (p) => {
              'id': p.id,
              'name': p.name,
              'category': p.category,
              'platform_preset': p.platformPreset,
              'platform_name': p.platformName,
              'full_price': p.fullPrice,
              'down_payment': p.downPayment,
              'fees': p.fees,
              'saved_target': p.savedTarget,
              'target_date': p.targetDate,
              'monthly_plan': p.monthlyPlan,
              'annual_return_pct': p.annualReturnPct,
              'calc_mode': p.calcMode,
              'icon': p.icon,
              'color': p.color,
              'note': p.note,
              'sort_order': p.sortOrder,
              'created_at': p.createdAt,
              'updated_at': p.updatedAt,
              'components': (compsByPorto[p.id] ?? const [])
                  .map(
                    (comp) => {
                      'id': comp.id,
                      'instrument_type': comp.instrumentType,
                      'name': comp.name,
                      'target_percent': PlanoraV22Calc.round2(comp.targetPercent),
                      'actual_amount': comp.actualAmount,
                      'mechanism': comp.mechanism,
                      'legacy_opening_amount': comp.legacyOpeningAmount,
                      'target_amount_calculated':
                          PlanoraV22Calc.targetAmountFromPercent(
                        targetPercent: comp.targetPercent,
                        portfolioTargetTotal: p.savedTarget ?? 0,
                      ),
                      'code_note': comp.codeNote,
                      'sort_order': comp.sortOrder,
                    },
                  )
                  .toList(),
              'contributions': (contribsByPorto[p.id] ?? const [])
                  .map(
                    (c) => {
                      'id': c.id,
                      'amount': c.amount,
                      'date': c.date,
                      'note': c.note,
                      'component_id': c.componentId,
                      'stock_transaction_id': c.stockTransactionId,
                      'source': c.source,
                      'created_at': c.createdAt,
                      'updated_at': c.updatedAt,
                    },
                  )
                  .toList(),
            },
          )
          .toList(),
      'stock_transactions': stockTxs
          .map(
            (tx) => {
              'id': tx.id,
              'component_id': tx.componentId,
              'portfolio_id': tx.portfolioId,
              'ticker': tx.ticker,
              'side': tx.side,
              'lots': tx.lots,
              'shares': tx.shares,
              'price_per_share': tx.pricePerShare,
              'total_amount': tx.totalAmount,
              'transaction_date': tx.transactionDate,
              'note': tx.note,
              'created_at': tx.createdAt,
              'updated_at': tx.updatedAt,
              'sync_status': tx.syncStatus,
              'remote_id': tx.remoteId,
              'deleted_at': tx.deletedAt,
            },
          )
          .toList(),
      'plans': plans.map((pl) {
        final planAllocs = allocations.where((a) => a.planId == pl.id).toList();
        final shareMap = {
          for (final a in planAllocs) a.portfolioId: a.sharePercentX100,
        };
        final derived = PlanPercentCalc.computeAmountsFromPercents(
          totalAmount: pl.totalAmount,
          sharePercentX100ById: shareMap,
        );
        return {
          'id': pl.id,
          'name': pl.name,
          'description': pl.description,
          'total_amount': pl.totalAmount,
          'is_active': pl.isActive,
          'sort_order': pl.sortOrder,
          'created_at': pl.createdAt,
          'updated_at': pl.updatedAt,
          'allocations': planAllocs
              .map(
                (a) => {
                  'id': a.id,
                  'plan_id': a.planId,
                  'portfolio_id': a.portfolioId,
                  'share_percent_x100': a.sharePercentX100,
                  'amount_calculated': derived[a.portfolioId] ?? 0,
                },
              )
              .toList(),
        };
      }).toList(),
      'plan_allocations': allocations
          .map(
            (a) => {
              'id': a.id,
              'plan_id': a.planId,
              'portfolio_id': a.portfolioId,
              'share_percent_x100': a.sharePercentX100,
            },
          )
          .toList(),
      'price_references': refs
          .map(
            (r) => {
              'id': r.id,
              'name': r.name,
              'full_price': r.fullPrice,
              'down_payment': r.downPayment,
              'fees': r.fees,
              'note': r.note,
              'sort_order': r.sortOrder,
            },
          )
          .toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  Future<void> importAllFromJson(String jsonString) async {
    final decoded = jsonDecode(jsonString);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Format file JSON tidak valid.');
    }

    final appTag = (decoded['app'] as String?)?.toLowerCase();
    if (appTag != 'planora') {
      throw const FormatException(
        'File ini bukan cadangan Planora yang sah.',
      );
    }

    final schemaVersion =
        (decoded['schema_version'] as num?)?.toInt() ??
            (decoded['schemaVersion'] as num?)?.toInt() ??
            1;
    final nowIso = DateTime.now().toUtc().toIso8601String();

    final settingsJson =
        (decoded['settings'] as Map?)?.cast<String, dynamic>() ?? const {};
    final profileJson =
        (decoded['profile'] as Map?)?.cast<String, dynamic>() ?? const {};
    final portfoliosJson = ((decoded['portfolios'] as List?) ?? const [])
        .cast<Map<String, dynamic>>();
    final topContributionsJson =
        ((decoded['contributions'] as List?) ?? const [])
            .cast<Map<String, dynamic>>();
    final plansJson = ((decoded['plans'] ?? decoded['phases'] ?? const []) as List)
        .cast<Map<String, dynamic>>();
    final allocationsJson = ((decoded['plan_allocations'] ??
            decoded['planAllocations'] ??
            decoded['phase_allocations'] ??
            decoded['phaseAllocations'] ??
            const []) as List)
        .cast<Map<String, dynamic>>();
    final refsJson = ((decoded['price_references'] ??
            decoded['priceReferences'] ??
            const []) as List)
        .cast<Map<String, dynamic>>();
    final stockTxsJson = ((decoded['stock_transactions'] ??
            decoded['stockTransactions'] ??
            const []) as List)
        .cast<Map<String, dynamic>>();

    await _db.transaction(() async {
      await _db.delete(_db.stockTransactions).go();
      await _db.delete(_db.planAllocations).go();
      await _db.delete(_db.portfolioComponents).go();
      await _db.delete(_db.contributions).go();
      await _db.delete(_db.plans).go();
      await _db.delete(_db.portfolios).go();
      await _db.delete(_db.priceReferences).go();
      await _db.delete(_db.settings).go();
      await _db.delete(_db.userProfiles).go();

      final ownerId = (profileJson['id'] as String?) ?? _uuid.v4();
      await _db.into(_db.userProfiles).insert(
            UserProfilesCompanion.insert(
              id: ownerId,
              displayNameFull: Value(profileJson['display_name_full'] as String?),
              displayName: Value(profileJson['display_name'] as String?),
              emailLocal: Value(profileJson['email_local'] as String?),
              phoneLocal: Value(profileJson['phone_local'] as String?),
              birthDate: Value(profileJson['birth_date'] as String?),
              themePref:
                  Value((profileJson['theme_pref'] as String?) ?? 'ikut_sistem'),
              currency: Value((profileJson['currency'] as String?) ?? 'IDR'),
              locale: Value((profileJson['locale'] as String?) ?? 'id_ID'),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      await _db.into(_db.settings).insert(
            SettingsCompanion.insert(
              id: _uuid.v4(),
              ownerId: ownerId,
              monthlySalary: Value(
                ((settingsJson['monthly_salary'] ??
                        settingsJson['monthlySalary']) as num?)
                    ?.toInt(),
              ),
              minimumLivingCost: Value(
                ((settingsJson['minimum_living_cost'] ??
                        settingsJson['minimumLivingCost']) as num?)
                    ?.toInt(),
              ),
              currentLivingCost: Value(
                ((settingsJson['current_living_cost'] ??
                        settingsJson['currentLivingCost']) as num?)
                    ?.toInt(),
              ),
              defaultAnnualReturnPct: Value(
                ((settingsJson['default_annual_return_pct'] ??
                            settingsJson['defaultAnnualReturnPct']) as num?)
                        ?.toDouble() ??
                    5.0,
              ),
              planLimitEnabled: Value(
                ((settingsJson['plan_limit_enabled'] ??
                        settingsJson['phase_limit_enabled']) as bool?) ??
                    false,
              ),
              planLimitAmount: Value(
                ((settingsJson['plan_limit_amount'] ??
                        settingsJson['phase_limit_amount']) as num?)
                    ?.toInt(),
              ),
              onboardingDone: Value(
                (settingsJson['onboarding_done'] as bool?) ?? true,
              ),
              componentInputMode: Value(
                (settingsJson['component_input_mode'] as String?) == 'nominal'
                    ? 'nominal'
                    : 'percent',
              ),
              quoteCardDismissedMonth: Value(
                settingsJson['quote_card_dismissed_month'] as String?,
              ),
              seedVersion: const Value(3),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      for (final p in portfoliosJson) {
        final pid = (p['id'] as String?) ?? _uuid.v4();

        final String? preset;
        final String? customPlatform;
        if (schemaVersion <= 1 && p.containsKey('platform')) {
          preset = 'other';
          customPlatform = p['platform'] as String?;
        } else {
          preset = (p['platform_preset'] as String?) ?? 'other';
          customPlatform = p['platform_name'] as String?;
        }

        await _db.into(_db.portfolios).insert(
              PortfoliosCompanion.insert(
                id: pid,
                ownerId: ownerId,
                name: p['name'] as String,
                category: p['category'] as String,
                platformPreset: Value(preset),
                platformName: Value(customPlatform),
                fullPrice: Value(
                  ((p['full_price'] ?? p['fullPrice']) as num?)?.toInt(),
                ),
                downPayment: Value(
                  ((p['down_payment'] ?? p['downPayment']) as num?)?.toInt(),
                ),
                fees: Value((p['fees'] as num?)?.toInt()),
                savedTarget: Value(
                  ((p['saved_target'] ?? p['savedTarget']) as num?)?.toInt(),
                ),
                targetDate: Value(
                  (p['target_date'] ?? p['targetDate']) as String?,
                ),
                monthlyPlan: Value(
                  ((p['monthly_plan'] ?? p['monthlyPlan']) as num?)?.toInt() ??
                      0,
                ),
                annualReturnPct: Value(
                  ((p['annual_return_pct'] ?? p['annualReturnPct']) as num?)
                          ?.toDouble() ??
                      5.0,
                ),
                calcMode: Value(
                  ((p['calc_mode'] ?? p['calcMode']) as String?) ??
                      'deposit_driven',
                ),
                icon: Value((p['icon'] as String?) ?? 'savings'),
                color: Value((p['color'] as num?)?.toInt() ?? 0xFF0E7C66),
                note: Value(p['note'] as String?),
                sortOrder: Value(
                  ((p['sort_order'] ?? p['sortOrder']) as num?)?.toInt() ?? 0,
                ),
                createdAt:
                    ((p['created_at'] ?? p['createdAt']) as String?) ?? nowIso,
                updatedAt:
                    ((p['updated_at'] ?? p['updatedAt']) as String?) ?? nowIso,
              ),
            );

        final nestedComps = ((p['components'] as List?) ?? const [])
            .cast<Map<String, dynamic>>();
        if (nestedComps.isNotEmpty) {
          final hasTargetPercent =
              schemaVersion >= 4 ||
              nestedComps.every((c) => c.containsKey('target_percent'));
          final List<double> percents;
          final List<int> actuals;

          if (hasTargetPercent) {
            percents = nestedComps
                .map(
                  (c) => PlanoraV22Calc.round2(
                    (c['target_percent'] as num).toDouble(),
                  ),
                )
                .toList();
            actuals = nestedComps
                .map(
                  (c) =>
                      ((c['actual_amount'] ?? c['amount']) as num?)?.toInt() ??
                      0,
                )
                .toList();
            if (!PlanoraV22Calc.isExact100(percents)) {
              throw MigrationValidationException(
                'Impor dibatalkan: total persen komponen porto "${p['name']}" tidak tepat 100%.',
              );
            }
          } else {
            actuals = nestedComps
                .map(
                  (c) =>
                      ((c['target_amount'] ?? c['amount']) as num?)?.toInt() ??
                      0,
                )
                .toList();
            final savedTargetVal =
                ((p['saved_target'] ?? p['savedTarget']) as num?)?.toInt() ?? 0;
            final sumActual = actuals.fold<int>(0, (s, a) => s + a);
            final totalTargetForMig =
                savedTargetVal > 0 ? savedTargetVal : sumActual;
            percents = PlanoraV22Calc.migrateAmountsToPercents(
              amounts: actuals,
              portfolioTotalTarget: totalTargetForMig,
            );
          }

          for (var i = 0; i < nestedComps.length; i++) {
            final comp = nestedComps[i];
            final instrumentType = comp['instrument_type'] as String;
            final actualVal = actuals[i];
            if (actualVal < 0) {
              throw MigrationValidationException(
                'Impor dibatalkan: saldo aktual komponen "$instrumentType" negatif.',
              );
            }
            final rawMechanism = comp['mechanism'] as String?;
            final mechanism = schemaVersion >= 5 &&
                    (rawMechanism == StockLotCalc.mechanismLotBased ||
                        rawMechanism == StockLotCalc.mechanismNominal)
                ? rawMechanism!
                : StockLotCalc.defaultMechanismForInstrument(instrumentType);
            final legacyOpening = schemaVersion >= 5
                ? ((comp['legacy_opening_amount'] as num?)?.toInt() ?? 0)
                : (mechanism == StockLotCalc.mechanismLotBased ? actualVal : 0);
            if (legacyOpening < 0) {
              throw MigrationValidationException(
                'Impor dibatalkan: saldo awal komponen "$instrumentType" negatif.',
              );
            }
            await _db.into(_db.portfolioComponents).insert(
                  PortfolioComponentsCompanion.insert(
                    id: (comp['id'] as String?) ?? _uuid.v4(),
                    portfolioId: pid,
                    ownerId: ownerId,
                    instrumentType: instrumentType,
                    name: Value(comp['name'] as String?),
                    targetPercent: Value(percents[i]),
                    actualAmount: Value(actualVal),
                    mechanism: Value(mechanism),
                    legacyOpeningAmount: Value(legacyOpening),
                    codeNote: Value(comp['code_note'] as String?),
                    sortOrder:
                        Value((comp['sort_order'] as num?)?.toInt() ?? i),
                    createdAt: nowIso,
                    updatedAt: nowIso,
                  ),
                );
          }
        }

        final nestedContribs = ((p['contributions'] as List?) ?? const [])
            .cast<Map<String, dynamic>>();
        for (final c in nestedContribs) {
          await _db.into(_db.contributions).insert(
                ContributionsCompanion.insert(
                  id: (c['id'] as String?) ?? _uuid.v4(),
                  portfolioId: pid,
                  ownerId: ownerId,
                  amount: (c['amount'] as num).toInt(),
                  date: c['date'] as String,
                  note: Value(c['note'] as String?),
                  componentId: Value(c['component_id'] as String?),
                  stockTransactionId:
                      Value(c['stock_transaction_id'] as String?),
                  source: Value(
                    (c['source'] as String?) ?? StockLotCalc.sourceManual,
                  ),
                  createdAt:
                      ((c['created_at'] ?? c['createdAt']) as String?) ?? nowIso,
                  updatedAt:
                      ((c['updated_at'] ?? c['updatedAt']) as String?) ?? nowIso,
                ),
              );
        }
      }

      if (stockTxsJson.isNotEmpty) {
        final txsByComponent = <String, List<StockTxRecord>>{};
        for (final tx in stockTxsJson) {
          final id = (tx['id'] as String?) ?? _uuid.v4();
          final componentId = tx['component_id'] as String;
          final portfolioId = tx['portfolio_id'] as String;
          final ticker = StockLotCalc.normalizeTicker(
            (tx['ticker'] as String?) ?? '',
          );
          final tickerErr = StockLotCalc.validateTicker(ticker);
          if (tickerErr != null) {
            throw StockValidationException(
              'Impor dibatalkan (transaksi $id): $tickerErr',
            );
          }
          final side = (tx['side'] as String?) ?? '';
          final lots = (tx['lots'] as num?)?.toInt() ?? 0;
          final shares = (tx['shares'] as num?)?.toInt() ?? 0;
          final pricePerShare = (tx['price_per_share'] as num?)?.toInt() ?? 0;
          final totalAmount = (tx['total_amount'] as num?)?.toInt() ?? 0;
          StockLotCalc.validateSnapshots(
            lots: lots,
            shares: shares,
            pricePerShare: pricePerShare,
            totalAmount: totalAmount,
          );
          final txDate = (tx['transaction_date'] as String?) ?? '';
          final createdAt = (tx['created_at'] as String?) ?? nowIso;
          final updatedAt = (tx['updated_at'] as String?) ?? nowIso;

          final rec = StockTxRecord(
            id: id,
            ticker: ticker,
            side: side,
            lots: lots,
            shares: shares,
            pricePerShare: pricePerShare,
            totalAmount: totalAmount,
            transactionDate: txDate,
            createdAt: createdAt,
          );
          txsByComponent.putIfAbsent(componentId, () => []).add(rec);

          await _db.into(_db.stockTransactions).insert(
                StockTransactionsCompanion.insert(
                  id: id,
                  ownerId: ownerId,
                  componentId: componentId,
                  portfolioId: portfolioId,
                  ticker: ticker,
                  side: side,
                  lots: lots,
                  shares: shares,
                  pricePerShare: pricePerShare,
                  totalAmount: totalAmount,
                  transactionDate: txDate,
                  note: Value(tx['note'] as String?),
                  createdAt: createdAt,
                  updatedAt: updatedAt,
                  syncStatus: Value(
                    (tx['sync_status'] as String?) ?? 'local_only',
                  ),
                  remoteId: Value(tx['remote_id'] as String?),
                  deletedAt: Value(tx['deleted_at'] as String?),
                ),
              );
        }

        for (final entry in txsByComponent.entries) {
          final ledger = StockLotCalc.computeLedger(entry.value);
          final comp = await (_db.select(_db.portfolioComponents)
                ..where((c) => c.id.equals(entry.key)))
              .getSingleOrNull();
          if (comp != null) {
            final expectedActual = StockLotCalc.componentActualAmount(
              totalPositionsModal: ledger.totalPositionsModal,
              legacyOpeningAmount: comp.legacyOpeningAmount,
            );
            await (_db.update(_db.portfolioComponents)
                  ..where((c) => c.id.equals(comp.id)))
                .write(
              PortfolioComponentsCompanion(
                actualAmount: Value(expectedActual),
              ),
            );
          }
        }
      }

      for (final c in topContributionsJson) {
        await _db.into(_db.contributions).insert(
              ContributionsCompanion.insert(
                id: (c['id'] as String?) ?? _uuid.v4(),
                portfolioId: (c['portfolio_id'] ?? c['portfolioId']) as String,
                ownerId: ownerId,
                amount: (c['amount'] as num).toInt(),
                date: c['date'] as String,
                note: Value(c['note'] as String?),
                createdAt:
                    ((c['created_at'] ?? c['createdAt']) as String?) ?? nowIso,
                updatedAt:
                    ((c['updated_at'] ?? c['updatedAt']) as String?) ?? nowIso,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }

      final isPercentPlans = schemaVersion >= 7 ||
          (decoded.containsKey('plans') &&
              plansJson.every((pl) => pl.containsKey('total_amount')));

      if (isPercentPlans) {
        for (final pl in plansJson) {
          final planId = (pl['id'] as String?) ?? _uuid.v4();
          await _db.into(_db.plans).insert(
                PlansCompanion.insert(
                  id: planId,
                  ownerId: ownerId,
                  name: pl['name'] as String,
                  description: Value(pl['description'] as String?),
                  totalAmount: Value(
                    ((pl['total_amount'] ?? pl['totalAmount']) as num?)
                            ?.toInt() ??
                        0,
                  ),
                  isActive: Value(
                    ((pl['is_active'] ?? pl['isActive']) as bool?) ?? false,
                  ),
                  sortOrder: Value(
                    ((pl['sort_order'] ?? pl['sortOrder']) as num?)?.toInt() ??
                        0,
                  ),
                  createdAt:
                      ((pl['created_at'] ?? pl['createdAt']) as String?) ??
                          nowIso,
                  updatedAt:
                      ((pl['updated_at'] ?? pl['updatedAt']) as String?) ??
                          nowIso,
                ),
              );

          final nestedAllocs = ((pl['allocations'] as List?) ?? const [])
              .cast<Map<String, dynamic>>();
          for (final a in nestedAllocs) {
            await _db.into(_db.planAllocations).insert(
                  PlanAllocationsCompanion.insert(
                    id: (a['id'] as String?) ?? _uuid.v4(),
                    planId: planId,
                    portfolioId:
                        (a['portfolio_id'] ?? a['portfolioId']) as String,
                    ownerId: ownerId,
                    sharePercentX100: Value(
                      ((a['share_percent_x100'] ?? a['sharePercentX100'])
                                  as num?)
                              ?.toInt() ??
                          0,
                    ),
                    createdAt: nowIso,
                    updatedAt: nowIso,
                  ),
                  mode: InsertMode.insertOrIgnore,
                );
          }
        }

        for (final a in allocationsJson) {
          final planId = (a['plan_id'] ?? a['planId']) as String?;
          if (planId == null) continue;
          await _db.into(_db.planAllocations).insert(
                PlanAllocationsCompanion.insert(
                  id: (a['id'] as String?) ?? _uuid.v4(),
                  planId: planId,
                  portfolioId:
                      (a['portfolio_id'] ?? a['portfolioId']) as String,
                  ownerId: ownerId,
                  sharePercentX100: Value(
                    ((a['share_percent_x100'] ?? a['sharePercentX100'])
                                as num?)
                            ?.toInt() ??
                        0,
                  ),
                  createdAt: nowIso,
                  updatedAt: nowIso,
                ),
                mode: InsertMode.insertOrIgnore,
              );
        }
      } else {
        final importedPortfolioIds = {
          for (final p in await _db.select(_db.portfolios).get()) p.id,
        };
        final allocsByPhase = <String, Map<String, int>>{};
        for (final a in allocationsJson) {
          final phId = (a['phase_id'] ?? a['phaseId']) as String?;
          final portoId = (a['portfolio_id'] ?? a['portfolioId']) as String?;
          if (phId == null ||
              portoId == null ||
              !importedPortfolioIds.contains(portoId)) {
            continue;
          }
          final amt =
              ((a['monthly_amount'] ?? a['monthlyAmount']) as num?)?.toInt() ??
                  0;
          allocsByPhase.putIfAbsent(phId, () => {})[portoId] = amt;
        }

        for (final ph in plansJson) {
          final phId = (ph['id'] as String?) ?? _uuid.v4();
          final amountsByPorto = allocsByPhase[phId] ?? const <String, int>{};
          final migrated = PlanPercentCalc.migrateNominalAmountsToPlanPercents(
            amountsByPorto,
          );
          await _db.into(_db.plans).insert(
                PlansCompanion.insert(
                  id: phId,
                  ownerId: ownerId,
                  name: ph['name'] as String,
                  description: Value(ph['description'] as String?),
                  totalAmount: Value(migrated.totalAmount),
                  isActive: Value(
                    ((ph['is_active'] ?? ph['isActive']) as bool?) ?? false,
                  ),
                  sortOrder: Value(
                    ((ph['sort_order'] ?? ph['sortOrder']) as num?)?.toInt() ??
                        0,
                  ),
                  createdAt:
                      ((ph['created_at'] ?? ph['createdAt']) as String?) ??
                          nowIso,
                  updatedAt:
                      ((ph['updated_at'] ?? ph['updatedAt']) as String?) ??
                          nowIso,
                ),
              );
          for (final entry in migrated.sharePercentX100ById.entries) {
            await _db.into(_db.planAllocations).insert(
                  PlanAllocationsCompanion.insert(
                    id: _uuid.v4(),
                    planId: phId,
                    portfolioId: entry.key,
                    ownerId: ownerId,
                    sharePercentX100: Value(entry.value),
                    createdAt: nowIso,
                    updatedAt: nowIso,
                  ),
                  mode: InsertMode.insertOrIgnore,
                );
          }
        }
      }

      for (final r in refsJson) {
        final String refName;
        if (r['name'] != null) {
          refName = r['name'] as String;
        } else {
          final grp = (r['groupName'] ?? r['group_name']) as String? ?? '';
          final lbl = (r['label'] as String?) ?? '';
          refName = grp.isNotEmpty && lbl.isNotEmpty
              ? '$grp — $lbl'
              : (lbl.isNotEmpty ? lbl : grp);
        }

        await _db.into(_db.priceReferences).insert(
              PriceReferencesCompanion.insert(
                id: (r['id'] as String?) ?? _uuid.v4(),
                ownerId: ownerId,
                name: refName,
                fullPrice:
                    ((r['full_price'] ?? r['fullPrice']) as num).toInt(),
                downPayment:
                    ((r['down_payment'] ?? r['downPayment']) as num).toInt(),
                fees: (r['fees'] as num).toInt(),
                note: Value(r['note'] as String?),
                sortOrder: Value(
                  ((r['sort_order'] ?? r['sortOrder']) as num?)?.toInt() ?? 0,
                ),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      }
    });
  }

  Future<void> resetToEmpty() => _db.resetToEmpty();
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(appDatabaseProvider));
});

