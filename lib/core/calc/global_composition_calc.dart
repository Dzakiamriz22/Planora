import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/calc/stock_lot_calc.dart';

class GlobalComponentInput {
  const GlobalComponentInput({
    required this.portfolioId,
    required this.portfolioName,
    required this.portfolioColor,
    required this.isNoTarget,
    required this.portfolioTargetTotal,
    required this.instrumentType,
    required this.actualAmount,
    required this.targetPercent,
    this.isLotBased = false,
  });

  final String portfolioId;
  final String portfolioName;
  final int portfolioColor;
  final bool isNoTarget;
  final int portfolioTargetTotal;
  final String instrumentType;
  final int actualAmount;
  final double targetPercent;
  final bool isLotBased;
}

class InstrumentPortfolioBreakdown {
  const InstrumentPortfolioBreakdown({
    required this.portfolioId,
    required this.portfolioName,
    required this.portfolioColor,
    required this.actualAmount,
    required this.targetPercentInPortfolio,
    required this.targetAmountInPortfolio,
    required this.isNoTarget,
  });

  final String portfolioId;
  final String portfolioName;
  final int portfolioColor;
  final int actualAmount;
  final double targetPercentInPortfolio;
  final int targetAmountInPortfolio;
  final bool isNoTarget;
}

class GlobalStockTickerBreakdown {
  const GlobalStockTickerBreakdown({
    required this.ticker,
    required this.totalLots,
    required this.totalShares,
    required this.totalModal,
    required this.averagePrice,
    required this.percentOfTotalStock,
  });

  final String ticker;
  final int totalLots;
  final int totalShares;
  final int totalModal;
  final double averagePrice;
  final double percentOfTotalStock;
}

class GlobalInstrumentSlice {
  const GlobalInstrumentSlice({
    required this.instrumentType,
    required this.actualAmount,
    required this.actualPercent,
    required this.targetAmount,
    required this.weightedTargetPercent,
    required this.diffPoints,
    required this.isSignificantDeviation,
    required this.isLotBased,
    required this.portfolios,
  });

  final String instrumentType;
  final int actualAmount;
  final double actualPercent;
  final int targetAmount;
  final double weightedTargetPercent;
  final double diffPoints;
  final bool isSignificantDeviation;
  final bool isLotBased;
  final List<InstrumentPortfolioBreakdown> portfolios;
}

class GlobalCompositionSummary {
  const GlobalCompositionSummary({
    required this.totalActualBalance,
    required this.totalTargetedBalance,
    required this.hasTargetedPortfolios,
    required this.hasNoTargetPortfolios,
    required this.slices,
    required this.stockTickers,
  });

  final int totalActualBalance;
  final int totalTargetedBalance;
  final bool hasTargetedPortfolios;
  final bool hasNoTargetPortfolios;
  final List<GlobalInstrumentSlice> slices;
  final List<GlobalStockTickerBreakdown> stockTickers;

  bool get isEmpty => slices.isEmpty;
}

class GlobalCompositionCalc {
  GlobalCompositionCalc._();

  /// Menggabungkan komposisi instrumen lintas seluruh portofolio:
  /// - Persen aktual global = subtotal aktual instrumen / total saldo semua porto (total tepat 100%)
  /// - Persen target global tertimbang = jumlah target rupiah instrumen / total target porto bertarget
  ///   (mengecualikan porto Tanpa Target; total tepat 100% bila ada target)
  static GlobalCompositionSummary compute({
    required List<GlobalComponentInput> components,
    List<StockTxRecord> allStockTransactions = const [],
  }) {
    if (components.isEmpty) {
      return const GlobalCompositionSummary(
        totalActualBalance: 0,
        totalTargetedBalance: 0,
        hasTargetedPortfolios: false,
        hasNoTargetPortfolios: false,
        slices: [],
        stockTickers: [],
      );
    }

    // Normalisasi nama instrumen case-insensitive, pertahankan label pertama
    final canonicalLabel = <String, String>{};
    final actualByNorm = <String, int>{};
    final targetByNorm = <String, int>{};
    final isLotByNorm = <String, bool>{};
    final breakdownByNorm = <String, List<InstrumentPortfolioBreakdown>>{};

    var totalActual = 0;
    var hasTargeted = false;
    var hasNoTarget = false;
    final targetedPortfolioTargets = <String, int>{};

    for (final c in components) {
      final trimmed = c.instrumentType.trim().isEmpty
          ? 'Lainnya'
          : c.instrumentType.trim();
      final norm = trimmed.toLowerCase();
      canonicalLabel.putIfAbsent(norm, () => trimmed);
      isLotByNorm[norm] = (isLotByNorm[norm] ?? false) || c.isLotBased;

      final safeActual = c.actualAmount < 0 ? 0 : c.actualAmount;
      actualByNorm[norm] = (actualByNorm[norm] ?? 0) + safeActual;
      totalActual += safeActual;

      final isEligibleTarget = !c.isNoTarget && c.portfolioTargetTotal > 0;
      int targetAmt = 0;
      if (isEligibleTarget) {
        hasTargeted = true;
        targetedPortfolioTargets[c.portfolioId] = c.portfolioTargetTotal;
        targetAmt = PlanoraV22Calc.targetAmountFromPercent(
          targetPercent: c.targetPercent,
          portfolioTargetTotal: c.portfolioTargetTotal,
        );
        targetByNorm[norm] = (targetByNorm[norm] ?? 0) + targetAmt;
      } else {
        hasNoTarget = true;
      }

      breakdownByNorm.putIfAbsent(norm, () => []).add(
            InstrumentPortfolioBreakdown(
              portfolioId: c.portfolioId,
              portfolioName: c.portfolioName,
              portfolioColor: c.portfolioColor,
              actualAmount: safeActual,
              targetPercentInPortfolio: c.targetPercent,
              targetAmountInPortfolio: targetAmt,
              isNoTarget: !isEligibleTarget,
            ),
          );
    }

    final totalTargeted =
        targetedPortfolioTargets.values.fold<int>(0, (s, v) => s + v);
    final sumTargetComponents =
        targetByNorm.values.fold<int>(0, (s, v) => s + v);

    final actualPctByNorm = _exactPercentMap(actualByNorm, totalActual);
    final targetPctByNorm = _exactPercentMap(
      targetByNorm,
      sumTargetComponents > 0 ? sumTargetComponents : totalTargeted,
    );

    final keys = canonicalLabel.keys.toList()
      ..sort((a, b) {
        final cmpAct = (actualByNorm[b] ?? 0).compareTo(actualByNorm[a] ?? 0);
        if (cmpAct != 0) return cmpAct;
        return (targetByNorm[b] ?? 0).compareTo(targetByNorm[a] ?? 0);
      });

    final slices = <GlobalInstrumentSlice>[];
    for (final norm in keys) {
      final actAmt = actualByNorm[norm] ?? 0;
      final tgtAmt = targetByNorm[norm] ?? 0;
      final actPct = actualPctByNorm[norm] ?? 0.0;
      final tgtPct = targetPctByNorm[norm] ?? 0.0;
      final diff = (totalActual > 0 && hasTargeted)
          ? PlanoraV22Calc.round2(actPct - tgtPct)
          : 0.0;
      final portfolios = breakdownByNorm[norm] ?? const [];
      portfolios.sort((a, b) => b.actualAmount.compareTo(a.actualAmount));

      slices.add(
        GlobalInstrumentSlice(
          instrumentType: canonicalLabel[norm]!,
          actualAmount: actAmt,
          actualPercent: actPct,
          targetAmount: tgtAmt,
          weightedTargetPercent: tgtPct,
          diffPoints: diff,
          isSignificantDeviation:
              totalActual > 0 && hasTargeted && diff.abs() > 10.0,
          isLotBased: isLotByNorm[norm] ?? false,
          portfolios: List.unmodifiable(portfolios),
        ),
      );
    }

    // Agregasi rincian kode saham lintas semua portofolio
    final stockTickers = _computeStockTickers(allStockTransactions);

    return GlobalCompositionSummary(
      totalActualBalance: totalActual,
      totalTargetedBalance: totalTargeted,
      hasTargetedPortfolios: hasTargeted,
      hasNoTargetPortfolios: hasNoTarget,
      slices: List.unmodifiable(slices),
      stockTickers: stockTickers,
    );
  }

  static Map<String, double> _exactPercentMap(
    Map<String, int> amountByKey,
    int total,
  ) {
    if (total <= 0 || amountByKey.isEmpty) {
      return {for (final k in amountByKey.keys) k: 0.0};
    }

    final result = <String, double>{};
    var sumPct = 0.0;
    String? largestKey;
    var largestAmt = -1;

    for (final entry in amountByKey.entries) {
      final pct = PlanoraV22Calc.round2((entry.value / total) * 100.0);
      result[entry.key] = pct;
      sumPct = PlanoraV22Calc.round2(sumPct + pct);
      if (entry.value > largestAmt) {
        largestAmt = entry.value;
        largestKey = entry.key;
      }
    }

    if (largestKey != null && largestAmt > 0) {
      final diff = PlanoraV22Calc.round2(100.0 - sumPct);
      if (diff.abs() > 0.0001) {
        result[largestKey] = PlanoraV22Calc.round2(
          (result[largestKey]! + diff).clamp(0.0, 100.0),
        );
      }
    }
    return result;
  }

  static List<GlobalStockTickerBreakdown> _computeStockTickers(
    List<StockTxRecord> txs,
  ) {
    if (txs.isEmpty) return const [];
    final ledger = StockLotCalc.computeLedger(txs, validateStrict: false);
    if (ledger.activePositions.isEmpty) {
      return const [];
    }
    final totalModal = ledger.activePositions.fold<int>(
      0,
      (sum, pos) => sum + pos.totalModal,
    );
    if (totalModal <= 0) {
      return const [];
    }
    return ledger.activePositions.map((pos) {
      return GlobalStockTickerBreakdown(
        ticker: pos.ticker,
        totalLots: pos.totalLots,
        totalShares: pos.totalShares,
        totalModal: pos.totalModal,
        averagePrice: pos.averagePrice,
        percentOfTotalStock:
            PlanoraV22Calc.round2((pos.totalModal / totalModal) * 100.0),
      );
    }).toList(growable: false);
  }
}
