import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/core/models.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:ev_charge/widgets/charging_curve_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/bottom_navbar.dart';

class EvDetailsPage extends ConsumerWidget {
  const EvDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ev = ref.watch(singleEvDetailProvider(id));
    final backendService = BackendService();

    return ev.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (e, _) => Scaffold(
            appBar: AppBar(title: const Text("EV details")),
            body: Center(child: Text("Error: $e")),
          ),
      data: (ev) {
        if (ev == null) {
          return const Scaffold(body: Center(child: Text("EV not found")));
        }
        final indicatorColor =
            ev.state == "charging"
                ? Colors.green
                : ev.state == "idle"
                ? Colors.amber
                : Colors.red;

        final chargingCurveData =
            ev.schedule.scheduleData
                .split(',')
                .map((e) => double.tryParse(e) ?? 0.0)
                .toList();

        final cumulativeChargingCurve = <double>[];

        // add items to make the graph start from current hour
        cumulativeChargingCurve.add(ev.schedule.startCharge);
        cumulativeChargingCurve.add(ev.schedule.startCharge);

        double sum = ev.schedule.startCharge;
        for (final value in chargingCurveData) {
          sum += value;
          cumulativeChargingCurve.add(sum);
        }
        double currentX = getNowX(ev, cumulativeChargingCurve);

        return Scaffold(
          appBar: AppBar(
            title: const Text('EV Details'),
            actions: [
              IconButton(
                onPressed: () async {
                  try {
                    await backendService.deleteEvById(id);
                    if (!context.mounted) return;
                    context.pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to delete: $e")),
                    );
                  }
                },
                icon: const Icon(Icons.delete_forever_rounded),
              ),
            ],
            backgroundColor: Colors.green,
          ),
          body: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 8),
                Text(
                  ev.userSetName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 5, backgroundColor: indicatorColor),
                    const SizedBox(width: 8),
                    Text(
                      ev.currentChargingPower != 0
                          ? "${ev.state[0].toUpperCase()}${ev.state.substring(1)} ${ev.currentChargingPower} kW"
                          : "${ev.state[0].toUpperCase()}${ev.state.substring(1)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TweenAnimationBuilder(
                  tween: Tween(
                    begin: ev.currentCharge / ev.carModel.batteryCapacity,
                    end: ev.currentCharge / ev.carModel.batteryCapacity,
                  ),
                  duration: const Duration(seconds: 1),
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
                SizedBox(height: 16),
                if (ev.schedule.end.isAfter(DateTime.now()))
                  ChargingCurve(
                    currentX: currentX,
                    chargingData: List.generate(
                      cumulativeChargingCurve.length,
                      (index) => FlSpot(
                        index.toDouble(),
                        cumulativeChargingCurve[index] /
                            ev.carModel.batteryCapacity *
                            100,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }

  // used to get the x-coordinate for the vertical line at the current time
  double getNowX(UserEV ev, List<double> cumulativeChargingCurve) {
    final totalDuration =
        ev.schedule.end.difference(ev.schedule.start).inSeconds + 3600;
    final currentDuration =
        DateTime.now().difference(ev.schedule.start).inSeconds + 3600;

    final progress = currentDuration / totalDuration;
    final currentX = progress * cumulativeChargingCurve.length;
    return currentX;
  }
}
