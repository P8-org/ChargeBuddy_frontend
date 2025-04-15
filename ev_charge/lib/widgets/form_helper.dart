import 'package:flutter/material.dart';

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
