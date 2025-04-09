import 'dart:async';

import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navbar.dart';

class EvPage extends StatefulWidget {
  EvPage(this.evId, {super.key, BackendService? backendService})
    : backendService = backendService ?? BackendService();

  final BackendService backendService;

  final int evId;

  @override
  State<EvPage> createState() => _EvPageState();
}

class _EvPageState extends State<EvPage> {
  late UserEV ev = UserEV(
    id: 0,
    userSetName: "",
    currentCharge: 0,
    currentChargingPower: 0,
    carModelId: 0,
    carModel: CarModel(
      id: 0,
      modelName: "",
      modelYear: 0,
      batteryCapacity: 100,
      maxChargingPower: 100,
    ),
    constraint: Constraint(
      id: 0,
      chargedBy: DateTime.now(),
      targetPercentage: 0,
    ),
    schedule: Schedule(
      id: 0,
      start: DateTime.now(),
      end: DateTime.now(),
      scheduleData: "",
    ),
  );
  Timer? _timer;

  Future<void> getEv() async {
    ev = await widget.backendService.getEvById(widget.evId);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    getEv();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var indicatorColor = ev.id == 0 ? Colors.red : Colors.green;
    var indicatorText = ev.id == 0 ? "Not connected to charger" : "Charging";
    if (ev.id == 2) {
      indicatorColor = Colors.amber;
      indicatorText = "Charging starts at 3:00";
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ev details')),
      body: Center(
        child: Builder(
          builder: (context) {
            return Column(
              spacing: 16,
              children: [
                Padding(padding: EdgeInsets.all(16)),
                Text(
                  ev.userSetName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Padding(padding: EdgeInsets.all(4)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    CircleAvatar(radius: 5, backgroundColor: indicatorColor),
                    Text(indicatorText, style: TextStyle(fontSize: 18)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(4)),
                TweenAnimationBuilder(
                  tween: Tween(
                    begin: ev.currentCharge / ev.carModel.batteryCapacity,
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
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
