import 'package:flutter/material.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';

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

  void putEv(String userSetName, CarModel carModel, int evId, double currentCharge) async {
    final bs = BackendService();
    
    final userEv = UserEV(
      id: evId,
      userSetName: userSetName,
      currentCharge: currentCharge,
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
        scheduleData: 'n/a',
      ),
    );
    await bs.putEv(userEv, evId);
  }

  void addEv(String userSetName, CarModel carModel) async {
    final bs = BackendService();
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
        scheduleData: 'n/a',
      ),
    );
    await bs.postEv(userEv);
  }
}
