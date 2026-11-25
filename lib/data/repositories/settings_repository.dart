import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> updatePhaseLimit({
    required bool enabled,
    int? amount,
  }) async {
    final current = await getSettings();
    await (_db.update(_db.settings)..where((t) => t.id.equals(current.id)))
        .write(
      SettingsCompanion(
        phaseLimitEnabled: Value(enabled),
        phaseLimitAmount: Value(enabled ? amount : null),
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

  /// Ekspor seluruh data lokal Planora dalam format JSON schema_version 2 (FR-29, Bab D.3).
  Future<String> exportAllToJson() async {
    final profile = await _db.select(_db.userProfiles).getSingle();
    final settingsRow = await getSettings();
    final portfolios = await _db.select(_db.portfolios).get();
    final components = await _db.select(_db.portfolioComponents).get();
    final contributions = await _db.select(_db.contributions).get();
    final phases = await _db.select(_db.phases).get();
    final allocations = await _db.select(_db.phaseAllocations).get();
    final refs = await _db.select(_db.priceReferences).get();

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
      'schema_version': 2,
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
        'phase_limit_enabled': settingsRow.phaseLimitEnabled,
        'phase_limit_amount': settingsRow.phaseLimitAmount,
        'onboarding_done': settingsRow.onboardingDone,
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
                      'amount': comp.amount,
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
                      'created_at': c.createdAt,
                      'updated_at': c.updatedAt,
                    },
                  )
                  .toList(),
            },
          )
          .toList(),
      'phases': phases
          .map(
            (ph) => {
              'id': ph.id,
              'name': ph.name,
              'description': ph.description,
              'is_active': ph.isActive,
              'sort_order': ph.sortOrder,
              'created_at': ph.createdAt,
              'updated_at': ph.updatedAt,
            },
          )
          .toList(),
      'phase_allocations': allocations
          .map(
            (a) => {
              'id': a.id,
              'phase_id': a.phaseId,
              'portfolio_id': a.portfolioId,
              'monthly_amount': a.monthlyAmount,
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

  /// Impor JSON format v2 dan kompatibel mundur format v1 dalam satu transaksi (FR-30, Bab D.3).
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
    final phasesJson = ((decoded['phases'] as List?) ?? const [])
        .cast<Map<String, dynamic>>();
    final allocationsJson = ((decoded['phase_allocations'] ??
            decoded['phaseAllocations'] ??
            const []) as List)
        .cast<Map<String, dynamic>>();
    final refsJson = ((decoded['price_references'] ??
            decoded['priceReferences'] ??
            const []) as List)
        .cast<Map<String, dynamic>>();

    await _db.transaction(() async {
      await _db.delete(_db.phaseAllocations).go();
      await _db.delete(_db.portfolioComponents).go();
      await _db.delete(_db.contributions).go();
      await _db.delete(_db.phases).go();
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
              phaseLimitEnabled: Value(
                (settingsJson['phase_limit_enabled'] as bool?) ?? false,
              ),
              phaseLimitAmount: Value(
                (settingsJson['phase_limit_amount'] as num?)?.toInt(),
              ),
              onboardingDone: Value(
                (settingsJson['onboarding_done'] as bool?) ?? true,
              ),
              seedVersion: const Value(3),
              createdAt: nowIso,
              updatedAt: nowIso,
            ),
          );

      for (final p in portfoliosJson) {
        final pid = (p['id'] as String?) ?? _uuid.v4();

        // Pemetaan platform v1 -> v2 (Bab D.3): field platform teks v1 -> preset 'other' + platformName
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

        // Nested components (v2)
        final nestedComps = ((p['components'] as List?) ?? const [])
            .cast<Map<String, dynamic>>();
        for (var i = 0; i < nestedComps.length; i++) {
          final comp = nestedComps[i];
          await _db.into(_db.portfolioComponents).insert(
                PortfolioComponentsCompanion.insert(
                  id: (comp['id'] as String?) ?? _uuid.v4(),
                  portfolioId: pid,
                  ownerId: ownerId,
                  instrumentType: comp['instrument_type'] as String,
                  name: Value(comp['name'] as String?),
                  amount: (comp['amount'] as num).toInt(),
                  codeNote: Value(comp['code_note'] as String?),
                  sortOrder: Value((comp['sort_order'] as num?)?.toInt() ?? i),
                  createdAt: nowIso,
                  updatedAt: nowIso,
                ),
              );
        }

        // Nested contributions (v2)
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
                  createdAt:
                      ((c['created_at'] ?? c['createdAt']) as String?) ?? nowIso,
                  updatedAt:
                      ((c['updated_at'] ?? c['updatedAt']) as String?) ?? nowIso,
                ),
              );
        }
      }

      // Top-level contributions (kompatibilitas v1)
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

      for (final ph in phasesJson) {
        await _db.into(_db.phases).insert(
              PhasesCompanion.insert(
                id: (ph['id'] as String?) ?? _uuid.v4(),
                ownerId: ownerId,
                name: ph['name'] as String,
                description: Value(ph['description'] as String?),
                isActive: Value(
                  ((ph['is_active'] ?? ph['isActive']) as bool?) ?? false,
                ),
                sortOrder: Value(
                  ((ph['sort_order'] ?? ph['sortOrder']) as num?)?.toInt() ?? 0,
                ),
                createdAt:
                    ((ph['created_at'] ?? ph['createdAt']) as String?) ??
                        nowIso,
                updatedAt:
                    ((ph['updated_at'] ?? ph['updatedAt']) as String?) ??
                        nowIso,
              ),
            );
      }

      for (final a in allocationsJson) {
        await _db.into(_db.phaseAllocations).insert(
              PhaseAllocationsCompanion.insert(
                id: (a['id'] as String?) ?? _uuid.v4(),
                phaseId: (a['phase_id'] ?? a['phaseId']) as String,
                portfolioId: (a['portfolio_id'] ?? a['portfolioId']) as String,
                ownerId: ownerId,
                monthlyAmount: Value(
                  ((a['monthly_amount'] ?? a['monthlyAmount']) as num?)
                          ?.toInt() ??
                      0,
                ),
                createdAt: nowIso,
                updatedAt: nowIso,
              ),
            );
      }

      for (final r in refsJson) {
        // Pemetaan v1 (groupName + label) -> v2 (name)
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
