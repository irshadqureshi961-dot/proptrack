import 'package:flutter/material.dart';
import '../trades/widgets/log_trade_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double startingBalance = 100000.0;
  double currentEquity = 104250.0;
  double maxDailyLossLimit = 5000.0;
  double profitTargetLimit = 10000.0;
  double todayLoss = 0.0;

  List<Map<String, dynamic>> loggedTrades = [];

  void _addNewTrade(Map<String, dynamic> trade) {
    setState(() {
      loggedTrades.add(trade);
      double pnl = trade['pnl'] ?? 0.0;
      currentEquity += pnl;

      if (pnl < 0) {
        todayLoss += pnl.abs();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Trade for ${trade['symbol']} logged successfully!'),
        backgroundColor: const Color(0xFF00E676),
      ),
    );
  }

  void _openLogTradeModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LogTradeSheet(
        onTradeAdded: _addNewTrade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPnL = currentEquity - startingBalance;
    double pnlPercent = (totalPnL / startingBalance) * 100;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E17),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'FTMO \$100K Challenge',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF00E676)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '2 Step • Equity based • Active',
                style: TextStyle(color: Color(0xFF00E676), fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Main Balance Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF121824),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Starting Balance', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text('\$${startingBalance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Current Equity', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text('\$${currentEquity.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'P/L: ${totalPnL >= 0 ? '+' : ''}\$${totalPnL.toStringAsFixed(2)} (${pnlPercent.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          color: totalPnL >= 0 ? const Color(0xFF00E676) : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Start: 2026-08-01', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text('Risk & Objectives', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Daily Loss Progress
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF121824),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Max Daily Loss (5.0%)', style: TextStyle(color: Colors.white)),
                  Text('\$${todayLoss.toStringAsFixed(0)} / \$${maxDailyLossLimit.toStringAsFixed(0)}', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Profit Target Progress
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF121824),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Profit Target', style: TextStyle(color: Colors.white)),
                      Text('\$${totalPnL > 0 ? totalPnL.toStringAsFixed(0) : '0'} / \$${profitTargetLimit.toStringAsFixed(0)}', style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (totalPnL / profitTargetLimit).clamp(0.0, 1.0),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    color: const Color(0xFF00E676),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openLogTradeModal,
        backgroundColor: const Color(0xFF00E676),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text('Log Trade', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
