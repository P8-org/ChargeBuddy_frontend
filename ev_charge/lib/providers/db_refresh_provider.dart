import 'dart:async';

import 'package:ev_charge/core/platform_helper.dart';
import 'package:ev_charge/database/database.dart';
import 'package:ev_charge/database/db_manager.dart';
import 'package:ev_charge/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final databaseAutoUpdaterProvider = Provider<DatabaseAutoUpdater>((ref) {
  final db = ref.watch(dbProvider);
  final updater = DatabaseAutoUpdater.getInstance(db);
  ref.onDispose(() => updater.dispose());
  return updater;
});

class DatabaseAutoUpdater {
  final AppDatabase db;
  late WebSocketChannel _channel;

  static DatabaseAutoUpdater? _instance;

  DatabaseAutoUpdater._internal(this.db) {
    _connectWS();
  }

  static DatabaseAutoUpdater getInstance(AppDatabase db) {
    _instance ??= DatabaseAutoUpdater._internal(db);
    return _instance!;
  }

  void _connectWS() async {
    final url = "${getBaseUrl().replaceFirst("http", "ws")}/ws";
    while (true) {
      try {
        _channel = WebSocketChannel.connect(Uri.parse(url));
        await _channel.ready;
        print("ws connected");
        _channel.stream.listen(
          (event) => DbManager.updateDatabase(db),
          cancelOnError: true,
        );
        await _channel.sink.done;
      } finally {
        print("ws disconnected");
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  void dispose() {
    _channel.sink.close();
    _instance = null; // Allow a new instance to be created if needed
  }
}
