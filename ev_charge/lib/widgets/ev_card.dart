import 'package:ev_charge/core/models.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        onLongPress: () {
          context.go("/edit_ev/${ev.id}");
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
