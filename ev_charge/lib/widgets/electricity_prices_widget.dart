import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ev_charge/core/get_electricity_prices.dart';
import 'package:ev_charge/viewmodels/electricity_prices.dart';

class ElectricityPricesWidget extends StatefulWidget {
  const ElectricityPricesWidget({super.key});

  @override
  State<ElectricityPricesWidget> createState() =>
      _ElectricityPricesWidgetState();
}

class _ElectricityPricesWidgetState extends State<ElectricityPricesWidget> {
  late Future<List<ElectricityPrices>> futureElectricityPrices;

  @override
  void initState() {
    super.initState();
    futureElectricityPrices = ElectricityPricesService.fetchElectricityPrices();
  }

  List<BarChartGroupData> getBarChartData(List<ElectricityPrices> prices) {
    return prices.asMap().entries.map((entry) {
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
    return FutureBuilder<List<ElectricityPrices>>(
      future: futureElectricityPrices,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        final prices = snapshot.data!.reversed.toList();

        return Column(
          children: [
            // Bar Chart
            Container(
              margin: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.25,
              child: BarChart(
                BarChartData(
                  maxY:
                      prices
                          .map(
                            (e) => e.price,
                          ) // makes a list of only the prices
                          .reduce((a, b) => a > b ? a : b) +
                      5, // finds the maximum price and adds 5 to it
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
                        reservedSize: 50,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}');
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int hourIndex = value.toInt();

                          if (hourIndex % 3 == 0) {
                            return Text('${prices[hourIndex].hour}');
                          } else
                            return const Text('');
                        },
                      ),
                    ),
                  ),
                  barGroups: getBarChartData(prices),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
