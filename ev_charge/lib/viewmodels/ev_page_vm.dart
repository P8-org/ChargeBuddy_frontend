import 'dart:async';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';
import 'package:flutter/material.dart';

class EvPageVM extends ChangeNotifier {
  final int id;
  final BackendService _backendService;
  UserEV? _ev;
  bool _loading = false;
  bool _isError = false;
  String _errorMessage = "";

  EvPageVM({required this.id, BackendService? backendService})
    : _backendService = backendService ?? BackendService();

  UserEV? get ev => _ev;
  bool get loading => _loading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  Future<void> getEv() async {
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
}
