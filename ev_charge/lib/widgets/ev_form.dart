import 'package:ev_charge/core/models.dart';
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

  TextEditingController carModelController = TextEditingController();
  CarModel? selectedCarModel;

  late formVM vm;

  @override
  void initState() {
    super.initState();
    vm = formVM();
    if (widget.id != null) {
      vm.getEv(widget.id!);
    }
    vm.getCarmodels();
  }

  void initializeFields() {
    if (widget.id == null) {
      return;
    } else if (modelNameController.text.isEmpty) {
      modelNameController.text = vm.ev.carModel.modelName;
      modelYearController.text = vm.ev.carModel.modelYear.toString();
      userSetNameController.text = vm.ev.userSetName;
      batteryCapacityController.text = vm.ev.carModel.batteryCapacity.toString();
      maxChargingPowerController.text = vm.ev.carModel.maxChargingPower.toString();
    }
  }

  getInitialSelection(){
    if (widget.id == null) {
      return null;
    } else {
      return vm.ev.carModel.id;
    }
  }

  Text formSnackbarText() {
    if (widget.id == null) {
      return Text('Added: "${userSetNameController.text.isEmpty ? modelNameController.text : userSetNameController.text}"');
    }
    return Text('Saved: "${userSetNameController.text.isEmpty ? modelNameController.text : userSetNameController.text}"');
  }

  Text formSubmissionText() {
    if (widget.id == null) {
      return const Text('Add EV');
    }
    return const Text('Save Changes');
  }

  List<DropdownMenuEntry> getCarModelEntries() {
    return vm.carmodels
        .map((car) => DropdownMenuEntry(value: car.id, label: car.modelName))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListenableBuilder(
      listenable: vm,
      builder: (context, child) {
        if (vm.evLoading || vm.carmodelLoading) {
          return SizedBox();
        }
        initializeFields();
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              FormHelper.inputField("Custom Name", true, userSetNameController, FormHelper.optionalStringValidator()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: FormField<int>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormHelper.dropdownSelectionValidator(),
                  builder: (FormFieldState<int> state) {
                    return DropdownMenu(
                      label: Text("Select Car Model"),
                      controller: carModelController,
                      dropdownMenuEntries: getCarModelEntries(),
                      menuHeight: 200,
                      expandedInsets: EdgeInsets.zero,
                      errorText: state.errorText,
                      initialSelection: getInitialSelection(),
                      onSelected: (value) {
                        if (value != null) {
                          state.didChange(value as int);
                          _formKey.currentState!.validate();
                          setState(() {
                            selectedCarModel = vm.carmodels.where((carModel) => carModel.id == value).first;
                            modelNameController.text = selectedCarModel!.modelName.toString();
                            modelYearController.text = selectedCarModel!.modelYear.toString();
                            batteryCapacityController.text = selectedCarModel!.batteryCapacity.toString();
                            maxChargingPowerController.text = selectedCarModel!.maxChargingPower.toString();
                          });
                        }
                      },
                    );
                  },
                ),
              ),
              FormHelper.inputField("Model", false, modelNameController, null),
              FormHelper.inputField("Model Year", false, modelYearController, null),
              FormHelper.inputField("Battery Capacity (kWh)", false, batteryCapacityController, null),
              FormHelper.inputField("Maximum Charging Power (kW)", false, maxChargingPowerController, null),
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
                            vm.addEv(userSetNameController.text.isEmpty ? modelNameController.text : userSetNameController.text, selectedCarModel!);
                          } else {
                            vm.putEv(userSetNameController.text.isEmpty ? modelNameController.text : userSetNameController.text, selectedCarModel!, vm.ev);
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
