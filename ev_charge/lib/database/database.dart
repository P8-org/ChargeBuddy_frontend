import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class EVCarModels extends Table {
  late final id = integer().autoIncrement()();
  late final modelName = text().withLength(min: 3, max: 64)();
  late final modelYear = integer().nullable()();
  late final batteryCapacity = real()();
  late final maxChargingPower = real()();
}

class UserEVs extends Table {
  late final id = integer().autoIncrement()();
  late final carModelId = integer().references(EVCarModels, #id)();
  late final userSetName = text().withLength(min: 3, max: 64)();
  late final currentCharge = real()();
}

class Constraints extends Table {
  late final id = integer().autoIncrement()();
  late final userCarModelId = integer().references(UserEVs, #id)();


  // The day of the week, 0 is Monday, 6 is Sunday
  late final Column<int> dayOfWeek = integer().check(dayOfWeek.isBetweenValues(0, 6))();

  // Stored as minutes since midnight: 0 = 00:00, 60 = 01:00, ..., 1380 = 23:00
  // Displayed in UI through TimeOfDay.fromMinutes(startMinutes)
  // Might be changed depending on back-end requirements
  late final Column<int> startMinutes = integer().check(startMinutes.isBetweenValues(0, 1440))();
  late final Column<int> endMinutes = integer().check(endMinutes.isBetweenValues(0, 1440))();

  // Optional: Prevent inverted ranges
  @override
  List<String> get customConstraints => [
    'CHECK (start_minutes < end_minutes)'
  ];
}

class Schedules extends Table {
  late final id = integer().autoIncrement()();
  late final userEvId = integer().references(UserEVs, #id)();

  /// Amount of energy needed (in kWh) for this hour
  late final chargeKwh = real()();

  /// The hour offset from [createdAt], e.g. 0 = current hour, 1 = +1h
  late final Column<int> chargeHour = integer().check(chargeHour.isBetweenValues(0, 24))();

  /// When this schedule was generated (e.g., by API call)
  late final createdAt = dateTime().withDefault(currentDateAndTime)();
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
