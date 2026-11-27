import 'package:flutter_test/flutter_test.dart';
import 'package:planora/core/calc/global_composition_calc.dart';
import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';

void main() {
  group('v3.2 — GlobalCompositionCalc (Persentase Instrumen Global)', () {
    test(
      'Persen aktual global = subtotal / total saldo (bukan rata-rata antarporto) dan total tepat 100%',
      () {
        // Porto A (besar): saldo 9.000.000 -> RDPU 3.000.000, Obligasi 6.000.000
        // Porto B (kecil): saldo 1.000.000 -> RDPU 1.000.000
        // Total global = 10.000.000 -> RDPU = 4.000.000 (40%), Obligasi = 6.000.000 (60%)
        // (Kalau rata-rata persen antarporto bakal salah jadi 66,7% vs 33,3%)
        final summary = GlobalCompositionCalc.compute(
          components: const [
            GlobalComponentInput(
              portfolioId: 'p1',
              portfolioName: 'Rumah',
              portfolioColor: 0xFF0E7C66,
              isNoTarget: false,
              portfolioTargetTotal: 100000000,
              instrumentType: 'RDPU',
              actualAmount: 3000000,
              targetPercent: 30,
            ),
            GlobalComponentInput(
              portfolioId: 'p1',
              portfolioName: 'Rumah',
              portfolioColor: 0xFF0E7C66,
              isNoTarget: false,
              portfolioTargetTotal: 100000000,
              instrumentType: 'RD Obligasi',
              actualAmount: 6000000,
              targetPercent: 70,
            ),
            GlobalComponentInput(
              portfolioId: 'p2',
              portfolioName: 'Darurat',
              portfolioColor: 0xFF2F6DB3,
              isNoTarget: false,
              portfolioTargetTotal: 25000000,
              instrumentType: 'RDPU',
              actualAmount: 1000000,
              targetPercent: 100,
            ),
          ],
        );

        expect(summary.totalActualBalance, 10000000);
        expect(summary.totalTargetedBalance, 125000000);
        expect(summary.hasTargetedPortfolios, isTrue);
        expect(summary.hasNoTargetPortfolios, isFalse);

        final rdpu = summary.slices.firstWhere((s) => s.instrumentType == 'RDPU');
        final obli =
            summary.slices.firstWhere((s) => s.instrumentType == 'RD Obligasi');

        expect(rdpu.actualAmount, 4000000);
        expect(rdpu.actualPercent, 40.0);
        expect(obli.actualAmount, 6000000);
        expect(obli.actualPercent, 60.0);

        // Target tertimbang: RDPU = 30jt + 25jt = 55jt / 125jt = 44%; Obligasi = 70jt / 125jt = 56%
        expect(rdpu.targetAmount, 55000000);
        expect(rdpu.weightedTargetPercent, 44.0);
        expect(obli.targetAmount, 70000000);
        expect(obli.weightedTargetPercent, 56.0);

        // Total aktual & target tepat 100%
        expect(
          PlanoraV22Calc.isExact100(summary.slices.map((s) => s.actualPercent)),
          isTrue,
        );
        expect(
          PlanoraV22Calc.isExact100(
            summary.slices.map((s) => s.weightedTargetPercent),
          ),
          isTrue,
        );
      },
    );

    test(
      'Target global tertimbang mengecualikan porto Tanpa Target; aktual tetap menyertakannya',
      () {
        final summary = GlobalCompositionCalc.compute(
          components: const [
            GlobalComponentInput(
              portfolioId: 'p1',
              portfolioName: 'Rumah',
              portfolioColor: 0xFF0E7C66,
              isNoTarget: false,
              portfolioTargetTotal: 100000000,
              instrumentType: 'RD Obligasi',
              actualAmount: 5000000,
              targetPercent: 100,
            ),
            GlobalComponentInput(
              portfolioId: 'p2',
              portfolioName: 'Saham Bebas',
              portfolioColor: 0xFFC026D3,
              isNoTarget: true,
              portfolioTargetTotal: 0,
              instrumentType: 'Saham langsung',
              actualAmount: 5000000,
              targetPercent: 100,
              isLotBased: true,
            ),
          ],
        );

        expect(summary.hasTargetedPortfolios, isTrue);
        expect(summary.hasNoTargetPortfolios, isTrue);
        expect(summary.totalActualBalance, 10000000);
        expect(summary.totalTargetedBalance, 100000000);

        final obli =
            summary.slices.firstWhere((s) => s.instrumentType == 'RD Obligasi');
        final saham = summary.slices
            .firstWhere((s) => s.instrumentType == 'Saham langsung');

        // Aktual: 50% / 50%
        expect(obli.actualPercent, 50.0);
        expect(saham.actualPercent, 50.0);
        // Target tertimbang: hanya p1 -> Obligasi 100%, Saham 0%
        expect(obli.weightedTargetPercent, 100.0);
        expect(saham.weightedTargetPercent, 0.0);
        // Deviasi > 10 poin terdeteksi
        expect(saham.isSignificantDeviation, isTrue);
      },
    );

    test('Saldo total nol menghasilkan keadaan kosong wajar tanpa NaN', () {
      final summary = GlobalCompositionCalc.compute(
        components: const [
          GlobalComponentInput(
            portfolioId: 'p1',
            portfolioName: 'Darurat',
            portfolioColor: 0xFF0E7C66,
            isNoTarget: false,
            portfolioTargetTotal: 10000000,
            instrumentType: 'RDPU',
            actualAmount: 0,
            targetPercent: 60,
          ),
          GlobalComponentInput(
            portfolioId: 'p1',
            portfolioName: 'Darurat',
            portfolioColor: 0xFF0E7C66,
            isNoTarget: false,
            portfolioTargetTotal: 10000000,
            instrumentType: 'Kas/Tunai',
            actualAmount: 0,
            targetPercent: 40,
          ),
        ],
      );

      expect(summary.totalActualBalance, 0);
      for (final s in summary.slices) {
        expect(s.actualPercent, 0.0);
        expect(s.actualPercent.isNaN, isFalse);
        expect(s.isSignificantDeviation, isFalse);
      }
      expect(summary.slices.first.weightedTargetPercent, 60.0);
    });

    test(
      'Saham tampil sebagai satu instrumen di level global; rincian per kode di stockTickers',
      () {
        final summary = GlobalCompositionCalc.compute(
          components: const [
            GlobalComponentInput(
              portfolioId: 'p1',
              portfolioName: 'Porto Saham',
              portfolioColor: 0xFFC026D3,
              isNoTarget: true,
              portfolioTargetTotal: 0,
              instrumentType: 'Saham langsung',
              actualAmount: 4000000,
              targetPercent: 100,
              isLotBased: true,
            ),
          ],
          allStockTransactions: const [
            StockTxRecord(
              id: 't1',
              ticker: 'ADRO',
              side: StockLotCalc.sideBuy,
              lots: 10,
              shares: 1000,
              pricePerShare: 2000,
              totalAmount: 2000000,
              transactionDate: '2026-10-01',
              createdAt: '2026-10-01T00:00:00Z',
            ),
            StockTxRecord(
              id: 't2',
              ticker: 'BBCA',
              side: StockLotCalc.sideBuy,
              lots: 2,
              shares: 200,
              pricePerShare: 10000,
              totalAmount: 2000000,
              transactionDate: '2026-10-02',
              createdAt: '2026-10-02T00:00:00Z',
            ),
          ],
        );

        expect(summary.slices.length, 1);
        expect(summary.slices.single.instrumentType, 'Saham langsung');
        expect(summary.stockTickers.length, 2);
        expect(summary.stockTickers.first.percentOfTotalStock, 50.0);
        expect(summary.stockTickers.last.percentOfTotalStock, 50.0);
      },
    );
  });
}
