import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:ev_charge/core/database.dart'; // Update the import path

void main() {
  late AppDatabase db;

  setUp(() {
    // Use NativeDatabase.memory() for an in-memory DB for testing
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('can insert and read EVCarModel and UserEV', () async {
    final modelId = await db
        .into(db.eVCarModels)
        .insert(
          EVCarModelsCompanion.insert(
            modelName: 'Model X',
            modelYear: 2023,
            batteryCapacity: 85.0,
            maxChargingPower: 250.0,
          ),
        );

    final userEvId = await db
        .into(db.userEVs)
        .insert(
          UserEVsCompanion.insert(
            carModelId: modelId,
            userSetName: 'Test Car',
            currentCharge: 40.0,
          ),
        );

    final models = await db.select(db.eVCarModels).get();
    final userEvs = await db.select(db.userEVs).get();

    expect(models.length, 1);
    expect(models.first.modelName, 'Model X');

    expect(userEvs.length, 1);
    expect(userEvs.first.userSetName, 'Test Car');
  });
}
