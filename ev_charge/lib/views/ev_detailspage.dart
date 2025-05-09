import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/charging_curve_widget.dart';
import 'package:ev_charge/widgets/ev_info_card.dart';
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

        final chargingCurveData =
            ev.schedule.scheduleData
                .split(',')
                .map((e) => double.tryParse(e) ?? 0.0)
                .toList();

        final padLength =
            ev.schedule.start
                .difference(DateTime.now().add(Duration(hours: -1)))
                .inHours;

        final cumulativeChargingCurve = <double>[];

        // add items to make the graph start from current hour
        for (var i = 0; i <= padLength; i++) {
          cumulativeChargingCurve.add(ev.schedule.startCharge);
        }

        double sum = ev.schedule.startCharge;
        for (final value in chargingCurveData) {
          sum += value;
          cumulativeChargingCurve.add(sum);
        }

        // // remove 'old' data
        if (padLength < 0) {
          final removeCount = padLength.abs().clamp(
            0,
            cumulativeChargingCurve.length,
          );
          cumulativeChargingCurve.removeRange(0, removeCount);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('EV Details'),
            actions: [
              IconButton(
                onPressed: () async {
                  try {
                    await backendService.deleteEvById(id);
                    if (!context.mounted) return;
                    context.go('/home');
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: EVInfoCard(id: ev.id),
                ),
                SizedBox(height: 16),
                if (ev.schedule.end.isAfter(DateTime.now()))
                  ChargingCurve(
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
}
