class Constraint {
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final double targetPercentage;

  Constraint({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.targetPercentage,
  });

  factory Constraint.fromJson(Map<String, dynamic> json) {
    return Constraint(
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      targetPercentage: json['target_percentage'],
    );
  }
}

class Schedule {
  final int id;
  final DateTime start;
  final DateTime end;
  final String scheduleData;
  final double startCharge;
  final bool feasible;

  Schedule({
    required this.id,
    required this.start,
    required this.end,
    required this.startCharge,
    required this.scheduleData,
    required this.feasible,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      startCharge: json['start_charge'],
      scheduleData: json['schedule_data'],
      feasible: json['feasible'],
    );
  }
}

class CarModel {
  final int id;
  final String modelName;
  final int modelYear;
  final double batteryCapacity;
  final double maxChargingPower;

  CarModel({
    required this.id,
    required this.modelName,
    required this.modelYear,
    required this.batteryCapacity,
    required this.maxChargingPower,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      modelName: json['model_name'],
      modelYear: json['model_year'],
      batteryCapacity: json['battery_capacity'],
      maxChargingPower: json['max_charging_power'],
    );
  }
}

class UserEV {
  final int id;
  final String userSetName;
  double currentCharge;
  String state;
  final double currentChargingPower;
  final double maxChargingPower;
  final int carModelId;
  final CarModel carModel;
  final List<Constraint> constraints;
  final Schedule? schedule;

  UserEV({
    required this.id,
    required this.userSetName,
    required this.currentCharge,
    required this.state,
    required this.currentChargingPower,
    required this.maxChargingPower,
    required this.carModelId,
    required this.carModel,
    required this.constraints,
    required this.schedule,
  });

  factory UserEV.fromJson(Map<String, dynamic> json) {
    var constraintListJson = json['constraints'] as List;
    List<Constraint> constraints =
        constraintListJson
            .map((constraint) => Constraint.fromJson(constraint))
            .toList();
    return UserEV(
      id: json['id'],
      userSetName: json['user_set_name'],
      currentCharge: json['current_charge'],
      state: json['state'] ?? 'charging',
      currentChargingPower: json['current_charging_power'],
      maxChargingPower: json['max_charging_power'],
      carModelId: json['car_model_id'],
      carModel: CarModel.fromJson(json['car_model']),
      constraints: constraints,
      schedule:
          json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null,
    );
  }
}
