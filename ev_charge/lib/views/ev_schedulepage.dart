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
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(
                child: Text(
                  "Placeholder for future calendar/schedule implementation",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
