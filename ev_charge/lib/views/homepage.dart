import 'package:ev_charge/models/electricity_prices.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<ElectricityPrices> electricityPrices = List.generate(24, (index) {
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
            Container(
              margin: EdgeInsets.all(16.0),
              width:
                  MediaQuery.of(context).size.width *
                  0.9, // 90% of screen width
              height:
                  MediaQuery.of(context).size.height *
                  0.25, // 25% of screen height
              child: BarChart(
                BarChartData(
                  maxY: 35,
                  minY: 0,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}');
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}'); // X-Axis Labels
                        },
                      ),
                    ),
                  ),
                  barGroups: getBarChartData(),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
