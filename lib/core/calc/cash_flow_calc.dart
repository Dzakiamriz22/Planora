import 'package:planora/core/calc/planora_v22_calc.dart';
import 'package:planora/core/format/formatters.dart';

enum ExpenseBudgetStatus {
  noBudget,
  onTrack, // < 80%
  warning, // 80% .. <100%
  overBudget, // >= 100%
}

class CashFlowTxInput {
  const CashFlowTxInput({
    required this.id,
    required this.type,
    required this.transactionDate,
    required this.amount,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
    required this.categoryIcon,
    this.note,
  });

  final String id;
  final String type; // 'income' | 'expense'
  final String transactionDate; // YYYY-MM-DD
  final int amount;
  final String categoryId;
  final String categoryName;
  final int categoryColor;
  final String categoryIcon;
  final String? note;

  bool get isIncome => type == CashFlowCalc.typeIncome;
  bool get isExpense => type == CashFlowCalc.typeExpense;
}

class CashFlowCategoryTotal {
  const CashFlowCategoryTotal({
    required this.categoryId,
    required this.name,
    required this.color,
    required this.icon,
    required this.amount,
    required this.percent,
  });

  final String categoryId;
  final String name;
  final int color;
  final String icon;
  final int amount;
  final double percent;
}

class CashFlowMonthlyBar {
  const CashFlowMonthlyBar({
    required this.month,
    required this.expenseTotal,
    required this.incomeTotal,
    required this.budget,
  });

  final DateTime month;
  final int expenseTotal;
  final int incomeTotal;
  final int? budget;
}

class CashFlowDayGroup {
  const CashFlowDayGroup({
    required this.dateIso,
    required this.date,
    required this.items,
    required this.dayIncome,
    required this.dayExpense,
  });

  final String dateIso;
  final DateTime date;
  final List<CashFlowTxInput> items;
  final int dayIncome;
  final int dayExpense;
}

class CashFlowMonthlySummary {
  const CashFlowMonthlySummary({
    required this.month,
    required this.incomeActual,
    required this.expenseActual,
    required this.portfolioDeposits,
    required this.remainingCash,
    required this.budgetAmount,
    required this.budgetSourceLabel,
    required this.budgetUsagePct,
    required this.budgetStatus,
    required this.remainingBudget,
    required this.incomeAdviceMessage,
    required this.expenseByCategory,
    required this.weeklyExpenses,
    required this.dayGroups,
  });

  final DateTime month;
  final int incomeActual;
  final int expenseActual;
  final int portfolioDeposits;

  /// Sisa kas bulan ini = Pemasukan aktual - Pengeluaran - Setoran ke porto (boleh negatif)
  final int remainingCash;

  final int? budgetAmount;
  final String? budgetSourceLabel;
  final double budgetUsagePct;
  final ExpenseBudgetStatus budgetStatus;
  final int? remainingBudget;

  /// Saran informatif anti-dobel bila pemasukan aktual berbeda dari gaji rencana.
  /// Tidak pernah otomatis mengubah gaji rencana, plafon, Plan, atau saldo porto.
  final String? incomeAdviceMessage;

  final List<CashFlowCategoryTotal> expenseByCategory;
  final List<int> weeklyExpenses; // Minggu 1..5
  final List<CashFlowDayGroup> dayGroups;
}

class CashFlowCalc {
  CashFlowCalc._();

  static const String typeIncome = 'income';
  static const String typeExpense = 'expense';

  static String? validateAmount(int amount) {
    if (amount <= 0) {
      return 'Nominal harus lebih dari Rp 0.';
    }
    return null;
  }

  static String? validateTransactionDate(DateTime date, {DateTime? now}) {
    final ref = now ?? DateTime.now();
    final today = DateTime(ref.year, ref.month, ref.day);
    final candidate = DateTime(date.year, date.month, date.day);
    if (candidate.isAfter(today)) {
      return 'Tanggal tidak boleh di masa depan.';
    }
    return null;
  }

  /// Budget pengeluaran: prioritas biaya hidup saat ini, fallback biaya hidup minimum.
  static ({int? amount, String? sourceLabel}) resolveExpenseBudget({
    int? currentLivingCost,
    int? minimumLivingCost,
  }) {
    if (currentLivingCost != null && currentLivingCost > 0) {
      return (amount: currentLivingCost, sourceLabel: 'Biaya hidup saat ini');
    }
    if (minimumLivingCost != null && minimumLivingCost > 0) {
      return (amount: minimumLivingCost, sourceLabel: 'Biaya hidup minimum');
    }
    return (amount: null, sourceLabel: null);
  }

  static ExpenseBudgetStatus evaluateBudgetStatus({
    required int expenseActual,
    required int? budgetAmount,
  }) {
    if (budgetAmount == null || budgetAmount <= 0) {
      return ExpenseBudgetStatus.noBudget;
    }
    final pct = (expenseActual / budgetAmount) * 100.0;
    if (pct >= 100.0) return ExpenseBudgetStatus.overBudget;
    if (pct >= 80.0) return ExpenseBudgetStatus.warning;
    return ExpenseBudgetStatus.onTrack;
  }

  static String? buildIncomeVsPlanAdvice({
    required int incomeActual,
    required int? plannedMonthlySalary,
  }) {
    if (plannedMonthlySalary == null ||
        plannedMonthlySalary <= 0 ||
        incomeActual <= 0) {
      return null;
    }
    final diff = incomeActual - plannedMonthlySalary;
    if (diff > 0) {
      return 'Bulan ini masuk ${AppFormatters.rupiah(diff)} di atas gaji rencana — pertimbangkan untuk menambah porsi tabungan di Plan secara manual.';
    }
    if (diff < 0 && incomeActual < plannedMonthlySalary) {
      return 'Pemasukan tercatat bulan ini masih ${AppFormatters.rupiah(diff.abs())} di bawah gaji rencana di Profil Keuangan.';
    }
    return null;
  }

  static CashFlowMonthlySummary computeMonthlySummary({
    required DateTime month,
    required List<CashFlowTxInput> allTransactions,
    required List<({DateTime date, int amount})> allPortfolioDeposits,
    required int? plannedMonthlySalary,
    required int? currentLivingCost,
    required int? minimumLivingCost,
  }) {
    final monthTxs = <CashFlowTxInput>[];
    var incomeActual = 0;
    var expenseActual = 0;
    final expenseByCatId = <String, ({String name, int color, String icon, int amt})>{};
    final weekly = List<int>.filled(5, 0);

    for (final tx in allTransactions) {
      final dt = AppFormatters.parseIsoDate(tx.transactionDate);
      if (dt == null) continue;
      if (dt.year != month.year || dt.month != month.month) continue;
      monthTxs.add(tx);
      if (tx.isIncome) {
        incomeActual += tx.amount;
      } else if (tx.isExpense) {
        expenseActual += tx.amount;
        final prev = expenseByCatId[tx.categoryId];
        expenseByCatId[tx.categoryId] = (
          name: tx.categoryName,
          color: tx.categoryColor,
          icon: tx.categoryIcon,
          amt: (prev?.amt ?? 0) + tx.amount,
        );
        final weekIdx = ((dt.day - 1) ~/ 7).clamp(0, 4);
        weekly[weekIdx] += tx.amount;
      }
    }

    var portfolioDeposits = 0;
    for (final dep in allPortfolioDeposits) {
      if (dep.amount <= 0) continue;
      if (dep.date.year == month.year && dep.date.month == month.month) {
        portfolioDeposits += dep.amount;
      }
    }

    final remainingCash = incomeActual - expenseActual - portfolioDeposits;
    final budgetResolved = resolveExpenseBudget(
      currentLivingCost: currentLivingCost,
      minimumLivingCost: minimumLivingCost,
    );
    final budgetAmt = budgetResolved.amount;
    final budgetUsagePct = (budgetAmt != null && budgetAmt > 0)
        ? PlanoraV22Calc.round2((expenseActual / budgetAmt) * 100.0)
        : 0.0;
    final budgetStatus = evaluateBudgetStatus(
      expenseActual: expenseActual,
      budgetAmount: budgetAmt,
    );
    final remainingBudget =
        budgetAmt != null ? budgetAmt - expenseActual : null;

    // Breakdown pengeluaran per kategori (urut nominal terbesar)
    final catEntries = expenseByCatId.entries.toList()
      ..sort((a, b) => b.value.amt.compareTo(a.value.amt));
    final catTotals = catEntries.map((e) {
      final pct = expenseActual > 0
          ? PlanoraV22Calc.round2((e.value.amt / expenseActual) * 100.0)
          : 0.0;
      return CashFlowCategoryTotal(
        categoryId: e.key,
        name: e.value.name,
        color: e.value.color,
        icon: e.value.icon,
        amount: e.value.amt,
        percent: pct,
      );
    }).toList();

    // Kelompokkan per hari (urut tanggal terbaru di atas)
    final byDate = <String, List<CashFlowTxInput>>{};
    for (final tx in monthTxs) {
      byDate.putIfAbsent(tx.transactionDate, () => []).add(tx);
    }
    final sortedDates = byDate.keys.toList()..sort((a, b) => b.compareTo(a));
    final dayGroups = sortedDates.map((iso) {
      final items = byDate[iso]!;
      var dInc = 0;
      var dExp = 0;
      for (final item in items) {
        if (item.isIncome) {
          dInc += item.amount;
        } else {
          dExp += item.amount;
        }
      }
      return CashFlowDayGroup(
        dateIso: iso,
        date: AppFormatters.parseIsoDate(iso) ?? month,
        items: List.unmodifiable(items),
        dayIncome: dInc,
        dayExpense: dExp,
      );
    }).toList();

    return CashFlowMonthlySummary(
      month: DateTime(month.year, month.month),
      incomeActual: incomeActual,
      expenseActual: expenseActual,
      portfolioDeposits: portfolioDeposits,
      remainingCash: remainingCash,
      budgetAmount: budgetAmt,
      budgetSourceLabel: budgetResolved.sourceLabel,
      budgetUsagePct: budgetUsagePct,
      budgetStatus: budgetStatus,
      remainingBudget: remainingBudget,
      incomeAdviceMessage: buildIncomeVsPlanAdvice(
        incomeActual: incomeActual,
        plannedMonthlySalary: plannedMonthlySalary,
      ),
      expenseByCategory: List.unmodifiable(catTotals),
      weeklyExpenses: List.unmodifiable(weekly),
      dayGroups: List.unmodifiable(dayGroups),
    );
  }

  static List<CashFlowMonthlyBar> computeMonthlyBars6m({
    required DateTime anchorMonth,
    required List<CashFlowTxInput> allTransactions,
    required int? budgetAmount,
  }) {
    final out = <CashFlowMonthlyBar>[];
    for (var i = 5; i >= 0; i--) {
      final m = DateTime(anchorMonth.year, anchorMonth.month - i);
      var exp = 0;
      var inc = 0;
      for (final tx in allTransactions) {
        final dt = AppFormatters.parseIsoDate(tx.transactionDate);
        if (dt == null) continue;
        if (dt.year == m.year && dt.month == m.month) {
          if (tx.isExpense) {
            exp += tx.amount;
          } else if (tx.isIncome) {
            inc += tx.amount;
          }
        }
      }
      out.add(
        CashFlowMonthlyBar(
          month: m,
          expenseTotal: exp,
          incomeTotal: inc,
          budget: budgetAmount,
        ),
      );
    }
    return out;
  }
}
