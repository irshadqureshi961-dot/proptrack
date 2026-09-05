import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E14),
        title: const Text('Trade Journal & Analytics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Analytics Grid
            Row(
              children: [
                Expanded(child: _buildMetricCard('Win Rate', '66.7%', const Color(0xFF00E676))),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Profit Factor', '2.45', Colors.white)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Avg Win', '+\$860.00', const Color(0xFF00E676))),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Avg Loss', '-\$180.00', const Color(0xFFFF5252))),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Trade History', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            _buildJournalTile('EURUSD', 'BUY 1.5 Lots', '+$620.00', 'Passed key resistance level, followed strategy.', true),
            _buildJournalTile('XAUUSD', 'SELL 0.5 Lots', '-$180.00', 'Stopped out during news volatility.', false),
            _buildJournalTile('GBPUSD', 'BUY 2.0 Lots', '+$1,100.00', 'Clean double bottom retest on 15m chart.', true),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color valueColor) {
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
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: valueColor, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildJournalTile(String symbol, String details, String pnl, String notes, bool isWin) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF121824),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(symbol, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              Text(pnl, style: TextStyle(color: isWin ? const Color(0xFF00E676) : const Color(0xFFFF5252), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Text(details, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 8),
          Text(notes, style: const TextStyle(color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
