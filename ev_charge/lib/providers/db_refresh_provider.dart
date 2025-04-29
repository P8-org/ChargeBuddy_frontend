import 'dart:async';

import 'package:ev_charge/core/platform_helper.dart';
import 'package:ev_charge/database/database.dart';
import 'package:ev_charge/database/db_manager.dart';
import 'package:ev_charge/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final databaseAutoUpdaterProvider = Provider<DatabaseAutoUpdater>((ref) {
  final db = ref.watch(dbProvider);
  final updater = DatabaseAutoUpdater(db);
  ref.onDispose(() => updater.dispose());
  return updater;
});

class DatabaseAutoUpdater {
  final AppDatabase db;
  late bool _connected = false;
  late WebSocketChannel _channel;

  DatabaseAutoUpdater(this.db) {
    _connectWS();
  }

  void _connectWS() async {
    final url = "${getBaseUrl().replaceFirst("http", "ws")}/ws";
    _channel = WebSocketChannel.connect(Uri.parse(url));
    await _channel.ready;
    _connected = true;
    try {
      _channel.stream.listen(
        (event) => DbManager.updateDatabase(db),
        cancelOnError: false,
        onError: (error) {
          _connected = false;
          _tryReconnect();
        },
        onDone: () {
          _connected = false;
          _tryReconnect();
        },
      );
    } catch (e) {
      _tryReconnect();
    }
  }

  Future<void> _tryReconnect() async {
    while (!_connected) {
      // retry every 5 seconds
      await Future.delayed(const Duration(seconds: 5), () {
        _connectWS();
      });
    }
  }

  void dispose() {
    _channel.sink.close();
  }
}
