import 'package:flutter/material.dart';


Padding formInputField(String label, TextEditingController controller, String? Function(String?)? validator) {
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

String? Function(String?)? intValidator() {
  return (value) {
    if (value == null || value.isEmpty || int.tryParse(value) == null) {
      return 'Please enter a numerical value';
    } else if (int.parse(value) < 0) {
      return 'Please enter a positive numerical value';
    }
    return null;
  };
}

String? Function(String?)? doubleValidator() {
  return (value) {
    if (value == null || value.isEmpty || double.tryParse(value) == null) {
      return 'Please enter a numerical value';
    } else if (double.parse(value) < 0) {
      return 'Please enter a positive numerical value';
    }
    return null;
  };
}

String? Function(String?)? stringValidator() {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  };
}