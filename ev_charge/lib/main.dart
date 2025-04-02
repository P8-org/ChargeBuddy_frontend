import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_router.dart';
import 'core/database.dart';

/// A global provider for the Drift database
final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); // Calls _openConnection() internally
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Seeding and other asynchronous tasks can be done here

  runApp(const ProviderScope(child: MyApp()));
}

/// The main app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}