import 'package:flutter/material.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';

class FormVM extends ChangeNotifier {
  final BackendService _backendService;

  FormVM({BackendService? backendService})
    : _backendService = backendService ?? BackendService();

  Future<bool> putEv(String userSetName, CarModel carModel, UserEV oldUserEv) async { 
    final userEv = UserEV(
      id: oldUserEv.id,
      userSetName: userSetName,
      currentCharge: oldUserEv.currentCharge,
      state: oldUserEv.state,
      currentChargingPower: oldUserEv.currentChargingPower,
      carModelId: carModel.id,
      carModel: carModel,
      constraints: oldUserEv.constraints,
      schedule: oldUserEv.schedule
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
      state: 'Not Charging',
      currentChargingPower: 0,
      carModelId: carModel.id,
      carModel: carModel,
      constraints: List<Constraint>.empty(),
      schedule: Schedule(
        id: 0,
        start: DateTime.now(),
        end: DateTime.now(),
        startCharge: 0.0,
        scheduleData: 'n/a',
      ),
    );
    try {
      await _backendService.postEv(userEv);
      return (true);
    } catch (e) {
      return (false);
    }
  }
}
