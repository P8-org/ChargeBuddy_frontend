import 'package:ev_charge/core/models.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/form_helper.dart';
import 'package:ev_charge/viewmodels/form_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EVForm extends ConsumerStatefulWidget {
  const EVForm({super.key, this.id});
  final int? id;

  @override
  EVFormState createState() {
    return EVFormState();
  }
}

class EVFormState extends ConsumerState<EVForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<EVFormState>.
  final _formKey = GlobalKey<FormState>();
  final vm = formVM();

  bool isLoading = false;

  TextEditingController modelNameController = TextEditingController();
  TextEditingController modelYearController = TextEditingController();
  TextEditingController batteryCapacityController = TextEditingController();
  TextEditingController userSetNameController = TextEditingController();
  TextEditingController maxChargingPowerController = TextEditingController();

  TextEditingController carModelController = TextEditingController();
  CarModel? selectedCarModel;

  @override
  void initState() {
    super.initState();
  }

  void initializeFields(UserEV ev) {
    if (widget.id == null) {
      return;
    } else {
      modelNameController.text = ev.carModel.modelName;
      modelYearController.text = ev.carModel.modelYear.toString();
      userSetNameController.text = ev.userSetName;
      batteryCapacityController.text = ev.carModel.batteryCapacity.toString();
      maxChargingPowerController.text = ev.carModel.maxChargingPower.toString();
    }
  }

  getInitialSelection(FormFieldState<int> state, List<CarModel> carModels, UserEV ev) {
    if (carModelController.text.isEmpty) {
      final entry = getCarModelEntries(
        carModels,
      ).firstWhere((carModelEntry) => carModelEntry.value == ev.carModel.id);
      selectedCarModel =
          carModels.where((carModel) => carModel.id == entry.value).first;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        state.didChange(entry.value);
      });
      return entry.value;
    }
  }

  Text formSnackbarText(success) {
    String suffix = userSetNameController.text.isEmpty ? modelNameController.text : userSetNameController.text;
    if (widget.id == null) {
      return Text(success ? "Successfully added '$suffix'" : "Failed to add '$suffix'. Try again later");
    } else {
      return Text(success ? "Successfully edited '$suffix'" : "Failed to edit '$suffix'. Try again later");
    }
  }

  Text formSubmissionText() {
    if (widget.id == null) {
      return const Text('Add EV');
    }
    return const Text('Save Changes');
  }

  List<DropdownMenuEntry> getCarModelEntries(List<CarModel> carModels) {
    return carModels
        .map((car) => DropdownMenuEntry(value: car.id, label: car.modelName))
        .toList();
  }

  Future<void> submitForm([UserEV? ev]) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    bool success = false;

    if (widget.id == null) {
      success = await vm.addEv(userSetNameController.text.isEmpty ? modelNameController.text : userSetNameController.text, selectedCarModel!);
    } else {
      success = await vm.putEv(userSetNameController.text.isEmpty ? modelNameController.text: userSetNameController.text, selectedCarModel!, ev!,);
    }

    if (mounted){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: formSnackbarText(success)));
      Navigator.of(context).pop();
    }  
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue<List<UserEV?>> evProvider;
    UserEV? ev;

    final carModels = ref.watch(carModelsProvider);

    if (widget.id != null) {
      evProvider = ref.watch(allUserEvsProvider); // TODO: Future optimization, use getSingleEVWithDetails, this requires getSingleEVWithDetails to be a Stream so it's values get updated.
      evProvider.when(
        loading: () => null,
        error: (e, _) {return const Scaffold(body: Center(child: Text("EV not found"))); },
        data: (data) {
          ev = data.firstWhere((ev) => ev!.id == widget.id);
          userSetNameController.text.isEmpty ? initializeFields(ev!) : null;
          },
      );
    }

    return carModels.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (e, _) => Scaffold(
            appBar: AppBar(title: const Text("EV details")),
            body: Center(child: Text("Error: $e")),
          ),
      data: (carModels) {
        if (widget.id != null && ev == null) {
          return const Scaffold(body: Center(child: Text("EV not found")));
        }

        return Stack(
          children: [
            Opacity(
              opacity: isLoading ? 0.5 : 1.0,
              child: AbsorbPointer(
                absorbing: isLoading,
                child: Form(
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
                              dropdownMenuEntries: getCarModelEntries(carModels),
                              menuHeight: 200,
                              expandedInsets: EdgeInsets.zero,
                              enableFilter: true,
                              errorText: state.errorText,
                              initialSelection: (widget.id == null ? null : getInitialSelection(state, carModels, ev!)),
                              onSelected: (value) {
                                if (value != null) {
                                  state.didChange(value as int);
                                  _formKey.currentState!.validate();
                                  setState(() {
                                    selectedCarModel = carModels.where((carModel) => carModel.id == value).first;
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
                                isLoading ? null : submitForm(ev);
                              },
                              child: formSubmissionText(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading) Center(child: CircularProgressIndicator()),
          ],
        );
      });
  }
}
