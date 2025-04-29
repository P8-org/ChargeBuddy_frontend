import 'dart:convert';
import 'dart:io';

import 'package:ev_charge/core/models.dart';
import 'package:ev_charge/core/platform_helper.dart';
import 'package:http/http.dart';

class BackendService {
  final Client client;
  final String baseUrl;

  BackendService({Client? client, String? baseUrl})
    : client = client ?? Client(),
      baseUrl = baseUrl ?? getBaseUrl();
  
  Future<List<CarModel>> getCarModels() async {
    final uri = Uri.parse("$baseUrl/carmodels");
    final response = await client.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
    final jsonData = jsonDecode(response.body);
    return (jsonData as List).map((item) => CarModel.fromJson(item)).toList();
  }

  Future<List<UserEV>> getEvs() async {
    final uri = Uri.parse("$baseUrl/evs");
    final response = await client.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
    final jsonData = jsonDecode(response.body);
    return (jsonData as List).map((item) => UserEV.fromJson(item)).toList();
  }

  Future<UserEV> getEvById(int id) async {
    final uri = Uri.parse("$baseUrl/evs/$id");
    final response = await client.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
    final jsonData = jsonDecode(response.body);
    return UserEV.fromJson(jsonData);
  }

  Future<void> deleteEvById(int id) async {
    final uri = Uri.parse("$baseUrl/evs/$id");
    final response = await client.delete(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'Http error ${response.statusCode}: ${response.body}',
        uri: uri,
      );
    }
  }

  Future<void> postConstraint(
    int evId,
    DateTime deadline,
    double targetPercentage,
  ) async {
    final uri = Uri.parse("$baseUrl/evs/$evId/constraints");
    final response = await client.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'deadline': deadline.toIso8601String(),
        'target_percentage': targetPercentage,
      }),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'Http error ${response.statusCode}: ${response.body}',
        uri: uri,
      );
    }
  }

  Future<void> postEv(UserEV userEv) async {
    final uri = Uri.parse("$baseUrl/evs");
    final response = await client.post(
      uri,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": userEv.userSetName,
        "car_model_id": userEv.carModelId,
        "battery_level": userEv.currentCharge,
        })
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
  }

  Future<void> putEv(UserEV userEv, int id) async {
    final uri = Uri.parse("$baseUrl/evs/$id");
    final response = await client.put(
      uri,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": userEv.userSetName,
        "car_model_id": userEv.carModelId,
        "battery_level": userEv.currentCharge,
        })
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
  }

  Future<int> postCarModel(CarModel carModel) async {
    final uri = Uri.parse("$baseUrl/carmodels");
    final response = await client.post(
      uri,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": carModel.modelName,
        "year": carModel.modelYear,
        "battery_capacity": carModel.batteryCapacity,
        "max_charging_power": carModel.maxChargingPower,
        })
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
    return jsonDecode(response.body)['id'];
  }

  Future<void> putCarModel(CarModel carModel) async {
    final uri = Uri.parse("$baseUrl/carmodels/${carModel.id}");
    final response = await client.put(
      uri,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": carModel.modelName,
        "year": carModel.modelYear,
        "battery_capacity": carModel.batteryCapacity,
        "max_charging_power": carModel.maxChargingPower,
        })
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
  }
}
