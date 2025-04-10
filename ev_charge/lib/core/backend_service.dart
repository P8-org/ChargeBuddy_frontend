import 'dart:convert';
import 'dart:io';

import 'package:ev_charge/core/models.dart';
import 'package:http/http.dart';

class BackendService {
  final Client client;
  final String baseUrl;

  BackendService({Client? client, String? baseUrl})
    : client = client ?? Client(),
      baseUrl = baseUrl ?? "http://192.168.0.197:8000";

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
      throw HttpException('Http error: ${response.statusCode}', uri: uri);
    }
  }
}
