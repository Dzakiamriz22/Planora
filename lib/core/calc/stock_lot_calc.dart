import 'dart:math' as math;

import 'package:planora/core/calc/planora_v22_calc.dart';

class StockValidationException implements Exception {
  StockValidationException(this.message);
  final String message;

  @override
  String toString() => message;
}

class StockTxRecord {
  const StockTxRecord({
    required this.id,
    required this.ticker,
    required this.side,
    required this.lots,
    required this.shares,
    required this.pricePerShare,
    required this.totalAmount,
    required this.transactionDate,
    required this.createdAt,
  });

  final String id;
  final String ticker;
  final String side; // 'buy' | 'sell'
  final int lots;
  final int shares;
  final int pricePerShare;
  final int totalAmount;
  final String transactionDate;
  final String createdAt;
}

class StockPosition {
  const StockPosition({
    required this.ticker,
    required this.totalLots,
    required this.totalShares,
    required this.totalModal,
    required this.averagePrice,
  });

  final String ticker;
  final int totalLots;
  final int totalShares;
  final int totalModal;
  final double averagePrice;

  bool get isOpen => totalLots > 0;
}

class StockLedgerComputation {
  const StockLedgerComputation({
    required this.positionsByTicker,
    required this.activePositions,
    required this.totalPositionsModal,
    required this.totalActiveLots,
    required this.sellExitModalByTxId,
  });

  final Map<String, StockPosition> positionsByTicker;
  final List<StockPosition> activePositions;
  final int totalPositionsModal;
  final int totalActiveLots;
  final Map<String, int> sellExitModalByTxId;
}

class StockLotCalc {
  StockLotCalc._();

  static const int sharesPerLot = 100;
  static const String mechanismNominal = 'nominal';
  static const String mechanismLotBased = 'lot_based';
  static const String sideBuy = 'buy';
  static const String sideSell = 'sell';
  static const String sourceManual = 'manual';
  static const String sourceStockBuy = 'stock_buy';
  static const String sourceStockSell = 'stock_sell';

  static final RegExp _tickerPattern = RegExp(r'^[A-Z0-9]{4}$');

  static bool isDirectStockInstrument(String instrumentType) {
    return instrumentType.trim().toLowerCase() == 'saham langsung';
  }

  static String defaultMechanismForInstrument(String instrumentType) {
    return isDirectStockInstrument(instrumentType)
        ? mechanismLotBased
        : mechanismNominal;
  }

  static String normalizeTicker(String raw) => raw.trim().toUpperCase();

  static String? validateTicker(String raw) {
    final norm = normalizeTicker(raw);
    if (norm.isEmpty) {
      return 'Kode saham wajib diisi.';
    }
    if (!_tickerPattern.hasMatch(norm)) {
      return 'Kode saham harus tepat 4 karakter huruf atau angka (contoh: BBCA).';
    }
    return null;
  }

  static String? validateLotsText(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return 'Jumlah lot wajib diisi.';
    }
    if (trimmed.contains('.') || trimmed.contains(',')) {
      return 'Jumlah lot harus bilangan bulat, tanpa desimal.';
    }
    final parsed = int.tryParse(trimmed);
    if (parsed == null || parsed < 1) {
      return 'Jumlah lot minimal 1 lot.';
    }
    return null;
  }

  static String? validateLots(int? lots) {
    if (lots == null || lots < 1) {
      return 'Jumlah lot minimal 1 lot.';
    }
    return null;
  }

  static String? validateSellLots({
    required int? lots,
    required int availableLots,
  }) {
    final baseErr = validateLots(lots);
    if (baseErr != null) return baseErr;
    if (availableLots <= 0) {
      return 'Tidak ada posisi lot yang tersedia untuk dijual.';
    }
    if (lots! > availableLots) {
      return 'Lot jual melebihi posisi saat ini (tersedia $availableLots lot).';
    }
    return null;
  }

  static String? validatePricePerShare(int? pricePerShare) {
    if (pricePerShare == null || pricePerShare <= 0) {
      return 'Harga per lembar harus lebih dari Rp 0.';
    }
    return null;
  }

  static String? validateTransactionDate(DateTime date, {DateTime? now}) {
    final ref = now ?? DateTime.now();
    final today = DateTime(ref.year, ref.month, ref.day);
    final candidate = DateTime(date.year, date.month, date.day);
    if (candidate.isAfter(today)) {
      return 'Tanggal transaksi tidak boleh di masa depan.';
    }
    return null;
  }

  static int sharesFromLots(int lots) {
    if (lots < 0) return 0;
    return lots * sharesPerLot;
  }

  static int transactionModal({
    required int lots,
    required int pricePerShare,
  }) {
    if (lots <= 0 || pricePerShare <= 0) return 0;
    return sharesFromLots(lots) * pricePerShare;
  }

  static void validateSnapshots({
    required int lots,
    required int shares,
    required int pricePerShare,
    required int totalAmount,
  }) {
    final lotErr = validateLots(lots);
    if (lotErr != null) throw StockValidationException(lotErr);
    final priceErr = validatePricePerShare(pricePerShare);
    if (priceErr != null) throw StockValidationException(priceErr);

    final expectedShares = sharesFromLots(lots);
    if (shares != expectedShares) {
      throw StockValidationException(
        'Snapshot lembar tidak cocok ($shares != $expectedShares).',
      );
    }
    final expectedTotal = expectedShares * pricePerShare;
    if (totalAmount != expectedTotal) {
      throw StockValidationException(
        'Snapshot total modal tidak cocok ($totalAmount != $expectedTotal).',
      );
    }
  }

  static ({
    int modalKeluar,
    int modalSisa,
    int lotsSisa,
    int sharesSisa,
    double averagePriceSisa,
  }) computeSellAverageCost({
    required int currentLots,
    required int currentModal,
    required int sellLots,
  }) {
    if (sellLots <= 0 || currentLots <= 0 || sellLots > currentLots) {
      throw StockValidationException(
        'Lot jual ($sellLots) melebihi posisi tersedia ($currentLots lot).',
      );
    }
    if (sellLots == currentLots) {
      return (
        modalKeluar: currentModal,
        modalSisa: 0,
        lotsSisa: 0,
        sharesSisa: 0,
        averagePriceSisa: 0.0,
      );
    }

    final currentShares = sharesFromLots(currentLots);
    final sellShares = sharesFromLots(sellLots);
    final exactAvgBefore = currentModal / currentShares;
    final modalKeluar = (sellShares * exactAvgBefore).round().clamp(
          0,
          currentModal,
        );
    final modalSisa = currentModal - modalKeluar;
    final lotsSisa = currentLots - sellLots;
    final sharesSisa = sharesFromLots(lotsSisa);
    final avgSisa = PlanoraV22Calc.round2(exactAvgBefore);

    return (
      modalKeluar: modalKeluar,
      modalSisa: modalSisa,
      lotsSisa: lotsSisa,
      sharesSisa: sharesSisa,
      averagePriceSisa: avgSisa,
    );
  }

  static StockLedgerComputation computeLedger(
    Iterable<StockTxRecord> transactions, {
    bool validateStrict = true,
  }) {
    final sorted = transactions.toList()
      ..sort((a, b) {
        final byDate = a.transactionDate.compareTo(b.transactionDate);
        if (byDate != 0) return byDate;
        final byCreated = a.createdAt.compareTo(b.createdAt);
        if (byCreated != 0) return byCreated;
        if (a.side != b.side) {
          return a.side == sideBuy ? -1 : 1;
        }
        return a.id.compareTo(b.id);
      });

    final lotsByTicker = <String, int>{};
    final modalByTicker = <String, int>{};
    final avgByTicker = <String, double>{};
    final sellExitModalByTxId = <String, int>{};

    for (final tx in sorted) {
      final ticker = normalizeTicker(tx.ticker);
      if (validateStrict) {
        final tErr = validateTicker(ticker);
        if (tErr != null) throw StockValidationException(tErr);
        validateSnapshots(
          lots: tx.lots,
          shares: tx.shares,
          pricePerShare: tx.pricePerShare,
          totalAmount: tx.totalAmount,
        );
      }

      final curLots = lotsByTicker[ticker] ?? 0;
      final curModal = modalByTicker[ticker] ?? 0;

      if (tx.side == sideBuy) {
        final nextLots = curLots + tx.lots;
        final nextModal = curModal + tx.totalAmount;
        lotsByTicker[ticker] = nextLots;
        modalByTicker[ticker] = nextModal;
        avgByTicker[ticker] = nextLots > 0
            ? PlanoraV22Calc.round2(nextModal / sharesFromLots(nextLots))
            : 0.0;
      } else if (tx.side == sideSell) {
        if (tx.lots > curLots) {
          throw StockValidationException(
            'Transaksi jual $ticker (${tx.lots} lot) melebihi lot tersedia ($curLots lot).',
          );
        }
        final sellRes = computeSellAverageCost(
          currentLots: curLots,
          currentModal: curModal,
          sellLots: tx.lots,
        );
        lotsByTicker[ticker] = sellRes.lotsSisa;
        modalByTicker[ticker] = sellRes.modalSisa;
        avgByTicker[ticker] = sellRes.averagePriceSisa;
        sellExitModalByTxId[tx.id] = sellRes.modalKeluar;
      } else {
        throw StockValidationException(
          'Sisi transaksi saham tidak dikenal: ${tx.side}.',
        );
      }
    }

    final positions = <String, StockPosition>{};
    final active = <StockPosition>[];
    var totalModal = 0;
    var totalLots = 0;

    for (final ticker in lotsByTicker.keys) {
      final lots = lotsByTicker[ticker] ?? 0;
      final shares = sharesFromLots(lots);
      final modal = modalByTicker[ticker] ?? 0;
      final avg = lots > 0
          ? (avgByTicker[ticker] ?? PlanoraV22Calc.round2(modal / shares))
          : 0.0;
      final pos = StockPosition(
        ticker: ticker,
        totalLots: lots,
        totalShares: shares,
        totalModal: modal,
        averagePrice: avg.isNaN || avg.isInfinite ? 0.0 : avg,
      );
      positions[ticker] = pos;
      if (pos.isOpen) {
        active.add(pos);
        totalModal += pos.totalModal;
        totalLots += pos.totalLots;
      }
    }

    active.sort((a, b) {
      final byModal = b.totalModal.compareTo(a.totalModal);
      if (byModal != 0) return byModal;
      return a.ticker.compareTo(b.ticker);
    });

    return StockLedgerComputation(
      positionsByTicker: positions,
      activePositions: active,
      totalPositionsModal: totalModal,
      totalActiveLots: totalLots,
      sellExitModalByTxId: sellExitModalByTxId,
    );
  }

  static int componentActualAmount({
    required int totalPositionsModal,
    required int legacyOpeningAmount,
  }) {
    return math.max(0, totalPositionsModal) + math.max(0, legacyOpeningAmount);
  }

  static double percentWithinStockComponent({
    required int tickerModal,
    required int stockComponentActual,
  }) {
    if (stockComponentActual <= 0 || tickerModal <= 0) return 0.0;
    return PlanoraV22Calc.round2((tickerModal / stockComponentActual) * 100.0);
  }

  static double percentOfPortfolio({
    required int tickerModal,
    required int portfolioTotalActual,
  }) {
    if (portfolioTotalActual <= 0 || tickerModal <= 0) return 0.0;
    return PlanoraV22Calc.round2((tickerModal / portfolioTotalActual) * 100.0);
  }

  static String formatAveragePrice(double avgPrice) {
    final r = PlanoraV22Calc.round2(avgPrice);
    final whole = r.truncate();
    final frac = ((r - whole).abs() * 100).round();
    final wholeStr = whole.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
    if (frac == 0) {
      return 'Rp $wholeStr';
    }
    return 'Rp $wholeStr,${frac.toString().padLeft(2, '0')}';
  }
}
