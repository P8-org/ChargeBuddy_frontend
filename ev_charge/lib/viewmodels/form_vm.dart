import 'package:flutter/material.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';

class FormVM extends ChangeNotifier {
  final BackendService _backendService;

  FormVM({BackendService? backendService})
    : _backendService = backendService ?? BackendService();

  // TODO vi skal have lavet så man kan overskrive max charging power fra carModel
  Future<bool> putEv(
    String userSetName,
    CarModel carModel,
    UserEV oldUserEv,
  ) async {
    final userEv = UserEV(
      id: oldUserEv.id,
      userSetName: userSetName,
      currentCharge: oldUserEv.currentCharge,
      state: oldUserEv.state,
      currentChargingPower: oldUserEv.currentChargingPower,
      maxChargingPower: oldUserEv.maxChargingPower,
      carModelId: carModel.id,
      carModel: carModel,
      constraints: oldUserEv.constraints,
      schedule: oldUserEv.schedule,
    );
    try {
      await _backendService.putEv(userEv, oldUserEv.id);
      return (true);
    } catch (e) {
      return (false);
    }
  }

  Future<bool> addEv(String userSetName, CarModel carModel) async {
    final userEv = UserEV(
      id: 0,
      userSetName: userSetName,
      currentCharge: 0,
      state: 'idle',
      currentChargingPower: 0,
      maxChargingPower: carModel.maxChargingPower,
      carModelId: carModel.id,
      carModel: carModel,
      constraints: List<Constraint>.empty(),
      schedule: null,
    );
    try {
      await _backendService.postEv(userEv);
      return (true);
    } catch (e) {
      return (false);
    }
  }
}
