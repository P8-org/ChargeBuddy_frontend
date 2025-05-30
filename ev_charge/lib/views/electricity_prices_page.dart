import 'package:ev_charge/widgets/electricity_prices_widget.dart';
import 'package:flutter/material.dart';

class ElectricityPricesPage extends StatelessWidget {
  const ElectricityPricesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity prices'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Center(child: ElectricityPricesWidget()),
    );
  }
}
