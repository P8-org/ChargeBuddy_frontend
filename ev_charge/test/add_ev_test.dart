import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ev_charge/main.dart';

import 'package:ev_charge/views/add-ev.dart';
import 'package:ev_charge/core/app_router.dart';
import 'package:ev_charge/main.dart';
import 'package:go_router/go_router.dart';



void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    router.go('/add-ev');
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      )
    );

    await tester.pump();

    final titleFinder = find.text('Please enter some text');
    expect(titleFinder, findsWidgets);
  });

  
}
