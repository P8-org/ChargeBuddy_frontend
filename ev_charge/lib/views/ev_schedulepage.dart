import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_navbar.dart';
import '../views/calendar_page.dart';

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
      appBar: AppBar(
        title: Text('EV Schedule'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
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
              child: EventCalendarPage(id: widget.id)               
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
