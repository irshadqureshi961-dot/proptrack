import 'package:supabase_flutter/supabase_flutter.dart';

class TradeService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchTrades() async {
    try {
      final response = await _supabase
          .from('trades')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  Future<void> addTrade(Map<String, dynamic> tradeData) async {
    try {
      await _supabase.from('trades').insert(tradeData);
    } catch (e) {
      // Handle or ignore local fallback
    }
  }

  Future<void> logTrade({
    required String symbol,
    required String type,
    required double lotSize,
    required double pnl,
  }) async {
    await addTrade({
      'symbol': symbol,
      'type': type,
      'lot_size': lotSize,
      'pnl': pnl,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
