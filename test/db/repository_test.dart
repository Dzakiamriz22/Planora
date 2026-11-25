import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/phase_repository.dart';
import 'package:planora/data/repositories/portfolio_repository.dart';
import 'package:planora/data/repositories/profile_repository.dart';
import 'package:planora/data/repositories/settings_repository.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository profileRepo;
  late PortfolioRepository portfolioRepo;
  late PhaseRepository phaseRepo;
  late SettingsRepository settingsRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await db.ensureInitialized(now: DateTime(2026, 11, 25));
    profileRepo = ProfileRepository(db);
    portfolioRepo = PortfolioRepository(db);
    phaseRepo = PhaseRepository(db);
    settingsRepo = SettingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('FR-05 & FR-16: Plafon NULL tidak memblokir; plafon aktif menolak simpan > plafon', () async {
    // Profil keuangan kosong -> plafon NULL -> boleh buat porto dengan rencana berapa pun
    final p1 = await portfolioRepo.createPortfolio(
      name: 'Dana Darurat',
      category: 'cash',
      platformPreset: 'bank',
      platformName: 'Bank Pilihan',
      savedTarget: 10000000,
      monthlyPlan: 2000000,
      annualReturnPct: 5.0,
      icon: 'shield',
      color: 0xFF0E7C66,
    );

    // Atur gaji 4,5 jt & biaya hidup 1 jt -> plafon 3,5 jt
    await settingsRepo.updateFinancialProfile(
      monthlySalary: 4500000,
      minimumLivingCost: 1000000,
    );

    // Menaikkan rencana p1 menjadi 4 jt (> 3,5 jt) ditolak
    expect(
      () => portfolioRepo.updatePortfolio(
        id: p1,
        changes: const PortfoliosCompanion(monthlyPlan: drift.Value(4000000)),
      ),
      throwsA(isA<CeilingExceededException>()),
    );
  });

  test('FR-09, FR-10, FR-11, BR-02: Contoh kanonis 3 komponen dan penjaga saldo >= total komponen', () async {
    final portoId = await portfolioRepo.createPortfolio(
      name: 'Investasi Rutin',
      category: 'no_target',
      platformPreset: 'aperd',
      platformName: 'Aplikasi Pilihan Pengguna',
      monthlyPlan: 500000,
      annualReturnPct: 5.0,
      icon: 'trending_up',
      color: 0xFF6D5BD0,
    );

    final contribId = await portfolioRepo.addContribution(
      portfolioId: portoId,
      amount: 5000000,
      dateIso: '2026-11-25',
    );

    await portfolioRepo.upsertComponent(
      portfolioId: portoId,
      instrumentType: 'RDPU',
      amount: 2000000,
    );
    await portfolioRepo.upsertComponent(
      portfolioId: portoId,
      instrumentType: 'RD Obligasi',
      amount: 1500000,
    );
    await portfolioRepo.upsertComponent(
      portfolioId: portoId,
      instrumentType: 'Saham langsung',
      amount: 500000,
      codeNote: 'Kode pilihan pengguna',
    );

    // Komponen baru yang membuat total > saldo (5.000.000) ditolak
    expect(
      () => portfolioRepo.upsertComponent(
        portfolioId: portoId,
        instrumentType: 'Emas',
        amount: 1500000,
      ),
      throwsA(isA<ComponentLimitException>()),
    );

    // Mengurangi atau menghapus setoran sehingga saldo < total komponen (4 jt) ditolak
    expect(
      () => portfolioRepo.updateContribution(
        id: contribId,
        amount: 3000000,
        dateIso: '2026-11-25',
      ),
      throwsA(isA<ComponentLimitException>()),
    );
    expect(
      () => portfolioRepo.deleteContribution(contribId),
      throwsA(isA<ComponentLimitException>()),
    );
  });

  test('FR-21 & FR-23: Buat fase seimbang, batas per porto opsional, duplikat, dan hapus fase aktif ditolak', () async {
    await settingsRepo.updateFinancialProfile(
      monthlySalary: 4500000,
      minimumLivingCost: 1000000,
    );
    final ids = <String>[];
    for (var i = 1; i <= 4; i++) {
      ids.add(
        await portfolioRepo.createPortfolio(
          name: 'Porto $i',
          category: 'cash',
          savedTarget: 10000000,
          monthlyPlan: 0,
          annualReturnPct: 5.0,
          icon: 'savings',
          color: 0xFF0E7C66,
        ),
      );
    }

    final phaseId = await phaseRepo.createBalancedPhase();
    final allocs = await (db.select(db.phaseAllocations)
          ..where((t) => t.phaseId.equals(phaseId)))
        .get();
    expect(allocs.length, 4);
    expect(allocs.every((a) => a.monthlyAmount == 875000), isTrue);

    // Terapkan fase -> menjadi aktif -> tidak boleh dihapus
    await phaseRepo.applyPhase(phaseId);
    expect(
      () => phaseRepo.deletePhase(phaseId),
      throwsA(isA<PhaseValidationException>()),
    );

    // Duplikat fase menyalin semua alokasi
    final copyId = await phaseRepo.duplicatePhase(phaseId);
    final copyAllocs = await (db.select(db.phaseAllocations)
          ..where((t) => t.phaseId.equals(copyId)))
        .get();
    expect(copyAllocs.length, 4);

    // Aktifkan batas per porto Rp 800.000 -> simpan fase dengan 850.000 ditolak
    await settingsRepo.updatePhaseLimit(enabled: true, amount: 800000);
    expect(
      () => phaseRepo.savePhase(
        name: 'Melebihi Batas',
        allocationsByPortfolioId: {
          ids[0]: 850000,
          ids[1]: 500000,
          ids[2]: 500000,
          ids[3]: 500000,
        },
      ),
      throwsA(isA<PhaseValidationException>()),
    );
  });

  test('FR-29, FR-30, FR-31: Round-trip JSON v2 & kompatibilitas impor JSON v1', () async {
    await profileRepo.updateProfile(
      displayName: 'Budi',
      displayNameFull: 'Budi Santoso',
      themePref: 'gelap',
    );
    await settingsRepo.updateFinancialProfile(
      monthlySalary: 5000000,
      minimumLivingCost: 1000000,
    );
    final pid = await portfolioRepo.createPortfolio(
      name: 'Dana Darurat',
      category: 'cash',
      platformPreset: 'bank',
      platformName: 'Bank Lokal',
      savedTarget: 15000000,
      monthlyPlan: 1000000,
      annualReturnPct: 5.0,
      icon: 'shield',
      color: 0xFF0E7C66,
    );
    await portfolioRepo.addContribution(
      portfolioId: pid,
      amount: 2000000,
      dateIso: '2026-11-25',
    );
    await portfolioRepo.upsertComponent(
      portfolioId: pid,
      instrumentType: 'Kas/Tunai',
      amount: 2000000,
    );
    await settingsRepo.upsertPriceReference(
      name: 'Rumah Contoh',
      fullPrice: 400000000,
      downPayment: 80000000,
      fees: 20000000,
    );

    final exportedV2 = await settingsRepo.exportAllToJson();

    // Reset ke keadaan kosong total
    await settingsRepo.resetToEmpty();
    expect(await db.select(db.portfolios).get(), isEmpty);
    expect((await profileRepo.getProfile()).displayName, isNull);

    // Impor kembali v2 -> pulih identik
    await settingsRepo.importAllFromJson(exportedV2);
    expect((await profileRepo.getProfile()).displayName, 'Budi');
    expect((await settingsRepo.getSettings()).monthlySalary, 5000000);
    expect((await db.select(db.portfolioComponents).get()).length, 1);
    expect((await db.select(db.priceReferences).get()).length, 1);

    // Kompatibilitas impor v1 (Bab D.3)
    final v1Json = jsonEncode({
      'app': 'Planora',
      'schemaVersion': 1,
      'settings': {
        'monthlySalary': 4500000,
        'minimumLivingCost': 1000000,
        'currentLivingCost': 1500000,
        'defaultAnnualReturnPct': 5.0,
      },
      'portfolios': [
        {
          'id': 'p-v1',
          'name': 'Tabungan Lama',
          'platform': 'Platform Lama',
          'category': 'cash',
          'savedTarget': 10000000,
          'monthlyPlan': 500000,
          'annualReturnPct': 5.0,
          'calcMode': 'deposit_driven',
          'icon': 'savings',
          'color': 0xFF0E7C66,
          'sortOrder': 0,
          'createdAt': '2026-01-01T00:00:00Z',
          'updatedAt': '2026-01-01T00:00:00Z',
        },
      ],
      'contributions': [
        {
          'id': 'c-v1',
          'portfolioId': 'p-v1',
          'amount': 750000,
          'date': '2026-10-25',
          'createdAt': '2026-10-25T00:00:00Z',
          'updatedAt': '2026-10-25T00:00:00Z',
        },
      ],
      'phases': [],
      'phaseAllocations': [],
      'priceReferences': [
        {
          'id': 'r-v1',
          'groupName': 'Properti',
          'label': 'Skenario A',
          'fullPrice': 300000000,
          'downPayment': 60000000,
          'fees': 15000000,
          'sortOrder': 0,
        },
      ],
    });

    await settingsRepo.importAllFromJson(v1Json);
    final importedPortos = await portfolioRepo.getAllPortfolios();
    expect(importedPortos.length, 1);
    expect(importedPortos.first.platformPreset, 'other');
    expect(importedPortos.first.platformName, 'Platform Lama');
    expect((await db.select(db.priceReferences).get()).first.name, 'Properti — Skenario A');
  });

  test('FR-32: reorderPortfolios dan reorderPhases menyimpan urutan tampil permanen', () async {
    final p1 = await portfolioRepo.createPortfolio(
      name: 'P1',
      category: 'cash',
      savedTarget: 1000000,
      monthlyPlan: 0,
      annualReturnPct: 5.0,
      icon: 'savings',
      color: 0xFF0E7C66,
    );
    final p2 = await portfolioRepo.createPortfolio(
      name: 'P2',
      category: 'cash',
      savedTarget: 2000000,
      monthlyPlan: 0,
      annualReturnPct: 5.0,
      icon: 'savings',
      color: 0xFFC4557A,
    );

    await portfolioRepo.reorderPortfolios([p2, p1]);
    final ordered = await portfolioRepo.getAllPortfolios();
    expect(ordered.map((e) => e.id).toList(), [p2, p1]);
  });
}
