// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _propFirmMeta =
      const VerificationMeta('propFirm');
  @override
  late final GeneratedColumn<String> propFirm = GeneratedColumn<String>(
      'prop_firm', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accountTypeMeta =
      const VerificationMeta('accountType');
  @override
  late final GeneratedColumn<String> accountType = GeneratedColumn<String>(
      'account_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startingBalanceMeta =
      const VerificationMeta('startingBalance');
  @override
  late final GeneratedColumn<double> startingBalance = GeneratedColumn<double>(
      'starting_balance', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currentBalanceMeta =
      const VerificationMeta('currentBalance');
  @override
  late final GeneratedColumn<double> currentBalance = GeneratedColumn<double>(
      'current_balance', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _profitTargetMeta =
      const VerificationMeta('profitTarget');
  @override
  late final GeneratedColumn<double> profitTarget = GeneratedColumn<double>(
      'profit_target', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dailyLossLimitMeta =
      const VerificationMeta('dailyLossLimit');
  @override
  late final GeneratedColumn<double> dailyLossLimit = GeneratedColumn<double>(
      'daily_loss_limit', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _maxDrawdownMeta =
      const VerificationMeta('maxDrawdown');
  @override
  late final GeneratedColumn<double> maxDrawdown = GeneratedColumn<double>(
      'max_drawdown', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        propFirm,
        accountType,
        startingBalance,
        currentBalance,
        profitTarget,
        dailyLossLimit,
        maxDrawdown
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('prop_firm')) {
      context.handle(_propFirmMeta,
          propFirm.isAcceptableOrUnknown(data['prop_firm']!, _propFirmMeta));
    } else if (isInserting) {
      context.missing(_propFirmMeta);
    }
    if (data.containsKey('account_type')) {
      context.handle(
          _accountTypeMeta,
          accountType.isAcceptableOrUnknown(
              data['account_type']!, _accountTypeMeta));
    } else if (isInserting) {
      context.missing(_accountTypeMeta);
    }
    if (data.containsKey('starting_balance')) {
      context.handle(
          _startingBalanceMeta,
          startingBalance.isAcceptableOrUnknown(
              data['starting_balance']!, _startingBalanceMeta));
    } else if (isInserting) {
      context.missing(_startingBalanceMeta);
    }
    if (data.containsKey('current_balance')) {
      context.handle(
          _currentBalanceMeta,
          currentBalance.isAcceptableOrUnknown(
              data['current_balance']!, _currentBalanceMeta));
    } else if (isInserting) {
      context.missing(_currentBalanceMeta);
    }
    if (data.containsKey('profit_target')) {
      context.handle(
          _profitTargetMeta,
          profitTarget.isAcceptableOrUnknown(
              data['profit_target']!, _profitTargetMeta));
    } else if (isInserting) {
      context.missing(_profitTargetMeta);
    }
    if (data.containsKey('daily_loss_limit')) {
      context.handle(
          _dailyLossLimitMeta,
          dailyLossLimit.isAcceptableOrUnknown(
              data['daily_loss_limit']!, _dailyLossLimitMeta));
    } else if (isInserting) {
      context.missing(_dailyLossLimitMeta);
    }
    if (data.containsKey('max_drawdown')) {
      context.handle(
          _maxDrawdownMeta,
          maxDrawdown.isAcceptableOrUnknown(
              data['max_drawdown']!, _maxDrawdownMeta));
    } else if (isInserting) {
      context.missing(_maxDrawdownMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      propFirm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prop_firm'])!,
      accountType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_type'])!,
      startingBalance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}starting_balance'])!,
      currentBalance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}current_balance'])!,
      profitTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}profit_target'])!,
      dailyLossLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}daily_loss_limit'])!,
      maxDrawdown: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_drawdown'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final String id;
  final String name;
  final String propFirm;
  final String accountType;
  final double startingBalance;
  final double currentBalance;
  final double profitTarget;
  final double dailyLossLimit;
  final double maxDrawdown;
  const Account(
      {required this.id,
      required this.name,
      required this.propFirm,
      required this.accountType,
      required this.startingBalance,
      required this.currentBalance,
      required this.profitTarget,
      required this.dailyLossLimit,
      required this.maxDrawdown});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['prop_firm'] = Variable<String>(propFirm);
    map['account_type'] = Variable<String>(accountType);
    map['starting_balance'] = Variable<double>(startingBalance);
    map['current_balance'] = Variable<double>(currentBalance);
    map['profit_target'] = Variable<double>(profitTarget);
    map['daily_loss_limit'] = Variable<double>(dailyLossLimit);
    map['max_drawdown'] = Variable<double>(maxDrawdown);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      propFirm: Value(propFirm),
      accountType: Value(accountType),
      startingBalance: Value(startingBalance),
      currentBalance: Value(currentBalance),
      profitTarget: Value(profitTarget),
      dailyLossLimit: Value(dailyLossLimit),
      maxDrawdown: Value(maxDrawdown),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      propFirm: serializer.fromJson<String>(json['propFirm']),
      accountType: serializer.fromJson<String>(json['accountType']),
      startingBalance: serializer.fromJson<double>(json['startingBalance']),
      currentBalance: serializer.fromJson<double>(json['currentBalance']),
      profitTarget: serializer.fromJson<double>(json['profitTarget']),
      dailyLossLimit: serializer.fromJson<double>(json['dailyLossLimit']),
      maxDrawdown: serializer.fromJson<double>(json['maxDrawdown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'propFirm': serializer.toJson<String>(propFirm),
      'accountType': serializer.toJson<String>(accountType),
      'startingBalance': serializer.toJson<double>(startingBalance),
      'currentBalance': serializer.toJson<double>(currentBalance),
      'profitTarget': serializer.toJson<double>(profitTarget),
      'dailyLossLimit': serializer.toJson<double>(dailyLossLimit),
      'maxDrawdown': serializer.toJson<double>(maxDrawdown),
    };
  }

  Account copyWith(
          {String? id,
          String? name,
          String? propFirm,
          String? accountType,
          double? startingBalance,
          double? currentBalance,
          double? profitTarget,
          double? dailyLossLimit,
          double? maxDrawdown}) =>
      Account(
        id: id ?? this.id,
        name: name ?? this.name,
        propFirm: propFirm ?? this.propFirm,
        accountType: accountType ?? this.accountType,
        startingBalance: startingBalance ?? this.startingBalance,
        currentBalance: currentBalance ?? this.currentBalance,
        profitTarget: profitTarget ?? this.profitTarget,
        dailyLossLimit: dailyLossLimit ?? this.dailyLossLimit,
        maxDrawdown: maxDrawdown ?? this.maxDrawdown,
      );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      propFirm: data.propFirm.present ? data.propFirm.value : this.propFirm,
      accountType:
          data.accountType.present ? data.accountType.value : this.accountType,
      startingBalance: data.startingBalance.present
          ? data.startingBalance.value
          : this.startingBalance,
      currentBalance: data.currentBalance.present
          ? data.currentBalance.value
          : this.currentBalance,
      profitTarget: data.profitTarget.present
          ? data.profitTarget.value
          : this.profitTarget,
      dailyLossLimit: data.dailyLossLimit.present
          ? data.dailyLossLimit.value
          : this.dailyLossLimit,
      maxDrawdown:
          data.maxDrawdown.present ? data.maxDrawdown.value : this.maxDrawdown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('propFirm: $propFirm, ')
          ..write('accountType: $accountType, ')
          ..write('startingBalance: $startingBalance, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('profitTarget: $profitTarget, ')
          ..write('dailyLossLimit: $dailyLossLimit, ')
          ..write('maxDrawdown: $maxDrawdown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      propFirm,
      accountType,
      startingBalance,
      currentBalance,
      profitTarget,
      dailyLossLimit,
      maxDrawdown);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.name == this.name &&
          other.propFirm == this.propFirm &&
          other.accountType == this.accountType &&
          other.startingBalance == this.startingBalance &&
          other.currentBalance == this.currentBalance &&
          other.profitTarget == this.profitTarget &&
          other.dailyLossLimit == this.dailyLossLimit &&
          other.maxDrawdown == this.maxDrawdown);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> propFirm;
  final Value<String> accountType;
  final Value<double> startingBalance;
  final Value<double> currentBalance;
  final Value<double> profitTarget;
  final Value<double> dailyLossLimit;
  final Value<double> maxDrawdown;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.propFirm = const Value.absent(),
    this.accountType = const Value.absent(),
    this.startingBalance = const Value.absent(),
    this.currentBalance = const Value.absent(),
    this.profitTarget = const Value.absent(),
    this.dailyLossLimit = const Value.absent(),
    this.maxDrawdown = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String name,
    required String propFirm,
    required String accountType,
    required double startingBalance,
    required double currentBalance,
    required double profitTarget,
    required double dailyLossLimit,
    required double maxDrawdown,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        propFirm = Value(propFirm),
        accountType = Value(accountType),
        startingBalance = Value(startingBalance),
        currentBalance = Value(currentBalance),
        profitTarget = Value(profitTarget),
        dailyLossLimit = Value(dailyLossLimit),
        maxDrawdown = Value(maxDrawdown);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? propFirm,
    Expression<String>? accountType,
    Expression<double>? startingBalance,
    Expression<double>? currentBalance,
    Expression<double>? profitTarget,
    Expression<double>? dailyLossLimit,
    Expression<double>? maxDrawdown,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (propFirm != null) 'prop_firm': propFirm,
      if (accountType != null) 'account_type': accountType,
      if (startingBalance != null) 'starting_balance': startingBalance,
      if (currentBalance != null) 'current_balance': currentBalance,
      if (profitTarget != null) 'profit_target': profitTarget,
      if (dailyLossLimit != null) 'daily_loss_limit': dailyLossLimit,
      if (maxDrawdown != null) 'max_drawdown': maxDrawdown,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? propFirm,
      Value<String>? accountType,
      Value<double>? startingBalance,
      Value<double>? currentBalance,
      Value<double>? profitTarget,
      Value<double>? dailyLossLimit,
      Value<double>? maxDrawdown,
      Value<int>? rowid}) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      propFirm: propFirm ?? this.propFirm,
      accountType: accountType ?? this.accountType,
      startingBalance: startingBalance ?? this.startingBalance,
      currentBalance: currentBalance ?? this.currentBalance,
      profitTarget: profitTarget ?? this.profitTarget,
      dailyLossLimit: dailyLossLimit ?? this.dailyLossLimit,
      maxDrawdown: maxDrawdown ?? this.maxDrawdown,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (propFirm.present) {
      map['prop_firm'] = Variable<String>(propFirm.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(accountType.value);
    }
    if (startingBalance.present) {
      map['starting_balance'] = Variable<double>(startingBalance.value);
    }
    if (currentBalance.present) {
      map['current_balance'] = Variable<double>(currentBalance.value);
    }
    if (profitTarget.present) {
      map['profit_target'] = Variable<double>(profitTarget.value);
    }
    if (dailyLossLimit.present) {
      map['daily_loss_limit'] = Variable<double>(dailyLossLimit.value);
    }
    if (maxDrawdown.present) {
      map['max_drawdown'] = Variable<double>(maxDrawdown.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('propFirm: $propFirm, ')
          ..write('accountType: $accountType, ')
          ..write('startingBalance: $startingBalance, ')
          ..write('currentBalance: $currentBalance, ')
          ..write('profitTarget: $profitTarget, ')
          ..write('dailyLossLimit: $dailyLossLimit, ')
          ..write('maxDrawdown: $maxDrawdown, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TradesTable extends Trades with TableInfo<$TradesTable, Trade> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TradesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts (id)'));
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
      'symbol', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lotSizeMeta =
      const VerificationMeta('lotSize');
  @override
  late final GeneratedColumn<double> lotSize = GeneratedColumn<double>(
      'lot_size', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _pnlMeta = const VerificationMeta('pnl');
  @override
  late final GeneratedColumn<double> pnl = GeneratedColumn<double>(
      'pnl', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, accountId, symbol, type, lotSize, pnl, closedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trades';
  @override
  VerificationContext validateIntegrity(Insertable<Trade> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(_symbolMeta,
          symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta));
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('lot_size')) {
      context.handle(_lotSizeMeta,
          lotSize.isAcceptableOrUnknown(data['lot_size']!, _lotSizeMeta));
    } else if (isInserting) {
      context.missing(_lotSizeMeta);
    }
    if (data.containsKey('pnl')) {
      context.handle(
          _pnlMeta, pnl.isAcceptableOrUnknown(data['pnl']!, _pnlMeta));
    } else if (isInserting) {
      context.missing(_pnlMeta);
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    } else if (isInserting) {
      context.missing(_closedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trade map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trade(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      symbol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symbol'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      lotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lot_size'])!,
      pnl: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pnl'])!,
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at'])!,
    );
  }

  @override
  $TradesTable createAlias(String alias) {
    return $TradesTable(attachedDatabase, alias);
  }
}

class Trade extends DataClass implements Insertable<Trade> {
  final String id;
  final String accountId;
  final String symbol;
  final String type;
  final double lotSize;
  final double pnl;
  final DateTime closedAt;
  const Trade(
      {required this.id,
      required this.accountId,
      required this.symbol,
      required this.type,
      required this.lotSize,
      required this.pnl,
      required this.closedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['symbol'] = Variable<String>(symbol);
    map['type'] = Variable<String>(type);
    map['lot_size'] = Variable<double>(lotSize);
    map['pnl'] = Variable<double>(pnl);
    map['closed_at'] = Variable<DateTime>(closedAt);
    return map;
  }

  TradesCompanion toCompanion(bool nullToAbsent) {
    return TradesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      symbol: Value(symbol),
      type: Value(type),
      lotSize: Value(lotSize),
      pnl: Value(pnl),
      closedAt: Value(closedAt),
    );
  }

  factory Trade.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trade(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      symbol: serializer.fromJson<String>(json['symbol']),
      type: serializer.fromJson<String>(json['type']),
      lotSize: serializer.fromJson<double>(json['lotSize']),
      pnl: serializer.fromJson<double>(json['pnl']),
      closedAt: serializer.fromJson<DateTime>(json['closedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'symbol': serializer.toJson<String>(symbol),
      'type': serializer.toJson<String>(type),
      'lotSize': serializer.toJson<double>(lotSize),
      'pnl': serializer.toJson<double>(pnl),
      'closedAt': serializer.toJson<DateTime>(closedAt),
    };
  }

  Trade copyWith(
          {String? id,
          String? accountId,
          String? symbol,
          String? type,
          double? lotSize,
          double? pnl,
          DateTime? closedAt}) =>
      Trade(
        id: id ?? this.id,
        accountId: accountId ?? this.accountId,
        symbol: symbol ?? this.symbol,
        type: type ?? this.type,
        lotSize: lotSize ?? this.lotSize,
        pnl: pnl ?? this.pnl,
        closedAt: closedAt ?? this.closedAt,
      );
  Trade copyWithCompanion(TradesCompanion data) {
    return Trade(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      type: data.type.present ? data.type.value : this.type,
      lotSize: data.lotSize.present ? data.lotSize.value : this.lotSize,
      pnl: data.pnl.present ? data.pnl.value : this.pnl,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trade(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('lotSize: $lotSize, ')
          ..write('pnl: $pnl, ')
          ..write('closedAt: $closedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accountId, symbol, type, lotSize, pnl, closedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trade &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.symbol == this.symbol &&
          other.type == this.type &&
          other.lotSize == this.lotSize &&
          other.pnl == this.pnl &&
          other.closedAt == this.closedAt);
}

class TradesCompanion extends UpdateCompanion<Trade> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> symbol;
  final Value<String> type;
  final Value<double> lotSize;
  final Value<double> pnl;
  final Value<DateTime> closedAt;
  final Value<int> rowid;
  const TradesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.symbol = const Value.absent(),
    this.type = const Value.absent(),
    this.lotSize = const Value.absent(),
    this.pnl = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TradesCompanion.insert({
    required String id,
    required String accountId,
    required String symbol,
    required String type,
    required double lotSize,
    required double pnl,
    required DateTime closedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        accountId = Value(accountId),
        symbol = Value(symbol),
        type = Value(type),
        lotSize = Value(lotSize),
        pnl = Value(pnl),
        closedAt = Value(closedAt);
  static Insertable<Trade> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? symbol,
    Expression<String>? type,
    Expression<double>? lotSize,
    Expression<double>? pnl,
    Expression<DateTime>? closedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (symbol != null) 'symbol': symbol,
      if (type != null) 'type': type,
      if (lotSize != null) 'lot_size': lotSize,
      if (pnl != null) 'pnl': pnl,
      if (closedAt != null) 'closed_at': closedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TradesCompanion copyWith(
      {Value<String>? id,
      Value<String>? accountId,
      Value<String>? symbol,
      Value<String>? type,
      Value<double>? lotSize,
      Value<double>? pnl,
      Value<DateTime>? closedAt,
      Value<int>? rowid}) {
    return TradesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      lotSize: lotSize ?? this.lotSize,
      pnl: pnl ?? this.pnl,
      closedAt: closedAt ?? this.closedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (lotSize.present) {
      map['lot_size'] = Variable<double>(lotSize.value);
    }
    if (pnl.present) {
      map['pnl'] = Variable<double>(pnl.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TradesCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('lotSize: $lotSize, ')
          ..write('pnl: $pnl, ')
          ..write('closedAt: $closedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $TradesTable trades = $TradesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [accounts, trades];
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  required String id,
  required String name,
  required String propFirm,
  required String accountType,
  required double startingBalance,
  required double currentBalance,
  required double profitTarget,
  required double dailyLossLimit,
  required double maxDrawdown,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> propFirm,
  Value<String> accountType,
  Value<double> startingBalance,
  Value<double> currentBalance,
  Value<double> profitTarget,
  Value<double> dailyLossLimit,
  Value<double> maxDrawdown,
  Value<int> rowid,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TradesTable, List<Trade>> _tradesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.trades,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.trades.accountId));

  $$TradesTableProcessedTableManager get tradesRefs {
    final manager = $$TradesTableTableManager($_db, $_db.trades)
        .filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tradesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get propFirm => $composableBuilder(
      column: $table.propFirm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountType => $composableBuilder(
      column: $table.accountType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get startingBalance => $composableBuilder(
      column: $table.startingBalance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get currentBalance => $composableBuilder(
      column: $table.currentBalance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get profitTarget => $composableBuilder(
      column: $table.profitTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dailyLossLimit => $composableBuilder(
      column: $table.dailyLossLimit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxDrawdown => $composableBuilder(
      column: $table.maxDrawdown, builder: (column) => ColumnFilters(column));

  Expression<bool> tradesRefs(
      Expression<bool> Function($$TradesTableFilterComposer f) f) {
    final $$TradesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trades,
        getReferencedColumn: (t) => t.accountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradesTableFilterComposer(
              $db: $db,
              $table: $db.trades,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get propFirm => $composableBuilder(
      column: $table.propFirm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountType => $composableBuilder(
      column: $table.accountType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get startingBalance => $composableBuilder(
      column: $table.startingBalance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get currentBalance => $composableBuilder(
      column: $table.currentBalance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get profitTarget => $composableBuilder(
      column: $table.profitTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dailyLossLimit => $composableBuilder(
      column: $table.dailyLossLimit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxDrawdown => $composableBuilder(
      column: $table.maxDrawdown, builder: (column) => ColumnOrderings(column));
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get propFirm =>
      $composableBuilder(column: $table.propFirm, builder: (column) => column);

  GeneratedColumn<String> get accountType => $composableBuilder(
      column: $table.accountType, builder: (column) => column);

  GeneratedColumn<double> get startingBalance => $composableBuilder(
      column: $table.startingBalance, builder: (column) => column);

  GeneratedColumn<double> get currentBalance => $composableBuilder(
      column: $table.currentBalance, builder: (column) => column);

  GeneratedColumn<double> get profitTarget => $composableBuilder(
      column: $table.profitTarget, builder: (column) => column);

  GeneratedColumn<double> get dailyLossLimit => $composableBuilder(
      column: $table.dailyLossLimit, builder: (column) => column);

  GeneratedColumn<double> get maxDrawdown => $composableBuilder(
      column: $table.maxDrawdown, builder: (column) => column);

  Expression<T> tradesRefs<T extends Object>(
      Expression<T> Function($$TradesTableAnnotationComposer a) f) {
    final $$TradesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trades,
        getReferencedColumn: (t) => t.accountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TradesTableAnnotationComposer(
              $db: $db,
              $table: $db.trades,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AccountsTable,
    Account,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (Account, $$AccountsTableReferences),
    Account,
    PrefetchHooks Function({bool tradesRefs})> {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> propFirm = const Value.absent(),
            Value<String> accountType = const Value.absent(),
            Value<double> startingBalance = const Value.absent(),
            Value<double> currentBalance = const Value.absent(),
            Value<double> profitTarget = const Value.absent(),
            Value<double> dailyLossLimit = const Value.absent(),
            Value<double> maxDrawdown = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsCompanion(
            id: id,
            name: name,
            propFirm: propFirm,
            accountType: accountType,
            startingBalance: startingBalance,
            currentBalance: currentBalance,
            profitTarget: profitTarget,
            dailyLossLimit: dailyLossLimit,
            maxDrawdown: maxDrawdown,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String propFirm,
            required String accountType,
            required double startingBalance,
            required double currentBalance,
            required double profitTarget,
            required double dailyLossLimit,
            required double maxDrawdown,
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsCompanion.insert(
            id: id,
            name: name,
            propFirm: propFirm,
            accountType: accountType,
            startingBalance: startingBalance,
            currentBalance: currentBalance,
            profitTarget: profitTarget,
            dailyLossLimit: dailyLossLimit,
            maxDrawdown: maxDrawdown,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AccountsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({tradesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tradesRefs) db.trades],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tradesRefs)
                    await $_getPrefetchedData<Account, $AccountsTable, Trade>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._tradesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0).tradesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.accountId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AccountsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AccountsTable,
    Account,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (Account, $$AccountsTableReferences),
    Account,
    PrefetchHooks Function({bool tradesRefs})>;
typedef $$TradesTableCreateCompanionBuilder = TradesCompanion Function({
  required String id,
  required String accountId,
  required String symbol,
  required String type,
  required double lotSize,
  required double pnl,
  required DateTime closedAt,
  Value<int> rowid,
});
typedef $$TradesTableUpdateCompanionBuilder = TradesCompanion Function({
  Value<String> id,
  Value<String> accountId,
  Value<String> symbol,
  Value<String> type,
  Value<double> lotSize,
  Value<double> pnl,
  Value<DateTime> closedAt,
  Value<int> rowid,
});

final class $$TradesTableReferences
    extends BaseReferences<_$AppDatabase, $TradesTable, Trade> {
  $$TradesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.trades.accountId, db.accounts.id));

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TradesTableFilterComposer
    extends Composer<_$AppDatabase, $TradesTable> {
  $$TradesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symbol => $composableBuilder(
      column: $table.symbol, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lotSize => $composableBuilder(
      column: $table.lotSize, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get pnl => $composableBuilder(
      column: $table.pnl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TradesTableOrderingComposer
    extends Composer<_$AppDatabase, $TradesTable> {
  $$TradesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symbol => $composableBuilder(
      column: $table.symbol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lotSize => $composableBuilder(
      column: $table.lotSize, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get pnl => $composableBuilder(
      column: $table.pnl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TradesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TradesTable> {
  $$TradesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get lotSize =>
      $composableBuilder(column: $table.lotSize, builder: (column) => column);

  GeneratedColumn<double> get pnl =>
      $composableBuilder(column: $table.pnl, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TradesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TradesTable,
    Trade,
    $$TradesTableFilterComposer,
    $$TradesTableOrderingComposer,
    $$TradesTableAnnotationComposer,
    $$TradesTableCreateCompanionBuilder,
    $$TradesTableUpdateCompanionBuilder,
    (Trade, $$TradesTableReferences),
    Trade,
    PrefetchHooks Function({bool accountId})> {
  $$TradesTableTableManager(_$AppDatabase db, $TradesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TradesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TradesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TradesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> accountId = const Value.absent(),
            Value<String> symbol = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> lotSize = const Value.absent(),
            Value<double> pnl = const Value.absent(),
            Value<DateTime> closedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TradesCompanion(
            id: id,
            accountId: accountId,
            symbol: symbol,
            type: type,
            lotSize: lotSize,
            pnl: pnl,
            closedAt: closedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String accountId,
            required String symbol,
            required String type,
            required double lotSize,
            required double pnl,
            required DateTime closedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TradesCompanion.insert(
            id: id,
            accountId: accountId,
            symbol: symbol,
            type: type,
            lotSize: lotSize,
            pnl: pnl,
            closedAt: closedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TradesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (accountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.accountId,
                    referencedTable:
                        $$TradesTableReferences._accountIdTable(db),
                    referencedColumn:
                        $$TradesTableReferences._accountIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TradesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TradesTable,
    Trade,
    $$TradesTableFilterComposer,
    $$TradesTableOrderingComposer,
    $$TradesTableAnnotationComposer,
    $$TradesTableCreateCompanionBuilder,
    $$TradesTableUpdateCompanionBuilder,
    (Trade, $$TradesTableReferences),
    Trade,
    PrefetchHooks Function({bool accountId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$TradesTableTableManager get trades =>
      $$TradesTableTableManager(_db, _db.trades);
}
