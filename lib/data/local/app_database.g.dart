// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'app_database.dart';

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
  DatabaseConnectionUser get attachedDatabase => database;
  @override
  String get actualTableName => 'accounts';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  GeneratedColumn<String> get id => GeneratedColumn<String>('id', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<String> get name => GeneratedColumn<String>('name', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<String> get propFirm => GeneratedColumn<String>('prop_firm', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<String> get accountType => GeneratedColumn<String>('account_type', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<double> get startingBalance => GeneratedColumn<double>('starting_balance', actualTableName, false, type: DriftSqlType.double);
  GeneratedColumn<double> get currentBalance => GeneratedColumn<double>('current_balance', actualTableName, false, type: DriftSqlType.double);
  GeneratedColumn<double> get profitTarget => GeneratedColumn<double>('profit_target', actualTableName, false, type: DriftSqlType.double);
  GeneratedColumn<double> get dailyLossLimit => GeneratedColumn<double>('daily_loss_limit', actualTableName, false, type: DriftSqlType.double);
  GeneratedColumn<double> get maxDrawdown => GeneratedColumn<double>('max_drawdown', actualTableName, false, type: DriftSqlType.double);

  @override
  List<GeneratedColumn> get $columns => [id, name, propFirm, accountType, startingBalance, currentBalance, profitTarget, dailyLossLimit, maxDrawdown];
  @override
  String get aliasedName => tableAs ?? actualTableName;
  @override
  $AccountsTable createAlias(String alias) => $AccountsTable(database, alias);
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Account(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
    );
  }
}

class $TradesTable extends Table with TableInfo<$TradesTable, Trade> {
  @override
  final GeneratedDatabase database;
  final String? tableAs;
  $TradesTable(this.database, [this.tableAs]);
  @override
  DatabaseConnectionUser get attachedDatabase => database;
  @override
  String get actualTableName => 'trades';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  GeneratedColumn<String> get id => GeneratedColumn<String>('id', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<String> get accountId => GeneratedColumn<String>('account_id', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<String> get symbol => GeneratedColumn<String>('symbol', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<String> get type => GeneratedColumn<String>('type', actualTableName, false, type: DriftSqlType.string);
  GeneratedColumn<double> get lotSize => GeneratedColumn<double>('lot_size', actualTableName, false, type: DriftSqlType.double);
  GeneratedColumn<double> get amount => GeneratedColumn<double>('amount', actualTableName, false, type: DriftSqlType.double);
  GeneratedColumn<double> get pnl => GeneratedColumn<double>('pnl', actualTableName, false, type: DriftSqlType.double);
  GeneratedColumn<DateTime> get closedAt => GeneratedColumn<DateTime>('closed_at', actualTableName, true, type: DriftSqlType.dateTime);

  @override
  List<GeneratedColumn> get $columns => [id, accountId, symbol, type, lotSize, amount, pnl, closedAt];
  @override
  String get aliasedName => tableAs ?? actualTableName;
  @override
  $TradesTable createAlias(String alias) => $TradesTable(database, alias);
  @override
  Trade map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Trade(
      id: data['id'] as String? ?? '',
      accountId: data['account_id'] as String? ?? '',
      type: data['type'] as String? ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
