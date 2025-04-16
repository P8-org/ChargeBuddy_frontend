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
      appBar: AppBar(
        title: Text('EV Schedule'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            context.go("/ev/${widget.id}/details");
          },
          icon: Icon(Icons.info_outline),
          label: Text("View EV Details"),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}