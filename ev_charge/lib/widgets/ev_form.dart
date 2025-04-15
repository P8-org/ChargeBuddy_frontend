import 'package:ev_charge/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/form_helper.dart';
import 'package:ev_charge/core/database.dart';

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
          FormHelper.inputField("Model", modelNameController, FormHelper.stringValidator()),
          FormHelper.inputField("Model Year", modelYearController, FormHelper.intValidator()),
          FormHelper.inputField("Custom Name", userSetNameController, null), // TODO: Not used for anything currently
          FormHelper.inputField("Battery Capacity (kWh)", batteryCapacityController, FormHelper.doubleValidator()),
          FormHelper.inputField("Maximum Charging Power (kW)", maxChargingPowerController, FormHelper.doubleValidator()),
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
              onPressed: () async {
                
                if (_formKey.currentState!.validate()) {
                  final db = ProviderScope.containerOf(context).read(dbProvider);

                  await db.into(db.eVCarModels).insert(EVCarModelsCompanion.insert(
                    modelName: modelNameController.text,
                    modelYear: int.parse(modelYearController.text),
                    batteryCapacity: double.parse(batteryCapacityController.text),
                    maxChargingPower: double.parse(maxChargingPowerController.text),
                  ));

                  if (context.mounted){
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added: "${modelNameController.text}"')),);
                    context.pop(); 
                  }
                }                
              },
              child: const Text('Submit'),
            ),
              ],
            )
          ),
        ],
      ),
    );
  }
}