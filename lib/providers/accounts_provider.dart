import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  AccountsNotifier() : super([]);

  Future<void> addAccount(String name, double balance, String type) async {
    state = [
      ...state,
      {'name': name, 'balance': balance, 'type': type}
    ];
  }
}

final accountsProvider = StateNotifierProvider<AccountsNotifier, List<Map<String, dynamic>>>((ref) {
  return AccountsNotifier();
});
