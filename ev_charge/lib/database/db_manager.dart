import 'package:flutter/foundation.dart';

import 'database.dart';

class DbManager {
  static Future<AppDatabase> initialize({
    bool debugMode = false,
    bool clearDB = false,
  }) async {
    final db = AppDatabase();

    if (clearDB) {
      await _resetDatabase(db);
    }

    if (debugMode) {
      if (kDebugMode) {
        print('[Debug] Seeding database...');
      }
    //  await _seedDatabase(db);
    }
    return db;
  }

  static Future<void> _seedDatabase(AppDatabase db) async {
    // Avoid duplicate seeding — only insert if empty
    final existingEVModels = await db.select(db.eVCarModels).get();
    final existingUserEVs = await db.select(db.userEVs).get();
    final existingConstraints = await db.select(db.constraints).get();
    final existingSchedules = await db.select(db.schedules).get();

    if (existingEVModels.isEmpty) {
      // Seed EVCarModels
      if (kDebugMode) {
        print('[Seed] EVCarModels seeding.');
      }
      await db.batch((batch) {
        batch.insertAll(db.eVCarModels, [
          EVCarModelsCompanion.insert(
            modelName: 'Model S',
            modelYear: 2020,
            batteryCapacity: 100.0,
            maxChargingPower: 250.0,
          ),
          EVCarModelsCompanion.insert(
            modelName: 'Model 3',
            modelYear: 2022,
            batteryCapacity: 75.0,
            maxChargingPower: 200.0,
          ),
        ]);
      });
    }

    if (existingUserEVs.isEmpty) {
      // Seed UserEVs
      if (kDebugMode) {
        print('[Seed] userEVs seeding.');
      }
      await db
          .into(db.userEVs)
          .insert(
            UserEVsCompanion.insert(
              carModelId: 1,
              userSetName: 'Fjolle Bilen',
              currentCharge: 32.4,
            ),
          );
    }

    if (existingConstraints.isEmpty) {
      // Seed Constraints
      if (kDebugMode) {
        print('[Seed] Constraints seeding.');
      }
      await db.batch((batch) {
        batch.insertAll(db.constraints, [
          ConstraintsCompanion.insert(
            userCarModelId: 1,
            dayOfWeek: 1,
            startMinutes: 0,
            endMinutes: 10,
          ),
        ]);
      });
    }

    if (existingSchedules.isEmpty) {
      // Seed UserEVs
      if (kDebugMode) {
        print('[Seed] userEVs seeding.');
      }
      await db
          .into(db.schedules)
          .insert(
            SchedulesCompanion.insert(
              userEvId: 1,
              chargeKwh: 15,
              chargeHour: 18,
            ),
          );
    }
  }

  static Future<void> _resetDatabase(AppDatabase db) async {
    await db.delete(db.schedules).go();
    await db.delete(db.constraints).go();
    await db.delete(db.userEVs).go();
    await db.delete(db.eVCarModels).go();
    await db.customStatement('DELETE FROM sqlite_sequence;');

    if (kDebugMode) print('[Reset] All tables cleared, autoincrements reset.');
  }
}
