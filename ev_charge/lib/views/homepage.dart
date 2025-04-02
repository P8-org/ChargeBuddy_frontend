import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:ev_charge/widgets/electricity_prices_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  /*final List<ElectricityPrices> electricityPrices = List.generate(24, (index) {
    return ElectricityPrices(
      hour: '$index - ${index + 1}',
      price: (10 + index).toDouble(),
      barColor: Colors.blue,
    );
  });

  List<BarChartGroupData> getBarChartData() {
    return electricityPrices.asMap().entries.map((entry) {
      int index = entry.key;
      ElectricityPrices data = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(toY: data.price, color: data.barColor, width: 12),
        ],
      );
    }).toList();
  }
   */

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
      body: const ElectricityPricesWidget(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
