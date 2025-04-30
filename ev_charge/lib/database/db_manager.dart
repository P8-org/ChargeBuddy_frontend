import 'dart:async';

import 'package:drift/drift.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:flutter/foundation.dart';

import 'database.dart';

class DbManager {
  static Future<AppDatabase> initialize({
    bool debugMode = false,
    bool clearDB = false,
  }) async {
    if (kDebugMode) {
      print('[Debug] Initializing database...');
    }
    final db = AppDatabase();

    if (clearDB) {
      await _resetDatabase(db);
    }
    await updateDatabase(db);

    return db;
  }

  static Future<void> _resetDatabase(AppDatabase db) async {
    await db.delete(db.schedules).go();
    await db.delete(db.constraints).go();
    await db.delete(db.userEVs).go();
    await db.delete(db.eVCarModels).go();
    // await db.customStatement('DELETE FROM sqlite_sequence;');

    if (kDebugMode) print('[Reset] All tables cleared, autoincrements reset.');
  }

  static Future<void> updateDatabase(AppDatabase db) async {
    try {
      final evList = await BackendService().getEvs().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException("Fetching EVs from backend timed out.");
        },
      );

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
                currentChargePower: ev.currentChargingPower,
                state: ev.state,
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
                startCharge: ev.schedule.startCharge,
                scheduleData: ev.schedule.scheduleData,
              ),
            );

        for (final constraint in ev.constraints) {
          await db
              .into(db.constraints)
              .insertOnConflictUpdate(
                ConstraintsCompanion.insert(
                  id: Value(constraint.id),
                  userEvId: ev.id,
                  startTime: constraint.startTime,
                  chargedBy: constraint.chargedBy,
                  minPercentage: constraint.targetPercentage,
                ),
              );
        }
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
