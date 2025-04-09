import 'dart:async';
import 'dart:math';

import 'package:ev_charge/core/models.dart';
import 'package:ev_charge/viewmodels/home_page_vm.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageVM vm = HomePageVM();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        for (var ev in vm.evs) {
          ev.currentCharge = min(
            ev.carModel.batteryCapacity,
            ev.currentCharge + ev.currentChargingPower / 60 / 60,
          ); // convert kw to kwh / second
        }
      });
    });
    vm.getEvs();
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
        child: ListenableBuilder(
          listenable: vm,
          builder: (context, child) {
            if (vm.isError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(vm.errorMessage),
                  Padding(padding: EdgeInsets.all(16)),
                  ElevatedButton(
                    onPressed: vm.getEvs,
                    child: Text("Try again"),
                  ),
                ],
              );
            }
            if (vm.evs.isEmpty && !vm.loading && !vm.isError) {
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
                        onPressed: () => context.go("/addcar"),
                        label: Text("Add car"),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: vm.evs.length,
              itemBuilder: (context, index) {
                return EvCard(ev: vm.evs[index]);
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
                  Text("Charging Speed: ${ev.currentChargingPower} kW"),
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
