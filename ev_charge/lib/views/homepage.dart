import 'dart:async';
import 'dart:math';

import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';

// final List<UserEV> evsList = List.from([
//   UserEV(
//     id: 0,
//     carModelId: 0,
//     userSetName: "Renault 5",
//     currentCharge: 31.45,
//     batteryCapacity: 52,
//     maxChargingPower: 100,
//     currentChargingPower: 0,
//   ),
//   UserEV(
//     id: 1,
//     carModelId: 1,
//     userSetName: "BMW i4",
//     currentCharge: 1.231,
//     batteryCapacity: 83.9,
//     maxChargingPower: 4000,
//     currentChargingPower: 4000,
//   ),
//   UserEV(
//     id: 2,
//     carModelId: 2,
//     userSetName: "Volvo EX30",
//     currentCharge: 50,
//     batteryCapacity: 69,
//     maxChargingPower: 134,
//     currentChargingPower: 0,
//   ),
// ]);

class HomePage extends StatefulWidget {
  HomePage({super.key, BackendService? backendService})
    : backendService = backendService ?? BackendService();

  final BackendService backendService;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserEV> _evs = List.empty();
  Timer? _timer;
  bool _isLoading = false;
  bool _isError = false;
  String _errorMessage = "";

  Future<void> loadEvs() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var evs = await widget.backendService.getEvs();
      setState(() {
        _evs = evs;
        _isError = false;
      });
    } catch (e) {
      _isError = true;
      _errorMessage = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        for (var ev in _evs) {
          ev.currentCharge = min(
            ev.carModel.batteryCapacity,
            ev.currentCharge + ev.currentChargingPower / 60 / 60,
          ); // convert kw to kwh / second
        }
      });
    });
    loadEvs();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle), // change to user
            tooltip: 'Profile',
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            if (_isError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_errorMessage),
                  Padding(padding: EdgeInsets.all(16)),
                  ElevatedButton(onPressed: loadEvs, child: Text("Try again")),
                ],
              );
            }
            if (_evs.isEmpty && !_isLoading && !_isError) {
              Card(
                elevation: 4,
                margin: const EdgeInsets.all(16),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text("No cars in db"),
                      ElevatedButton.icon(
                        onPressed: () => context.push("/addcar"),
                        label: Text("Add car"),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: _evs.length,
              itemBuilder: (context, index) {
                return EvCard(ev: _evs[index]);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class EvCard extends StatelessWidget {
  final UserEV ev;

  const EvCard({super.key, required this.ev});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.go("/car/${ev.id}");
        },
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    ev.userSetName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "${ev.currentCharge.toStringAsFixed(1)} / ${ev.carModel.batteryCapacity.toStringAsFixed(1)} kWh",
                  ),
                  Text("Current Charging Speed: ${ev.currentChargingPower} kW"),
                  Text(
                    "Max Charging Speed: ${ev.carModel.maxChargingPower} kW",
                  ),
                ],
              ),
              Column(
                children: [
                  BatteryLevelCircle(
                    value: ev.currentCharge / ev.carModel.batteryCapacity,
                    height: 100,
                    width: 100,
                    strokeWidth: 10,
                    center:
                        ev.currentChargingPower != 0.0
                            ? Icon(
                              Icons.battery_charging_full_rounded,
                              color: Theme.of(context).hintColor,
                            )
                            : Icon(
                              Icons.battery_0_bar_rounded,
                              color: Theme.of(context).hintColor,
                            ),
                  ),
                  Text(
                    "${(ev.currentCharge / ev.carModel.batteryCapacity * 100).toStringAsFixed(0)}%",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
