// import 'dart:async';
// import 'package:ev_charge/database/database.dart';
// import 'package:flutter/material.dart';
//
// // https://docs.flutter.dev/app-architecture/case-study
// class HomePageVM extends ChangeNotifier {
//   final AppDatabase _db;
//   List<UserEV> _evs = List.empty();
//   bool _loading = false;
//   bool _isError = false;
//   String _errorMessage = "";
//
//   HomePageVM({required AppDatabase db}) : _db = db;
//
//   List<UserEV> get evs => _evs;
//   bool get loading => _loading;
//   bool get isError => _isError;
//   String get errorMessage => _errorMessage;
//
//   Future<void> getEvs() async {
//     _loading = true;
//     notifyListeners();
//     try {
//       _evs = await _backendService.getEvs();
//       _isError = false;
//     } catch (e) {
//       _isError = true;
//       _errorMessage = e.toString();
//     } finally {
//       _loading = false;
//       notifyListeners();
//     }
//   }
// }
