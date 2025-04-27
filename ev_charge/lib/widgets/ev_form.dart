import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/form_helper.dart';
import 'package:ev_charge/viewmodels/form_vm.dart';

class EVForm extends StatefulWidget {
  const EVForm({super.key, this.id});
  final int? id;

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

  late formVM vm;

  @override
  void initState() {
    super.initState();
    vm = formVM();
    if (widget.id != null) {
      vm.getEv(widget.id!);
    }
  }

  ChangeNotifier getVM() {
    if (widget.id == null) {
      return ChangeNotifier();
    }
    return vm;
  }

  void initializeFields() {
    if (widget.id == null) {
      return;
    }
    modelNameController.text = vm.ev.carModel.modelName;
    modelYearController.text = vm.ev.carModel.modelYear.toString();
    userSetNameController.text = vm.ev.userSetName;
    batteryCapacityController.text = vm.ev.carModel.batteryCapacity.toString();
    maxChargingPowerController.text = vm.ev.carModel.maxChargingPower.toString();
  }

  Text formSnackbarText() {
    if (widget.id == null) {
      return Text('Added: "${modelNameController.text}"');
    }
    return Text('Saved: "${modelNameController.text}"');
  }

  Text formSubmissionText() {
    if (widget.id == null) {
      return const Text('Add EV');
    }
    return const Text('Save Changes');
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListenableBuilder(
      listenable: getVM(),
      builder: (context, child) {
        if (widget.id != null && vm.loading) {
          return SizedBox();
        }
        initializeFields();
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              FormHelper.inputField("Custom Name", false, userSetNameController, FormHelper.optionalStringValidator()),
              FormHelper.inputField("Model", true, modelNameController, FormHelper.stringValidator()),
              FormHelper.inputField("Model Year", true, modelYearController, FormHelper.intValidator()),
              FormHelper.inputField("Battery Capacity (kWh)", true, batteryCapacityController, FormHelper.doubleValidator()),
              FormHelper.inputField("Maximum Charging Power (kW)", true, maxChargingPowerController, FormHelper.doubleValidator()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                      onPressed: () {context.pop();},
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (widget.id == null) {
                            vm.addEv(modelNameController.text, modelYearController.text, userSetNameController.text, batteryCapacityController.text, maxChargingPowerController.text);
                          } else {
                            vm.putEv(modelNameController.text, modelYearController.text, userSetNameController.text, batteryCapacityController.text, maxChargingPowerController.text, vm.ev.carModelId, vm.ev.id);
                          }

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: formSnackbarText(),
                              ),
                            );
                            context.pop();
                          }
                        }
                      },
                      child: formSubmissionText(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
