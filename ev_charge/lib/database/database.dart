import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class EVCarModels extends Table {
  late final id = integer()();
  late final modelName = text().withLength(min: 3, max: 64)();
  late final modelYear = integer()();
  late final batteryCapacity = real()();
  late final maxChargingPower = real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class UserEVs extends Table {
  late final id = integer()();
  late final carModelId = integer().references(EVCarModels, #id)();
  late final userSetName = text().withLength(min: 3, max: 64)();
  late final currentCharge = real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Constraints extends Table {
  late final id = integer()();
  late final userEvId = integer().references(UserEVs, #id)();
  late final chargedBy = dateTime()();
  late final minPercentage = real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Schedules extends Table {
  late final id = integer()();
  late final userEvId = integer().references(UserEVs, #id)();

  late final start = dateTime()();
  late final end = dateTime()();

  late final scheduleData = text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [EVCarModels, UserEVs, Constraints, Schedules])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    if (kIsWeb) {
      return driftDatabase(
        name: 'ev_charge_db',
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.dart.js'),
        ),
      );
    } else {
      return driftDatabase(
        name: 'chargeBuddy_database',
        native: const DriftNativeOptions(
          // By default, `driftDatabase` from `package:drift_flutter` stores the
          // database files in `getApplicationDocumentsDirectory()`.
          databaseDirectory: getApplicationSupportDirectory,
        ),
        // If you need web support, see https://drift.simonbinder.eu/platforms/web/
      );
    }
  }
}
