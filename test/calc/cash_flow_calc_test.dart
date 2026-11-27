import 'package:flutter_test/flutter_test.dart';
import 'package:planora/core/calc/cash_flow_calc.dart';

void main() {
  group('v3.3 — CashFlowCalc (Arus Kas: Pemasukan + Pengeluaran)', () {
    test('Validasi nominal 0/negatif dan tanggal masa depan ditolak; tanggal lampau diterima', () {
      final now = DateTime(2026, 11, 27);
      expect(CashFlowCalc.validateAmount(0), isNotNull);
      expect(CashFlowCalc.validateAmount(-50000), isNotNull);
      expect(CashFlowCalc.validateAmount(15000), isNull);

      expect(
        CashFlowCalc.validateTransactionDate(DateTime(2026, 11, 28), now: now),
        isNotNull,
      );
      expect(
        CashFlowCalc.validateTransactionDate(DateTime(2026, 11, 27), now: now),
        isNull,
      );
      expect(
        CashFlowCalc.validateTransactionDate(DateTime(2026, 10, 15), now: now),
        isNull,
      );
    });

    test('Sisa kas bulan ini = pemasukan aktual - pengeluaran - setoran porto; negatif tampil apa adanya', () {
      final summary = CashFlowCalc.computeMonthlySummary(
        month: DateTime(2026, 11),
        allTransactions: const [
          CashFlowTxInput(
            id: 't1',
            type: CashFlowCalc.typeIncome,
            transactionDate: '2026-11-01',
            amount: 5000000,
            categoryId: 'c_gaji',
            categoryName: 'Gaji',
            categoryColor: 0xFF0E7C66,
            categoryIcon: 'payments',
          ),
          CashFlowTxInput(
            id: 't2',
            type: CashFlowCalc.typeExpense,
            transactionDate: '2026-11-05',
            amount: 3200000,
            categoryId: 'c_makan',
            categoryName: 'Makan & Minum',
            categoryColor: 0xFFE11D48,
            categoryIcon: 'restaurant',
          ),
          // Transaksi bulan lalu tidak boleh masuk total bulan ini
          CashFlowTxInput(
            id: 't_old',
            type: CashFlowCalc.typeExpense,
            transactionDate: '2026-10-20',
            amount: 999999,
            categoryId: 'c_makan',
            categoryName: 'Makan & Minum',
            categoryColor: 0xFFE11D48,
            categoryIcon: 'restaurant',
          ),
        ],
        allPortfolioDeposits: [
          (date: DateTime(2026, 11, 10), amount: 2500000),
          (date: DateTime(2026, 10, 10), amount: 1000000),
        ],
        plannedMonthlySalary: 4500000,
        currentLivingCost: 3000000,
        minimumLivingCost: 2000000,
      );

      expect(summary.incomeActual, 5000000);
      expect(summary.expenseActual, 3200000);
      expect(summary.portfolioDeposits, 2500000);
      // 5.000.000 - 3.200.000 - 2.500.000 = -700.000 (negatif apa adanya)
      expect(summary.remainingCash, -700000);
      expect(summary.budgetAmount, 3000000);
      expect(summary.budgetStatus, ExpenseBudgetStatus.overBudget);
      // Saran anti-dobel muncul karena masuk Rp 500 rb di atas gaji rencana
      expect(summary.incomeAdviceMessage, contains('di atas gaji rencana'));
    });

    test('Budget fallback ke biaya hidup minimum & transisi status tepat di 80% dan 100%', () {
      final b1 = CashFlowCalc.resolveExpenseBudget(
        currentLivingCost: null,
        minimumLivingCost: 2000000,
      );
      expect(b1.amount, 2000000);
      expect(b1.sourceLabel, 'Biaya hidup minimum');

      final bEmpty = CashFlowCalc.resolveExpenseBudget(
        currentLivingCost: null,
        minimumLivingCost: null,
      );
      expect(bEmpty.amount, isNull);
      expect(
        CashFlowCalc.evaluateBudgetStatus(expenseActual: 100000, budgetAmount: null),
        ExpenseBudgetStatus.noBudget,
      );

      expect(
        CashFlowCalc.evaluateBudgetStatus(expenseActual: 1599999, budgetAmount: 2000000),
        ExpenseBudgetStatus.onTrack,
      );
      expect(
        CashFlowCalc.evaluateBudgetStatus(expenseActual: 1600000, budgetAmount: 2000000),
        ExpenseBudgetStatus.warning,
      );
      expect(
        CashFlowCalc.evaluateBudgetStatus(expenseActual: 2000000, budgetAmount: 2000000),
        ExpenseBudgetStatus.overBudget,
      );
    });
  });
}
