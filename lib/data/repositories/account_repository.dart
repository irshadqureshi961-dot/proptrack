import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../local/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

class AccountsNotifier extends AsyncNotifier<List<Account>> {
  late final AppDatabase _db;

  @override
  Future<List<Account>> build() async {
    _db = ref.watch(databaseProvider);
    return _fetchAccounts();
  }

  Future<List<Account>> _fetchAccounts() async {
    return await _db.select(_db.accounts).get();
  }

  Future<void> addAccount({
    required String name,
    required String propFirm,
    required String accountType,
    required double startingBalance,
    required double profitTarget,
    required double dailyLossLimit,
    required double maxDrawdown,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newAccount = AccountsCompanion(
        id: drift.Value(DateTime.now().millisecondsSinceEpoch.toString()),
        name: drift.Value(name),
        propFirm: drift.Value(propFirm),
        accountType: drift.Value(accountType),
        startingBalance: drift.Value(startingBalance),
        currentBalance: drift.Value(startingBalance),
        profitTarget: drift.Value(profitTarget),
        dailyLossLimit: drift.Value(dailyLossLimit),
        maxDrawdown: drift.Value(maxDrawdown),
      );

      await _db.into(_db.accounts).insert(newAccount);
      return _fetchAccounts();
    });
  }

  Future<void> logTrade({
    required String accountId,
    required String symbol,
    required String type,
    required double lotSize,
    required double pnl,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final trade = TradesCompanion(
        id: drift.Value(DateTime.now().millisecondsSinceEpoch.toString()),
        accountId: drift.Value(accountId),
        symbol: drift.Value(symbol),
        type: drift.Value(type),
        lotSize: drift.Value(lotSize),
        pnl: drift.Value(pnl),
        closedAt: drift.Value(DateTime.now()),
      );

      await _db.into(_db.trades).insert(trade);

      final account = await (_db.select(_db.accounts)..where((a) => a.id.equals(accountId))).getSingle();
      final updatedBalance = account.currentBalance + pnl;

      await (_db.update(_db.accounts)..where((a) => a.id.equals(accountId))).write(
        AccountsCompanion(currentBalance: drift.Value(updatedBalance)),
      );

      return _fetchAccounts();
    });
  }
}

final accountsProvider = AsyncNotifierProvider<AccountsNotifier, List<Account>>(() {
  return AccountsNotifier();
});

final tradesProvider = StreamProvider.family<List<Trade>, String>((ref, accountId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.trades)..where((t) => t.accountId.equals(accountId))).watch();
});
