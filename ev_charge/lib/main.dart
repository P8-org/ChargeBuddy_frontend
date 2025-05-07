import 'package:ev_charge/core/app_router.dart';
import 'package:ev_charge/database/database.dart';
import 'package:ev_charge/database/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// A global provider for the Drift database
final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); // Calls _openConnection() internally
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Seeding and other asynchronous tasks can be done here
  final db = await DbManager.initialize(debugMode: true);
  runApp(
    ProviderScope(
      overrides: [dbProvider.overrideWithValue(db)],
      child: const MyApp(),
    ),
  );
}

/// The main app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          dynamicSchemeVariant: DynamicSchemeVariant.content,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
    );
  }
}
