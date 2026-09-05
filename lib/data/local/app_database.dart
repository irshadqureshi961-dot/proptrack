import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'app_database.g.dart';

class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
}

class Trades extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text()();
}

@DriftDatabase(tables: [Accounts, Trades])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}
