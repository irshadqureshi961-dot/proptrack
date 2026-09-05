// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'app_database.dart';

// ignore_for_file: type=lint
abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
}

class Account {
  final String id;
  final String name;
  final double balance;
  Account({required this.id, required this.name, required this.balance});
}

class Trade {
  final String id;
  final String accountId;
  final String type;
  final double amount;
  Trade({required this.id, required this.accountId, required this.type, required this.amount});
}

class AccountsCompanion {
  const AccountsCompanion();
}

class TradesCompanion {
  const TradesCompanion();
}
