import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';


class EVForm extends StatefulWidget {
  const EVForm({super.key});

  @override
  EVFormState createState() {
    return EVFormState();
  }
}

Padding stringCollector(String label, TextEditingController controller) {
  return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: label,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: controller,
            ),
          );
}

Padding intCollector(String label, TextEditingController controller, ) { // TODO: Turn it into a year collector
  return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: label,
              ),
              validator: (value) {
                if (value == null || value.isEmpty || int.tryParse(value) == null) {
                  return 'Please enter a numerical value';
                } else if (int.parse(value) < 0) {
                  return 'Please enter a positive numerical value';
                }
                return null;
              },
              controller: controller,
            ),
          );
}

Padding doubleCollector(String label, TextEditingController controller, ) {
  return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: label,
              ),
              validator: (value) {
                if (value == null || value.isEmpty || int.tryParse(value) == null) {
                  return 'Please enter a numerical value';
                } else if (double.parse(value) < 0) {
                  return 'Please enter a positive numerical value';
                }
                return null;
              },
              controller: controller,
            ),
          );
}

Padding optionalStringCollector(String label, TextEditingController controller) {
  return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: label,
              ),
              controller: controller,
            ),
          );
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
      child: Column(
        children: <Widget>[
          stringCollector("Model", modelNameController),
          intCollector("Model Year", modelYearController),
          optionalStringCollector("Custom Name", userSetNameController),
          intCollector("Battery Capacity (kWh)", batteryCapacityController),
          intCollector("Maximum Charging Power (kW)", maxChargingPowerController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
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
      body: Column (
        children: [
          Center(
            child: const EVForm()
          ),
        ]
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
