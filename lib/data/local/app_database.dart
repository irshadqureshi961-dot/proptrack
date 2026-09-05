import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'app_database.g.dart';

class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get propFirm => text().withDefault(const Constant('Prop Firm'))();
  TextColumn get accountType => text().withDefault(const Constant('Evaluation'))();
  RealColumn get startingBalance => real().withDefault(const Constant(10000.0))();
  RealColumn get currentBalance => real().withDefault(const Constant(10000.0))();
  RealColumn get profitTarget => real().withDefault(const Constant(1000.0))();
  RealColumn get dailyLossLimit => real().withDefault(const Constant(500.0))();
  RealColumn get maxDrawdown => real().withDefault(const Constant(1000.0))();
}

class Trades extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text()();
  TextColumn get symbol => text().withDefault(const Constant('EURUSD'))();
  TextColumn get type => text()();
  RealColumn get lotSize => real().withDefault(const Constant(1.0))();
  RealColumn get amount => real().withDefault(const Constant(0.0))();
  RealColumn get pnl => real().withDefault(const Constant(0.0))();
  DateTimeColumn get closedAt => dateTime().nullable()();
}

@DriftDatabase(tables: [Accounts, Trades])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}
