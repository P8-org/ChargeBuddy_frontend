import 'package:flutter/material.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';

class formVM extends ChangeNotifier {
  final BackendService _backendService;
  late UserEV _ev;
  bool _loading = false;
  bool _isError = false;
  String _errorMessage = "";

  formVM({BackendService? backendService})
    : _backendService = backendService ?? BackendService();

  UserEV get ev => _ev;
  bool get loading => _loading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  Future<void> getEv(int id) async {
    _loading = true;
    notifyListeners();
    try {
      _ev = await _backendService.getEvById(id);
      _isError = false;
    } catch (e) {
      _isError = true;
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void addEv(String modelName, String modelYear, String? userSetName, String batteryCapacity, String maxChargingPower) async {
    final bs = BackendService();
    // Step 1: POST /carmodels + retrieve 'correct' carModelId from db
    var carModel = CarModel(
      id: 0,
      modelName: modelName,
      modelYear: int.parse(modelYear),
      batteryCapacity: double.parse(batteryCapacity),
      maxChargingPower: double.parse(maxChargingPower),
    );
    final carModelId = await bs.postCarModel(carModel);

    // step 2: Create new carModel with an Id that points to the created carmodel on the db
    carModel = CarModel(
      id: carModelId,
      modelName: modelName,
      modelYear: int.parse(modelYear),
      batteryCapacity: double.parse(batteryCapacity),
      maxChargingPower: double.parse(maxChargingPower),
    );

    // step 3: Validate userSetName (its optional in the form but not on the DB)
    if (userSetName == null || userSetName.isEmpty) {
      userSetName = modelName;
    }

    // Step 4: create UserEV object + POST /evs
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
