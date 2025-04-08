import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:ev_charge/widgets/charging_constraints_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/infopage');
              },
              child: const Text('Go to Info Page'),
            ),
            ElevatedButton( //Just a demo, should be removed and placed when we implement a calendar,
              onPressed: () {
                final today = DateTime.now();
                showChargingConstraintsSheet(context, today, (minCharge, deadline) {
                  print('Test Save: $minCharge% by $deadline');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved: $minCharge% by ${deadline.toLocal()}'),
                    ),
                  );
                });
              },
              child: const Text('Test Charging Constraints'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    ); 
  }
}
