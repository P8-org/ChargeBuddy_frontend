import 'package:drift/drift.dart';

import '../../core/models.dart' as models;
import '../database.dart';

part 'ev_dao.g.dart';

@DriftAccessor(tables: [UserEVs, EVCarModels, Constraints, Schedules])
class EvDao extends DatabaseAccessor<AppDatabase> with _$EvDaoMixin {
  EvDao(super.db);

  Stream<List<models.UserEV>> watchUserEVsWithDetails() async* {
    final userEvsStream = select(userEVs).watch();

    await for (final userEvs in userEvsStream) {
      final evList = <models.UserEV>[];

      for (final ev in userEvs) {
        final carModel =
            await (select(eVCarModels)
              ..where((t) => t.id.equals(ev.carModelId))).getSingle();

        final constraintsList =
            await (select(constraints)
              ..where((t) => t.userEvId.equals(ev.id))).get();

        final schedule =
            await (select(schedules)
              ..where((t) => t.userEvId.equals(ev.id))).getSingleOrNull();

        evList.add(
          models.UserEV(
            id: ev.id,
            userSetName: ev.userSetName,
            currentCharge: ev.currentCharge,
            currentChargingPower: ev.currentChargingPower,
            maxChargingPower: ev.maxChargingPower,
            state: ev.state,
            carModelId: ev.carModelId,
            carModel: models.CarModel(
              id: carModel.id,
              modelName: carModel.modelName,
              modelYear: carModel.modelYear,
              batteryCapacity: carModel.batteryCapacity,
              maxChargingPower: carModel.maxChargingPower,
            ),
            constraints:
                constraintsList
                    .map(
                      (c) => models.Constraint(
                        id: c.id,
                        startTime: c.startTime,
                        endTime: c.endTime,
                        targetPercentage: c.minPercentage,
                      ),
                    )
                    .toList(),
            schedule:
                schedule == null
                    ? null
                    : models.Schedule(
                      id: schedule.id,
                      start: schedule.start,
                      end: schedule.end,
                      startCharge: schedule.startCharge,
                      scheduleData: schedule.scheduleData,
                      feasible: schedule.feasible,
                    ),
          ),
        );
      }

      yield evList;
    }
  }

  Stream<models.UserEV?> watchSingleEVWithDetails(int id) async* {
    await for (final evList
        in (select(userEVs)..where((t) => t.id.equals(id))).watch()) {
      if (evList.isEmpty) {
        yield null;
      } else {
        final userEv = evList.first;

        final carModel =
            await (select(eVCarModels)
              ..where((t) => t.id.equals(userEv.carModelId))).getSingle();

        final constraintsList =
            await (select(constraints)
              ..where((t) => t.userEvId.equals(userEv.id))).get();

        final schedule =
            await (select(schedules)
              ..where((t) => t.userEvId.equals(userEv.id))).getSingleOrNull();

        yield models.UserEV(
          id: userEv.id,
          userSetName: userEv.userSetName,
          currentCharge: userEv.currentCharge,
          currentChargingPower: userEv.currentChargingPower,
          maxChargingPower: userEv.maxChargingPower,
          state: userEv.state,
          carModelId: userEv.carModelId,
          carModel: models.CarModel(
            id: carModel.id,
            modelName: carModel.modelName,
            modelYear: carModel.modelYear,
            batteryCapacity: carModel.batteryCapacity,
            maxChargingPower: carModel.maxChargingPower,
          ),
          constraints:
              constraintsList
                  .map(
                    (c) => models.Constraint(
                      id: c.id,
                      startTime: c.startTime,
                      endTime: c.endTime,
                      targetPercentage: c.minPercentage,
                    ),
                  )
                  .toList(),
          schedule:
              schedule == null
                  ? null
                  : models.Schedule(
                    id: schedule.id,
                    start: schedule.start,
                    end: schedule.end,
                    startCharge: schedule.startCharge,
                    scheduleData: schedule.scheduleData,
                    feasible: schedule.feasible,
                  ),
        );
      }
    }
  }

  Stream<List<models.Constraint>> watchConstraintsForEv(int evId) {
    return (select(constraints)
      ..where((tbl) => tbl.userEvId.equals(evId))).watch().map(
      (rows) =>
          rows
              .map(
                (c) => models.Constraint(
                  id: c.id,
                  startTime: c.startTime,
                  endTime: c.endTime,
                  targetPercentage: c.minPercentage,
                ),
              )
              .toList(),
    );
  }

  Future<models.Constraint?> getConstraintById(int constraintId) async {
    final c =
        await (select(constraints)
          ..where((t) => t.id.equals(constraintId))).getSingleOrNull();
    if (c == null) return null;

    return models.Constraint(
      id: c.id,
      startTime: c.startTime,
      endTime: c.endTime,
      targetPercentage: c.minPercentage,
    );
  }

  Stream<List<models.CarModel>> watchCarModels() {
    final query = select(eVCarModels);

    return query.watch().map((rows) {
      return rows.map((row) {
        return models.CarModel(
          id: row.id,
          modelName: row.modelName,
          modelYear: row.modelYear,
          batteryCapacity: row.batteryCapacity,
          maxChargingPower: row.maxChargingPower,
        );
      }).toList();
    });
  }
}
