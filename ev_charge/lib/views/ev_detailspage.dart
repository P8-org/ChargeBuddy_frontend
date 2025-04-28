import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:ev_charge/widgets/charging_curve_widget.dart';
import 'package:ev_charge/widgets/electricity_prices_widget.dart';
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

        return Scaffold(
          appBar: AppBar(
            title: const Text('EV Details'),
            actions: [
              IconButton(
                onPressed: () async {
                  try {
                    await backendService.deleteEvById(id);
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: EVInfoCard(
                    id: ev.id,
                    userSetName: ev.userSetName,
                    modelName: ev.carModel.modelName,
                    modelYear: ev.carModel.modelYear,
                    batteryCapacity: ev.carModel.batteryCapacity,
                    maxChargingPower: ev.carModel.maxChargingPower,
                    currentCharge: ev.currentCharge,
                    state: ev.state,
                    targetPercentage: ev.constraint.targetPercentage,
                  ),
                ),
                ElectricityPricesWidget(),
                ChargingCurve(
                  chargingData: [
                    FlSpot(0, 0),
                    FlSpot(1, 5),
                    FlSpot(2, 15),
                    FlSpot(3, 30),
                    FlSpot(4, 50),
                    FlSpot(5, 69),
                    FlSpot(6, 71),
                    FlSpot(7, 71),
                    FlSpot(8, 71),
                    FlSpot(9, 71),
                    FlSpot(10, 82),
                    FlSpot(11, 82),
                    FlSpot(12, 82),
                    FlSpot(13, 90),
                    FlSpot(14, 90),
                    FlSpot(15, 90),
                    FlSpot(23, 100),
                  ],
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
