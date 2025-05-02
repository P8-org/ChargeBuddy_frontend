import 'package:flutter/material.dart';
class FormHelper {
  static Padding inputField(
    String label,
    bool enabled,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          label: Text(label),
        ),
        validator: validator,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
      ),
    );
  }

  static String? Function(String?)? optionalStringValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return null;
      } else if (value.length < 3) {
        return 'Please enter at least 3 characters or none at all';
      } else if (value.length > 64) {
        return 'Please enter at most 64 characters or none at all';
      }
      return null;
    };
  }

  static String? Function(int?)? dropdownSelectionValidator() {
    return (int? value) {
      if (value == null) {
        return 'Please select a model from the dropdown menu';
      }
      return null;
    };
  }
}