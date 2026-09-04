import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/repositories/account_repository.dart';
import '../../data/repositories/active_account_provider.dart';
import '../../data/local/app_database.dart';
import 'widgets/log_trade_sheet.dart';
import 'widgets/trade_list.dart';
import 'widgets/account_drawer.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsProvider);
    final activeAccountId = ref.watch(activeAccountIdProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      drawer: const AccountDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121824),
        title: const Text('Performance Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: accountsAsync.when(
        data: (accounts) {
          if (accounts.isEmpty) {
            return const Center(
              child: Text(
                'No accounts added yet.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final activeAccount = accounts.firstWhere(
            (acc) => acc.id == activeAccountId,
            orElse: () => accounts.first,
          );

          final tradesAsync = ref.watch(tradesProvider(activeAccount.id));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAccountHeaderBanner(activeAccount),
                const SizedBox(height: 12),
                _buildMetricsHeader(activeAccount),
                const SizedBox(height: 16),
                tradesAsync.when(
                  data: (trades) => _buildEquityChart(activeAccount, trades),
                  loading: () => const SizedBox(height: 180, child: Center(child: CircularProgressIndicator())),
                  error: (err, _) => Text('Chart Error: $err', style: const TextStyle(color: Colors.red)),
                ),
                const SizedBox(height: 16),
                _buildAccountRulesCard(activeAccount),
                const SizedBox(height: 16),
                TradeListWidget(accountId: activeAccount.id),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
      floatingActionButton: accountsAsync.maybeWhen(
        data: (accounts) {
          if (accounts.isEmpty) return null;
          final activeAccount = accounts.firstWhere(
            (acc) => acc.id == activeAccountId,
            orElse: () => accounts.first,
          );
          return FloatingActionButton.extended(
            backgroundColor: const Color(0xFF2563EB),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => LogTradeSheet(accountId: activeAccount.id),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Log Trade'),
          );
        },
        orElse: () => null,
      ),
    );
  }

  Widget _buildAccountHeaderBanner(Account account) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2232),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${account.name} (${account.propFirm})',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withAlpha(40),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              account.accountType.toUpperCase(),
              style: const TextStyle(color: Color(0xFF60A5FA), fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsHeader(Account account) {
    final pnl = account.currentBalance - account.startingBalance;
    final isProfit = pnl >= 0;

    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'ACCOUNT BALANCE',
            '\$${account.currentBalance.toStringAsFixed(2)}',
            'Initial: \$${account.startingBalance.toStringAsFixed(2)}',
            const Color(0xFF10B981),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            'TOTAL PROFIT',
            '${isProfit ? "+" : ""}\$${pnl.toStringAsFixed(2)}',
            'Return Target',
            isProfit ? const Color(0xFF10B981) : const Color(0xFFEF4444),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F293D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: accentColor, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildEquityChart(Account account, List<Trade> trades) {
    final List<FlSpot> spots = [FlSpot(0, account.startingBalance)];
    double currentBalance = account.startingBalance;

    for (int i = 0; i < trades.length; i++) {
      currentBalance += trades[i].pnl;
      spots.add(FlSpot((i + 1).toDouble(), currentBalance));
    }

    final isOverallProfitable = currentBalance >= account.startingBalance;
    final chartColor = isOverallProfitable ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F293D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('EQUITY CURVE', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              Text(
                '${spots.length - 1} Trades Executed',
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: spots.length > 2,
                    color: chartColor,
                    barWidth: 2,
                    dotData: FlDotData(show: spots.length < 10),
                    belowBarData: BarAreaData(
                      show: true,
                      color: chartColor.withAlpha(25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountRulesCard(Account account) {
    final profitProgress = account.profitTarget > 0
        ? ((account.currentBalance - account.startingBalance) / account.profitTarget).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F293D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ACCOUNT RULES', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildRuleProgress('Profit Target', '\$${account.profitTarget.toStringAsFixed(0)}', profitProgress, const Color(0xFF10B981)),
          const SizedBox(height: 12),
          _buildRuleProgress('Max Daily Loss', '\$${account.dailyLossLimit.toStringAsFixed(0)}', 0.10, const Color(0xFFEF4444)),
          const SizedBox(height: 12),
          _buildRuleProgress('Max Overall Loss', '\$${account.maxDrawdown.toStringAsFixed(0)}', 0.05, const Color(0xFFEF4444)),
        ],
      ),
    );
  }

  Widget _buildRuleProgress(String title, String target, double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            Text(target, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: const Color(0xFF1F293D),
          color: color,
          minHeight: 6,
        ),
      ],
    );
  }
}
