import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/models.dart';
import '../database/dao/ev_dao.dart';
import '../main.dart';

final evDaoProvider = Provider<EvDao>((ref) {
  final db = ref.watch(dbProvider); // global DB from main.dart
  return EvDao(db); // DAO depends on AppDatabase
});

final allUserEvsProvider = StreamProvider<List<UserEV>>((ref) {
  final dao = ref.watch(evDaoProvider);
  return dao.watchUserEVsWithDetails(); // exposes the DAO's stream
});

final singleEvDetailProvider = StreamProvider.family<UserEV?, int>((ref, id) {
  final dao = ref.watch(evDaoProvider);
  return dao.watchSingleEVWithDetails(id);
});

final carModelsProvider = StreamProvider<List<CarModel>>((ref) {
  final dao = ref.watch(evDaoProvider);
  return dao.watchCarModels(); // exposes the DAO's stream
});

final localConstraintsStreamProvider =
StreamProvider.family<List<Constraint>, int>((ref, evId) {
  final dao = ref.watch(evDaoProvider);
  return dao.watchConstraintsForEv(evId);
});

final constraintByIdProvider = FutureProvider.family<Constraint?, int>((ref, constraintId) async {
  final dao = ref.watch(evDaoProvider);
  return await dao.getConstraintById(constraintId);
});
