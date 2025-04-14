import 'dart:async';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';
import 'package:flutter/material.dart';

// https://docs.flutter.dev/app-architecture/case-study
class HomePageVM extends ChangeNotifier {
  final BackendService _backendService;
  List<UserEV> _evs = List.empty();
  bool _loading = false;
  bool _isError = false;
  String _errorMessage = "";

  HomePageVM({BackendService? backendService})
    : _backendService = backendService ?? BackendService();

  List<UserEV> get evs => _evs;
  bool get loading => _loading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  Future<void> getEvs() async {
    _loading = true;
    notifyListeners();
    try {
      _evs = await _backendService.getEvs();
      _isError = false;
    } catch (e) {
      _isError = true;
      _errorMessage = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
