import 'package:drift/drift.dart';
import 'package:ev_charge/core/backend_service.dart';
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

    await _updateDatabase(db);

    // if (debugMode) {
    //   if (kDebugMode) {
    //     print('[Debug] Seeding database...');
    //   }
    //   await _seedDatabase(db);
    // }

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
            userEvId: 1,
            chargedBy: DateTime.now(),
            minPercentage: 80,
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
              start: DateTime.now(),
              end: DateTime.now(),
              scheduleData: "scheduleData",
            ),
          );
    }
  }

  static Future<void> _resetDatabase(AppDatabase db) async {
    await db.delete(db.schedules).go();
    await db.delete(db.constraints).go();
    await db.delete(db.userEVs).go();
    await db.delete(db.eVCarModels).go();
    // await db.customStatement('DELETE FROM sqlite_sequence;');

    if (kDebugMode) print('[Reset] All tables cleared, autoincrements reset.');
  }

  static Future<void> _updateDatabase(AppDatabase db) async {
    try {
      final evList = await BackendService().getEvs();

      await _resetDatabase(db);

      for (final ev in evList) {
        await db
            .into(db.eVCarModels)
            .insertOnConflictUpdate(
              EVCarModelsCompanion.insert(
                id: Value(ev.carModel.id),
                modelName: ev.carModel.modelName,
                modelYear: ev.carModel.modelYear,
                batteryCapacity: ev.carModel.batteryCapacity,
                maxChargingPower: ev.carModel.maxChargingPower,
              ),
            );

        await db
            .into(db.userEVs)
            .insertOnConflictUpdate(
              UserEVsCompanion.insert(
                id: Value(ev.id),
                carModelId: ev.carModel.id,
                userSetName: ev.userSetName,
                currentCharge: ev.currentCharge,
              ),
            );

        await db
            .into(db.schedules)
            .insertOnConflictUpdate(
              SchedulesCompanion.insert(
                id: Value(ev.schedule.id),
                userEvId: ev.id,
                start: ev.schedule.start,
                end: ev.schedule.end,
                scheduleData: ev.schedule.scheduleData,
              ),
            );

        await db
            .into(db.constraints)
            .insertOnConflictUpdate(
              ConstraintsCompanion.insert(
                id: Value(ev.constraint.id),
                userEvId: ev.id,
                chargedBy: ev.constraint.chargedBy,
                minPercentage: ev.constraint.targetPercentage,
              ),
            );
      }

      if (kDebugMode) print('[Update] Database updated.');
    } catch (e) {
      if (kDebugMode) {
        print(
          '[Warning] Error fetching data from backend, keeping local cache.',
        );
        print('[Error]: $e');
      }
    }
  }
}
