import 'package:ev_charge/viewmodels/ev_page_vm.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

class EvPage extends StatefulWidget {
  const EvPage({super.key, required this.id});
  final int id;

  @override
  State<EvPage> createState() => _EvPageState();
}

class _EvPageState extends State<EvPage> {
  late EvPageVM vm = EvPageVM(id: widget.id);

  @override
  void initState() {
    super.initState();
    vm.getEv();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Ev details')),
          body: Center(
            child: Builder(
              builder: (context) {
                if (vm.loading || vm.ev == null) {
                  return CircularProgressIndicator();
                }
                return Builder(
                  builder: (context) {
                    final ev = vm.ev!;
                    final Color indicatorColor =
                        ev.currentChargingPower != 0
                            ? Colors.green
                            : Colors.red;
                    return Column(
                      spacing: 16,
                      children: [
                        SizedBox(height: 32),
                        Text(
                          ev.userSetName,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 15,
                          children: [
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: indicatorColor,
                            ),
                            Text(
                              "${ev.currentChargingPower} kW",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TweenAnimationBuilder(
                          tween: Tween(
                            begin:
                                ev.currentCharge / ev.carModel.batteryCapacity,
                            end: ev.currentCharge / ev.carModel.batteryCapacity,
                          ),
                          duration: Duration(seconds: 1),
                          builder: (context, value, child) {
                            return BatteryLevelCircle(
                              value: value,
                              limitValue: ev.constraint.targetPercentage,
                              height: 300,
                              width: 300,
                              strokeWidth: 30,
                              center: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        (value * 100).toStringAsFixed(1),
                                        style: TextStyle(fontSize: 48),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 84),
                                        child: Text(
                                          "%",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        ElevatedButton(
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                          },
                          child: Text("Schedule charging"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
