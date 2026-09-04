import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveAccountNotifier extends StateNotifier<String?> {
  ActiveAccountNotifier() : super(null);

  void selectAccount(String accountId) {
    state = accountId;
  }
}

final activeAccountIdProvider = StateNotifierProvider<ActiveAccountNotifier, String?>((ref) {
  return ActiveAccountNotifier();
});
