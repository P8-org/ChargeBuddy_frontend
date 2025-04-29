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
  Future<void> postConstraint({
    required int evId,
    required DateTime start_time,
    required DateTime deadline,
    required double targetPercentage,
  }) async {
    final uri = Uri.parse("$baseUrl/evs/$evId/constraints");

    final Map<String, dynamic> body = {
      'start_time': start_time.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'target_percentage': targetPercentage,
    };

    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
  }
}
