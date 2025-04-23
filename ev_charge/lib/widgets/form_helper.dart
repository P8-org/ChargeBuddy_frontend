import 'package:flutter/material.dart';
import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';

class FormHelper {

  static Padding inputField(String label, TextEditingController controller, String? Function(String?)? validator) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: label,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  static String? Function(String?)? intValidator() {
    return (value) {
      if (value == null || value.isEmpty || int.tryParse(value) == null) {
        return 'Please enter a numerical value';
      } else if (int.parse(value) < 0) {
        return 'Please enter a positive numerical value';
      }
      return null;
    };
  }

  static String? Function(String?)? doubleValidator() {
    return (value) {
      if (value == null || value.isEmpty || double.tryParse(value) == null) {
        return 'Please enter a numerical value';
      } else if (double.parse(value) < 0) {
        return 'Please enter a positive numerical value';
      }
      return null;
    };
  }

  static String? Function(String?)? stringValidator() {
    return (value) {
      if (value == null || value.isEmpty || value.length < 3) {
        return 'Please enter at least 3 characters';
      } else if (value.length > 64) {
        return 'Please enter at most 64 characters';
      }
      return null;
    };
  }
}

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
}

