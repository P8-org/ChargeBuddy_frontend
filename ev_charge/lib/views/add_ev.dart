import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:ev_charge/widgets/form_input_fields.dart';


class EVForm extends StatefulWidget {
  const EVForm({super.key});

  @override
  EVFormState createState() {
    return EVFormState();
  }
}
class EVFormState extends State<EVForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<EVFormState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController modelNameController = TextEditingController();
  TextEditingController modelYearController = TextEditingController();
  TextEditingController batteryCapacityController = TextEditingController();
  TextEditingController userSetNameController = TextEditingController();
  TextEditingController maxChargingPowerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          formInputField("Model", modelNameController, stringValidator()),
          formInputField("Model Year", modelYearController, intValidator()),
          formInputField("Custom Name", userSetNameController, null),
          formInputField("Battery Capacity (kWh)", batteryCapacityController, doubleValidator()),
          formInputField("Maximum Charging Power (kW)", maxChargingPowerController, doubleValidator()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text ('Cancel')),
                ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added: "${modelNameController.text}"')),
                  );
                  
                  context.pop();
                }
                
              },
              child: const Text('Submit'),
            ),
              ],
            )
            
          ),

          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
class AddEv extends StatelessWidget {
  const AddEv({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add EV'),
        backgroundColor: Colors.blue,
      ),
      body: const EVForm(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
