import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/account_repository.dart';

class TradeListWidget extends ConsumerWidget {
  final String accountId;

  const TradeListWidget({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tradesAsync = ref.watch(tradesProvider(accountId));

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
          const Text(
            'RECENT TRADES',
            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          tradesAsync.when(
            data: (trades) {
              if (trades.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'No trades logged yet.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trades.length,
                separatorBuilder: (_, __) => const Divider(color: Color(0xFF1F293D)),
                itemBuilder: (context, index) {
                  final trade = trades[index];
                  final isProfit = trade.pnl >= 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: trade.type == 'BUY'
                                  ? const Color(0xFF10B981).withAlpha(30)
                                  : const Color(0xFFEF4444).withAlpha(30),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              trade.type,
                              style: TextStyle(
                                color: trade.type == 'BUY' ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trade.symbol,
                                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${trade.lotSize} Lots',
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${isProfit ? "+" : ""}\$${trade.pnl.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isProfit ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error: $err', style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
