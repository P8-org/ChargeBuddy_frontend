// lib/database/dao/ev_dao.dart
import 'package:drift/drift.dart';
import '../database.dart';
import '../../core/models.dart' as models;

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
}
