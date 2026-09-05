// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'app_database.dart';

// ignore_for_file: type=lint
abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => [];

  dynamic get accounts => throw UnimplementedError();
  dynamic get trades => throw UnimplementedError();
}

class Account {
  final String id;
  final String name;
  final String propFirm;
  final String accountType;
  final double startingBalance;
  final double currentBalance;
  final double profitTarget;
  final double dailyLossLimit;
  final double maxDrawdown;

  Account({
    required this.id,
    required this.name,
    this.propFirm = 'Prop Firm',
    this.accountType = 'Evaluation',
    this.startingBalance = 10000.0,
    this.currentBalance = 10000.0,
    this.profitTarget = 1000.0,
    this.dailyLossLimit = 500.0,
    this.maxDrawdown = 1000.0,
  });
}

class Trade {
  final String id;
  final String accountId;
  final String type;
  final double amount;
  final double pnl;

  Trade({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    this.pnl = 0.0,
  });
}

class AccountsCompanion {
  const AccountsCompanion();
}

class TradesCompanion {
  const TradesCompanion();
}
