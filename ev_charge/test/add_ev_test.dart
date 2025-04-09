import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ev_charge/main.dart';

import 'package:ev_charge/views/add_ev.dart';
import 'package:ev_charge/core/app_router.dart';
import 'package:ev_charge/main.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('Add EV: form textField test', (WidgetTester tester) async {
    router.go('/add_ev');
    await tester.pumpWidget(ProviderScope(child: MaterialApp.router(routerConfig: router)));
    //final BuildContext context = tester.element(find.byType(Container));
    //final db = ProviderScope.containerOf(tester.element(find.byType(Container)));
    //print(db);

    final formTextFields = ['Model', 'Model Year', 'Battery Capacity (kWh)', 'Maximum Charging Power (kW)'];
    var formLocations = <Finder>[];
    for (final element in formTextFields) {
      formLocations.add(find.ancestor(
      of: find.text(element),
      matching: find.byType(TextFormField)));
    }
                      //final db = ProviderScope.containerOf(context).read(dbProvider);
    for (final location in formLocations) {
      await tester.tap(location);
      await tester.enterText(location, '123');
    }
    await tester.enterText(formLocations[3], 'xxx');

    await tester.tap(find.ancestor(
      of: find.text('Submit'),
      matching: find.byType(ElevatedButton)));

    await tester.pump();
    
    final messageFinder = find.text('Please enter a numerical value');
    print(messageFinder);

    await tester.tap(find.ancestor(
      of: find.text('Cancel'),
      matching: find.byType(ElevatedButton)));
    

  });
}
