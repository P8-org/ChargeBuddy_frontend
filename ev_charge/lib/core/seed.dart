import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'database.dart';

Future<void> seedDatabase(AppDatabase db) async {
  // Avoid duplicate seeding — only insert if empty
  final existingModels = await db.select(db.eVCarModels).get();
  if (existingModels.isNotEmpty) return;

  // Seed EVCarModels
  await db.batch((batch) {
    batch.insertAll(db.eVCarModels, [
      EVCarModelsCompanion.insert(
        modelName: 'Model S',
        modelYear: const Value(2020),
        batteryCapacity: 100.0,
        maxChargingPower: 250.0,
      ),
      EVCarModelsCompanion.insert(
        modelName: 'Model 3',
        modelYear: const Value(2022),
        batteryCapacity: 75.0,
        maxChargingPower: 200.0,
      ),
    ]);
  });

  if (kDebugMode) {
    print('[Seed] EVCarModels seeded.');
  }
}
