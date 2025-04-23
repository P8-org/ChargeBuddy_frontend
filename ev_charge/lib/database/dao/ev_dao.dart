// lib/database/dao/ev_dao.dart
import 'package:drift/drift.dart';

import '../../core/models.dart' as models;
import '../database.dart';

part 'ev_dao.g.dart';

@DriftAccessor(tables: [UserEVs, EVCarModels, Constraints, Schedules])
class EvDao extends DatabaseAccessor<AppDatabase> with _$EvDaoMixin {
  EvDao(AppDatabase db) : super(db);

  Stream<List<models.UserEV>> watchUserEVsWithDetails() {
    final query = select(userEVs).join([
      innerJoin(eVCarModels, eVCarModels.id.equalsExp(userEVs.carModelId)),
      innerJoin(constraints, constraints.userEvId.equalsExp(userEVs.id)),
      innerJoin(schedules, schedules.userEvId.equalsExp(userEVs.id)),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final userEv = row.readTable(userEVs);
        final carModel = row.readTable(eVCarModels);
        final constraint = row.readTable(constraints);
        final schedule = row.readTable(schedules);

        return models.UserEV(
          id: userEv.id,
          userSetName: userEv.userSetName,
          currentCharge: userEv.currentCharge,
          currentChargingPower: 0,
          state: userEv.state,
          carModelId: userEv.carModelId,
          carModel: models.CarModel(
            id: carModel.id,
            modelName: carModel.modelName,
            modelYear: carModel.modelYear,
            batteryCapacity: carModel.batteryCapacity,
            maxChargingPower: carModel.maxChargingPower,
          ),
          constraint: models.Constraint(
            id: constraint.id,
            chargedBy: constraint.chargedBy,
            targetPercentage: constraint.minPercentage,
          ),
          schedule: models.Schedule(
            id: schedule.id,
            start: schedule.start,
            end: schedule.end,
            scheduleData: schedule.scheduleData,
          ),
        );
      }).toList();
    });
  }

  Future<models.UserEV?> getSingleEVWithDetails(int id) async {
    final userEv =
        await (select(userEVs)
          ..where((t) => t.id.equals(id))).getSingleOrNull();
    if (userEv == null) return null;

    final carModel =
        await (select(eVCarModels)
          ..where((t) => t.id.equals(userEv.carModelId))).getSingle();
    final constraint =
        await (select(constraints)
          ..where((t) => t.userEvId.equals(userEv.id))).getSingle();
    final schedule =
        await (select(schedules)
          ..where((t) => t.userEvId.equals(userEv.id))).getSingle();

    return models.UserEV(
      id: userEv.id,
      userSetName: userEv.userSetName,
      currentCharge: userEv.currentCharge,
      currentChargingPower: 0,
      state: userEv.state,
      carModelId: userEv.carModelId,
      carModel: models.CarModel(
        id: carModel.id,
        modelName: carModel.modelName,
        modelYear: carModel.modelYear,
        batteryCapacity: carModel.batteryCapacity,
        maxChargingPower: carModel.maxChargingPower,
      ),
      constraint: models.Constraint(
        id: constraint.id,
        chargedBy: constraint.chargedBy,
        targetPercentage: constraint.minPercentage,
      ),
      schedule: models.Schedule(
        id: schedule.id,
        start: schedule.start,
        end: schedule.end,
        scheduleData: schedule.scheduleData,
      ),
    );
  }
}
