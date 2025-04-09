import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ev_charge/core/get_electricity_prices.dart';
import 'package:ev_charge/viewmodels/electricity_prices.dart';
import 'package:http/http.dart' as http;

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

    final client = http.Client();
    final service = ElectricityPricesService(client);
    futureElectricityPrices = service.fetchElectricityPrices();
  }

  List<BarChartGroupData> getBarChartData(List<ElectricityPrices> prices) {
    return prices.asMap().entries.map((entry) {
      int index = entry.key;
      ElectricityPrices data = entry.value;

      final totalChartWidth = MediaQuery.of(context).size.width;
      final spacing = 4.0;
      final barWidth = (totalChartWidth / prices.length) - spacing;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data.price,
            color: data.barColor,
            width: barWidth.clamp(2.0, 20.0),
            borderRadius: BorderRadius.zero,
          ),
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

        final minPrice = prices
            .map((e) => e.price)
            .reduce((a, b) => a < b ? a : b);
        final maxPrice = prices
            .map((e) => e.price)
            .reduce((a, b) => a > b ? a : b);

        return Column(
          children: [
            // Bar Chart
            Container(
              margin: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.25,
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      direction: TooltipDirection.auto,
                      tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      tooltipPadding: EdgeInsets.all(8.0),
                      tooltipMargin: 1,
                    ),
                  ),
                  maxY: maxPrice + 100,
                  minY: minPrice < 0 ? minPrice - 100 : 0,
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
                          } else {
                            return const Text('');
                          }
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
