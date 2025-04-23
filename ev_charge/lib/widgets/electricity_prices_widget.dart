import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ev_charge/core/get_electricity_prices.dart';
import 'package:ev_charge/viewmodels/electricity_prices.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

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

  List<BarChartGroupData> getBarChartData(
    List<ElectricityPrices> prices,
    double barsWidth,
    double barsSpace,
  ) {
    return prices.asMap().entries.map((entry) {
      int index = entry.key;
      ElectricityPrices data = entry.value;

      return BarChartGroupData(
        x: index,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: data.price,
            color: data.barColor,
            width: barsWidth.clamp(2.0, 20.0),
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

        final minPrice = prices.map((e) => e.price).reduce(min);
        final maxPrice = prices.map((e) => e.price).reduce(max);

        double formatPrice(double price) {
          return double.parse(price.toStringAsFixed(2));
        }

        final chartMinY = minPrice < 0 ? formatPrice(minPrice - 0.1) : 0.0;
        final chartMaxY = formatPrice(maxPrice + 0.1);

        return AspectRatio(
          aspectRatio: 1.66,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barsSpace = 4.0 * constraints.maxWidth / 400;
                final barsWidth = 8.0 * constraints.maxWidth / 400;

                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final hour = prices[group.x].hour;
                          final price = rod.toY;

                          return BarTooltipItem(
                            '$hour:00\n',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(
                                text: '${price.toStringAsPrecision(3)} kr',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          );
                        },
                        direction: TooltipDirection.auto,
                        tooltipHorizontalAlignment:
                            FLHorizontalAlignment.center,
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        tooltipPadding: const EdgeInsets.all(8.0),
                        tooltipMargin: 1,
                      ),
                    ),
                    maxY: chartMaxY,
                    minY: chartMinY,
                    gridData: FlGridData(show: false),
                    extraLinesData:
                        minPrice < 0
                            ? ExtraLinesData(
                              horizontalLines: [
                                HorizontalLine(
                                  y: 0,
                                  color: Colors.grey,
                                  strokeWidth: 1.5,
                                ),
                              ],
                            )
                            : ExtraLinesData(),
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
                            return Text('${value.toStringAsFixed(2)} kr');
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int hourIndex = value.toInt();
                            if (hourIndex % 3 == 0 &&
                                hourIndex < prices.length) {
                              return Text('${prices[hourIndex].hour}');
                            } else {
                              return const Text('');
                            }
                          },
                        ),
                      ),
                    ),
                    barGroups: getBarChartData(prices, barsWidth, barsSpace),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
