import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';
import 'package:http/http.dart';

class formVM extends ChangeNotifier {
  final BackendService _backendService;
  late UserEV _ev;
  List<CarModel> _carModels = List.empty();
  bool _evLoading = false;
  bool _evIsError = false;
  String _evErrorMessage = "";
  bool _carmodelLoading = false;
  bool _carmodelIsError = false;
  String _carmodelErrorMessage = "";

  formVM({BackendService? backendService})
    : _backendService = backendService ?? BackendService();

  UserEV get ev => _ev;
  List<CarModel> get carmodels => _carModels;

  bool get carmodelLoading => _carmodelLoading;
  bool get carmodelIsError => _carmodelIsError;
  String get carmodelErrorMessage => _carmodelErrorMessage;

  bool get evLoading => _evLoading;
  bool get evIsError => _evIsError;
  String get evErrorMessage => _evErrorMessage;

  Future<void> getEv(int id) async {
    _evLoading = true;
    notifyListeners();
    try {
      _ev = await _backendService.getEvById(id);
      _evIsError = false;
    } catch (e) {
      _evIsError = true;
      _evErrorMessage = e.toString();
    } finally {
      _evLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCarmodels() async {
    _carmodelLoading = true;
    notifyListeners();
    try {
      _carModels = await _backendService.getCarModels();
      _carmodelIsError = false;
    } catch (e) {
      _carmodelIsError = true;
      _carmodelErrorMessage = e.toString();
    } finally {
      _carmodelLoading = false;
      notifyListeners();
    }
  }

  Future<bool> putEv(String userSetName, CarModel carModel, UserEV oldUserEv) async { 
    final userEv = UserEV(
      id: oldUserEv.id,
      userSetName: userSetName,
      currentCharge: oldUserEv.currentCharge,
      state: oldUserEv.state,
      currentChargingPower: oldUserEv.currentChargingPower,
      carModelId: carModel.id,
      carModel: carModel,
      constraint: oldUserEv.constraint,
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
      constraint: Constraint(
        id: 0,
        chargedBy: DateTime.now(),
        targetPercentage: 0,
      ),
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
