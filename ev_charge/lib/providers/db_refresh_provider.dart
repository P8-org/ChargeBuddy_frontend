import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ev_charge/database/db_manager.dart';
import 'package:ev_charge/main.dart';

import 'package:ev_charge/database/database.dart';

final databaseAutoUpdaterProvider = Provider<DatabaseAutoUpdater>((ref) {
  final db = ref.watch(dbProvider);
  final updater = DatabaseAutoUpdater(db);
  ref.onDispose(() => updater.dispose());
  return updater;
});

class DatabaseAutoUpdater {
  final AppDatabase db;
  late final Timer _timer;

  DatabaseAutoUpdater(this.db) {
    _timer = Timer.periodic(const Duration(minutes: 2), (_) {
      DbManager.updateDatabase(db);
    });
  }

  void dispose() {
    _timer.cancel();
  }
}
