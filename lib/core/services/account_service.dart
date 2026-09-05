import 'package:supabase_flutter/supabase_flutter.dart';

class AccountService {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchAccounts() async {
    try {
      final response = await _supabase.from('accounts').select().order('created_at');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [];
    }
  }

  Future<void> createAccount(Map<String, dynamic> accountData) async {
    await _supabase.from('accounts').insert(accountData);
  }

  Future<void> logWithdrawal(String accountId, double amount, String notes) async {
    await _supabase.from('withdrawals').insert({
      'account_id': accountId,
      'amount': amount,
      'notes': notes,
      'payout_date': DateTime.now().toIso8601String(),
    });
  }
}
