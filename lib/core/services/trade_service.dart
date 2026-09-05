import 'package:supabase_flutter/supabase_flutter.dart';

class TradeService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchTrades() async {
    final response = await _supabase
        .from('trades')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> addTrade(Map<String, dynamic> tradeData) async {
    await _supabase.from('trades').insert(tradeData);
  }
}
