import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:go_router/go_router.dart';

class EVInfoCard extends StatelessWidget {
  final int id;
  final String userSetName;
  final String modelName;
  final int modelYear;
  final double batteryCapacity;
  final double maxChargingPower;
  final double currentCharge;
  final String state;
  final double targetPercentage;

  const EVInfoCard({
    super.key,
    required this.id,
    required this.userSetName,
    required this.modelName,
    required this.modelYear,
    required this.batteryCapacity,
    required this.maxChargingPower,
    required this.currentCharge,
    required this.state,
    required this.targetPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final Color stateColor =
        state == "charging"
            ? Colors.green
            : state == "idle"
            ? Colors.amber
            : Colors.red;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTileCard(
        borderRadius: BorderRadius.circular(20),
        baseColor: Colors.grey[300],
        expandedColor: Colors.blueGrey[50],
        leading: Icon(Icons.electric_car, color: Colors.blueAccent, size: 35),
        title: Text(
          userSetName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        subtitle: Text(
          'Model: $modelName\nCurrent Charge: ${currentCharge.toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 20),
        ),
        children: [
          const Divider(thickness: 1.0, height: 1.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Battery Capacity: ${batteryCapacity.toStringAsFixed(1)} kWh',
                ),
                Text(
                  'Max Charging Power: ${maxChargingPower.toStringAsFixed(1)} kW',
                ),
                Row(
                  children: [
                    const Text('Charging State:'),
                    const SizedBox(width: 8),
                    CircleAvatar(radius: 5, backgroundColor: stateColor),
                    const SizedBox(width: 8),
                    Text(state),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => context.go("/edit_ev/$id"),
                  label: Text("Edit EV"),
                  icon: Icon(Icons.edit),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TweenAnimationBuilder(
                    tween: Tween(
                      begin: currentCharge / batteryCapacity,
                      end: currentCharge / batteryCapacity,
                    ),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) {
                      return BatteryLevelCircle(
                        value: value,
                        limitValue: targetPercentage,
                        height: 200,
                        width: 200,
                        strokeWidth: 20,
                        center: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  (value * 100).toStringAsFixed(1),
                                  style: const TextStyle(fontSize: 48),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 84),
                                  child: Text(
                                    "%",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
