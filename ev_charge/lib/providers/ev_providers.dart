import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/models.dart';
import '../database/dao/ev_dao.dart';
import '../main.dart';

final evDaoProvider = Provider<EvDao>((ref) {
  final db = ref.watch(dbProvider); // global DB from main.dart
  return EvDao(db);                  // DAO depends on AppDatabase
});

final userEvsProvider = StreamProvider<List<UserEV>>((ref) {
  final dao = ref.watch(evDaoProvider);
  return dao.watchUserEVsWithDetails(); // exposes the DAO's stream
});
