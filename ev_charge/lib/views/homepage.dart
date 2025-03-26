import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';

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
            icon: const Icon(Icons.account_circle), // change to user
            tooltip: 'Profile',
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
          child: ElevatedButton(
          onPressed: () {
            context.go('/infopage');
          },
          child: const Text('Go to Info Page'),
        ),
      ),
      Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/add-ev');
          },
          child: const Text('Add EV'))
      )
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
