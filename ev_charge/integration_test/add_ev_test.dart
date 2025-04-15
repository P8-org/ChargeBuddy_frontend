import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ev_charge/core/database.dart';
import 'package:drift/native.dart';

import 'package:ev_charge/main.dart';
import 'package:ev_charge/core/app_router.dart';

void main() {
  
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() {
    // Use NativeDatabase.memory() for an in-memory DB for testing
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('Add EV test (Hardcoded form entires)', (WidgetTester tester) async {
    
    router.go('/add_ev');
    
    await tester.pumpWidget(ProviderScope(overrides: [dbProvider.overrideWithValue(db)], child: MaterialApp.router(routerConfig: router,)));

    final formTextFields = ['Model', 'Model Year', 'Battery Capacity (kWh)', 'Maximum Charging Power (kW)'];
    var formLocations = <Finder>[];

    for (final element in formTextFields) {
      formLocations.add(find.ancestor(
      of: find.text(element),
      matching: find.byType(TextFormField)));
    }
                      
    for (final location in formLocations) {
      await tester.tap(location);
      await tester.enterText(location, '123');
      await tester.pump();
    }

    await tester.tap(find.ancestor(
      of: find.text('Submit'),
      matching: find.byType(ElevatedButton)));

    await tester.pump();

    final models = await db.select(db.eVCarModels).get();

    expect(models.length, 1);
    expect(models.first.modelName, '123');
    expect(models.first.modelYear, 123);
    expect(models.first.batteryCapacity, 123);
    expect(models.first.maxChargingPower, 123);
    
  });
}
