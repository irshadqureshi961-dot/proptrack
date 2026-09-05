import 'package:drift/native.dart;
import 'package:drift/drift.dart';

part 'app_database.g.dart';

class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get propFirm => text()();
  TextColumn get accountType => text()();
  RealColumn get startingBalance => real()();
  RealColumn get currentBalance => real()();
  RealColumn get profitTarget => real()();
  RealColumn get dailyLossLimit => real()();
  RealColumn get maxDrawdown => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class Trades extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text().references(Accounts, #id)();
  TextColumn get symbol => text()();
  TextColumn get type => text()();
  RealColumn get lotSize => real()();
  RealColumn get pnl => real()();
  DateTimeColumn get closedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Accounts, Trades])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(DatabaseConnection(NativeDatabase.memory()));

  @override
  int get schemaVersion => 2;
}
