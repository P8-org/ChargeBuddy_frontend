import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:ev_charge/widgets/electricity_prices_widget.dart';
import 'package:flutter/material.dart';

class ElectricityPricesPage extends StatelessWidget {
  const ElectricityPricesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity prices'),
        backgroundColor: Colors.green,
      ),
      body: Center(child: ElectricityPricesWidget()),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
