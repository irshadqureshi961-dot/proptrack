import 'package:flutter/material.dart';
import '../trades/widgets/log_trade_sheet.dart';
import '../calculator/calculator_screen.dart';
import '../journal/journal_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  double _equity = 104250.00;

  final List<Map<String, dynamic>> _trades = [
    {'symbol': 'EURUSD', 'type': 'BUY', 'size': '1.5 Lots', 'pnl': '+\$620.00', 'isProfit': true, 'numericPnl': 620.0},
    {'symbol': 'XAUUSD', 'type': 'SELL', 'size': '0.5 Lots', 'pnl': '-\$180.00', 'isProfit': false, 'numericPnl': -180.0},
    {'symbol': 'GBPUSD', 'type': 'BUY', 'size': '2.0 Lots', 'pnl': '+\$1,100.00', 'isProfit': true, 'numericPnl': 1100.0},
  ];

  void _openLogTradeSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LogTradeSheet(
        onTradeAdded: (newTrade) {
          setState(() {
            _trades.insert(0, newTrade);
            _equity += (newTrade['numericPnl'] as double);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121824),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'FTMO \$100K Challenge',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Account #849201 • Active',
              style: TextStyle(fontSize: 12, color: Color(0xFF00E676)),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboardView(),
          const CalculatorScreen(),
          JournalScreen(trades: _trades),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: _openLogTradeSheet,
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              icon: const Icon(Icons.add),
              label: const Text('Log Trade', style: TextStyle(fontWeight: FontWeight.bold)),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF121824),
        selectedItemColor: const Color(0xFF00E676),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate_outlined), label: 'Calculator'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'Journal'),
        ],
      ),
    );
  }

  Widget _buildDashboardView() {
    final netPnl = _equity - 100000.0;
    final pnlPercent = (netPnl / 100000.0) * 100;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF121824),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1E2638)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Equity', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 6),
                Text(
                  '\$${_equity.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetricTile(
                      'Profit / Loss',
                      '${netPnl >= 0 ? '+' : ''}\$${netPnl.toStringAsFixed(2)} (${pnlPercent.toStringAsFixed(2)}%)',
                      netPnl >= 0 ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                    ),
                    _buildMetricTile('Max Drawdown', '1.8% / 10.0%', Colors.orangeAccent),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Risk & Objectives', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          _buildProgressBar('Max Daily Loss', 0.35, '\$350 / \$5,000 (0.7%)', const Color(0xFF00E676)),
          const SizedBox(height: 12),
          _buildProgressBar('Profit Target', (netPnl / 10000).clamp(0.0, 1.0), '\$${netPnl.toStringAsFixed(0)} / \$10,000', const Color(0xFF00E676)),
          const SizedBox(height: 24),
          const Text('Recent Trades', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          ..._trades.map((t) => _buildTradeCard(t['symbol'], t['type'], t['size'], t['pnl'], t['isProfit'])).toList(),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildProgressBar(String title, double progress, String subtext, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E2638)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              Text(subtext, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF1E2638),
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeCard(String symbol, String type, String size, String pnl, bool isProfit) {
    return Card(
      color: const Color(0xFF121824),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isProfit ? const Color(0x2200E676) : const Color(0x22FF5252),
          child: Icon(
            isProfit ? Icons.trending_up_rounded : Icons.trending_down_rounded,
            color: isProfit ? const Color(0xFF00E676) : const Color(0xFFFF5252),
          ),
        ),
        title: Text(symbol, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text('$type • $size', style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Text(
          pnl,
          style: TextStyle(
            color: isProfit ? const Color(0xFF00E676) : const Color(0xFFFF5252),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
