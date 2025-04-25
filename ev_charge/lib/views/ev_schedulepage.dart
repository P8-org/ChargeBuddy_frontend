import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/database/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navbar.dart';

class EvSchedulePage extends StatefulWidget {
  const EvSchedulePage({super.key, required this.id});
  final int id;

  @override
  State<EvSchedulePage> createState() => _EvSchedulePageState();
}

class _EvSchedulePageState extends State<EvSchedulePage> {
  double targetPercentage = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EV Schedule'), backgroundColor: Colors.green),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  context.go("/ev/${widget.id}/details");
                },
                icon: Icon(Icons.info),
                label: Text("View EV Details", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),

          // Expanded(
          //   child: Container(
          //     width: double.infinity,
          //     padding: const EdgeInsets.all(16.0),
          //     decoration: BoxDecoration(
          //       color: Colors.grey,
          //       borderRadius: BorderRadius.all(Radius.circular(16)),
          //     ),
          //     child: Center(
          //       child: Text(
          //         "Placeholder for future calendar/schedule implementation",
          //         style: TextStyle(color: Colors.black, fontSize: 30),
          //       ),
          //     ),
          //   ),
          // ),
          OutlinedButton(
            onPressed: () async {
              final TimeOfDay? deadline = await showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TimePickerDialog(initialTime: TimeOfDay.now()),
                            Text(
                              "${(targetPercentage * 100).toStringAsFixed(0)}%",
                            ),
                            Slider(
                              value: targetPercentage,
                              onChanged: (val) {
                                setState(() {
                                  targetPercentage = val;
                                });
                              },
                              max: 1,
                              min: 0,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
              if (deadline == null) return;
              final bs = BackendService();
              final now = DateTime.now();
              final date =
                  DateTime(
                        now.year,
                        now.month,
                        now.day,
                        deadline.hour,
                        deadline.minute,
                      ).isBefore(now)
                      ? DateTime(
                        now.year,
                        now.month,
                        now.day + 1,
                        deadline.hour,
                        deadline.minute,
                      )
                      : DateTime(
                        now.year,
                        now.month,
                        now.day,
                        deadline.hour,
                        deadline.minute,
                      );
              await bs.postConstraint(widget.id, date, targetPercentage);
              await DbManager.initialize();
            },
            child: Text("Update constraintst"),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
