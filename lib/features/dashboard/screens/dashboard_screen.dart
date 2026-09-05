import 'package:flutter/material.dart';
import '../../trades/widgets/log_trade_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final double initialBalance = 100000.00;
  final double profitTargetGoal = 10000.00;
  final double maxDailyLossGoal = 5000.00;

  List<Map<String, dynamic>> trades = [
    {'symbol': 'EURUSD', 'type': 'BUY', 'size': '1.5 Lots', 'pnl': '+$620.00', 'isProfit': true, 'numericPnl': 620.00},
    {'symbol': 'XAUUSD', 'type': 'SELL', 'size': '0.5 Lots', 'pnl': '-$180.00', 'isProfit': false, 'numericPnl': -180.00},
    {'symbol': 'GBPUSD', 'type': 'BUY', 'size': '2.0 Lots', 'pnl': '+$1,100.00', 'isProfit': true, 'numericPnl': 1100.00},
  ];

  double get totalPnl => trades.fold(0.0, (sum, item) => sum + (item['numericPnl'] as double));
  double get currentEquity => initialBalance + totalPnl;
  double get pnlPercentage => (totalPnl / initialBalance) * 100;

  void _addNewTrade(Map<String, dynamic> newTrade) {
    setState(() {
      trades.insert(0, newTrade);
    });
  }

  void _showLogTradeModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LogTradeSheet(onTradeAdded: _addNewTrade),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FTMO $100K Challenge', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('Account #849201 • Active', style: TextStyle(color: Color(0xFF00E676), fontSize: 12)),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF121824),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E2638)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Equity', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('\$${currentEquity.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Profit / Loss', style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text(
                              '${totalPnl >= 0 ? '+$' : '-$'}${totalPnl.abs().toStringAsFixed(2)} (${pnlPercentage.toStringAsFixed(2)}%)',
                              style: TextStyle(color: totalPnl >= 0 ? const Color(0xFF00E676) : const Color(0xFFFF5252), fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Max Drawdown', style: TextStyle(color: Colors.grey, fontSize: 11)),
                            Text('1.8% / 10.0%', style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Risk & Objectives', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF121824), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Profit Target', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                        Text('\$${totalPnl.clamp(0, profitTargetGoal).toStringAsFixed(0)} / \$${profitTargetGoal.toInt()}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (totalPnl / profitTargetGoal).clamp(0.0, 1.0),
                      backgroundColor: const Color(0xFF1E2638),
                      color: const Color(0xFF00E676),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Recent Trades', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trades.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final trade = trades[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFF121824), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: trade['isProfit'] ? const Color(0x2200E676) : const Color(0x22FF5252),
                              child: Icon(
                                trade['isProfit'] ? Icons.trending_up : Icons.trending_down,
                                color: trade['isProfit'] ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(trade['symbol'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                Text('${trade['type']} • ${trade['size']}', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          trade['pnl'],
                          style: TextStyle(
                            color: trade['isProfit'] ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showLogTradeModal,
        backgroundColor: const Color(0xFF00E676),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text('Log Trade', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
