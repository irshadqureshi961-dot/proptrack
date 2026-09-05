import 'package:supabase_flutter/supabase_flutter.dart';

class TradeService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchTrades() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return [];

      final response = await _supabase
          .from('trades')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return (response as List).map((t) {
        final double pnlVal = (t['pnl'] as num).toDouble();
        final bool isProfit = pnlVal >= 0;
        return {
          'id': t['id'],
          'symbol': t['symbol'],
          'type': t['trade_type'],
          'size': '${t['lot_size']} Lots',
          'pnl': '${isProfit ? '+\$' : '-\$'}${pnlVal.abs().toStringAsFixed(2)}',
          'isProfit': isProfit,
          'numericPnl': pnlVal,
        };
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> logTrade({
    required String symbol,
    required String type,
    required double lotSize,
    required double pnl,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return false;

      await _supabase.from('trades').insert({
        'user_id': user.id,
        'symbol': symbol,
        'trade_type': type,
        'lot_size': lotSize,
        'pnl': pnl,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
