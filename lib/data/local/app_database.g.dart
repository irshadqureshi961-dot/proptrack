// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'app_database.dart';

// ignore_for_file: type=lint
abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => [accounts, trades];

  $AccountsTable get accounts => $AccountsTable(this);
  $TradesTable get trades => $TradesTable(this);
}

class $AccountsTable extends Table with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase database;
  final String? tableAs;
  $AccountsTable(this.database, [this.tableAs]);

  @override
  String get actualTableName => 'accounts';

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  GeneratedColumn<String> get id => GeneratedColumn<String>('id', actualTableName, false, type: DriftSqlType.string);

  @override
  List<GeneratedColumn> get $columns => [id];

  @override
  String get aliasedName => tableAs ?? actualTableName;

  @override
  $AccountsTable createAlias(String alias) => $AccountsTable(database, alias);

  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Account(id: '', name: '');
  }
}

class $TradesTable extends Table with TableInfo<$TradesTable, Trade> {
  @override
  final GeneratedDatabase database;
  final String? tableAs;
  $TradesTable(this.database, [this.tableAs]);

  @override
  String get actualTableName => 'trades';

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  GeneratedColumn<String> get id => GeneratedColumn<String>('id', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<String> get accountId => GeneratedColumn<String>('account_id', actualTableName, false, type: DriftSqlType.string);

  @override
  List<GeneratedColumn> get $columns => [id, accountId];

  @override
  String get aliasedName => tableAs ?? actualTableName;

  @override
  $TradesTable createAlias(String alias) => $TradesTable(database, alias);

  @override
  Trade map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Trade(id: '', accountId: '', type: '', amount: 0);
  }
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
  final String symbol;
  final double lotSize;
  final double amount;
  final double pnl;

  Trade({
    required this.id,
    required this.accountId,
    required this.type,
    this.symbol = 'EURUSD',
    this.lotSize = 1.0,
    required this.amount,
    this.pnl = 0.0,
  });
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<double> currentBalance;

  const AccountsCompanion({
    this.id = const Value.absent(),
    this.currentBalance = const Value.absent(),
  });
}

class TradesCompanion extends UpdateCompanion<Trade> {
  final Value<String> id;

  const TradesCompanion({
    this.id = const Value.absent(),
  });
}
