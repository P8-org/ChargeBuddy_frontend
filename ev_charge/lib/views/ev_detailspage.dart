import 'package:ev_charge/viewmodels/ev_page_vm.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:ev_charge/widgets/charging_curve_widget.dart';
import 'package:ev_charge/widgets/electricity_prices_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_navbar.dart';

class EvDetailsPage extends StatefulWidget {
  const EvDetailsPage({super.key, required this.id});
  final int id;

  @override
  State<EvDetailsPage> createState() => _EvDetailsPageState();
}

class _EvDetailsPageState extends State<EvDetailsPage> {
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
          appBar: AppBar(
            title: const Text('EV Details'),
            actions: [
              IconButton(
                onPressed: () => vm.deleteEv(onSuccess: context.pop),
                icon: Icon(Icons.delete_forever_rounded),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Builder(
              builder: (context) {
                if (vm.loading || vm.ev == null) {
                  return SizedBox();
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
                        SizedBox(height: 8),
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
                        ElectricityPricesWidget(),
                        ChargingCurve(),
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
