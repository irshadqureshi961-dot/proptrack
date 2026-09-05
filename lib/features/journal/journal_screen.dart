import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  final List<Map<String, dynamic>> trades;

  const JournalScreen({super.key, required this.trades});

  @override
  Widget build(BuildContext context) {
    final winCount = trades.where((t) => t['isProfit'] == true).length;
    final totalTrades = trades.length;
    final winRate = totalTrades > 0 ? (winCount / totalTrades * 100) : 0.0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Trade Journal',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard('Total Trades', '$totalTrades', Colors.blueAccent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard('Win Rate', '${winRate.toStringAsFixed(1)}%', const Color(0xFF00E676)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Historical Log',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: trades.isEmpty
                ? const Center(
                    child: Text('No trades logged yet', style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    itemCount: trades.length,
                    itemBuilder: (context, index) {
                      final trade = trades[index];
                      final isProfit = trade['isProfit'] as bool;
                      return Card(
                        color: const Color(0xFF121824),
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isProfit ? const Color(0x2200E676) : const Color(0x22FF5252),
                            child: Icon(
                              isProfit ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                              color: isProfit ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                            ),
                          ),
                          title: Text(
                            trade['symbol'] ?? 'UNKNOWN',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${trade['type']} • ${trade['size']}',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          trailing: Text(
                            trade['pnl'] ?? '\$0.00',
                            style: TextStyle(
                              color: isProfit ? const Color(0xFF00E676) : const Color(0xFFFF5252),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, Color color) {
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
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }
}
