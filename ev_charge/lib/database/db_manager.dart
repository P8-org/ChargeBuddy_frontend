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

      final carModels = await BackendService().getCarModels().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException("Fetching CarModels from backend timed out.");
        },
      );

      await _resetDatabase(db);

      for (final carModel in carModels) {
        await db
            .into(db.eVCarModels)
            .insertOnConflictUpdate(
              EVCarModelsCompanion.insert(
                id: Value(carModel.id),
                modelName: carModel.modelName,
                modelYear: carModel.modelYear,
                batteryCapacity: carModel.batteryCapacity,
                maxChargingPower: carModel.maxChargingPower,
              ),
            );
      }

      for (final ev in evList) {
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

        if (ev.schedule != null) {
          await db
              .into(db.schedules)
              .insertOnConflictUpdate(
                SchedulesCompanion.insert(
                  id: Value(ev.schedule!.id),
                  userEvId: ev.id,
                  start: ev.schedule!.start,
                  end: ev.schedule!.end,
                  startCharge: ev.schedule!.startCharge,
                  scheduleData: ev.schedule!.scheduleData,
                  feasible: ev.schedule!.feasible,
                ),
              );
        }

        for (final constraint in ev.constraints) {
          await db
              .into(db.constraints)
              .insertOnConflictUpdate(
                ConstraintsCompanion.insert(
                  id: Value(constraint.id),
                  userEvId: ev.id,
                  startTime: constraint.startTime,
                  endTime: constraint.endTime,
                  minPercentage: constraint.targetPercentage,
                ),
              );
        }
      }

      if (kDebugMode) print('[Update] Database updated.');
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(
          '[Warning] Error fetching data from backend, keeping local cache.',
        );
        print('[Error]: $e');
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }
}
