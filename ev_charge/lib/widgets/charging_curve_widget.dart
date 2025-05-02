import 'dart:async';

import 'package:ev_charge/core/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const contentColorCyan = Color(0xff23b6e6);
  static const contentColorBlue = Color(0xff02d39a);
  static const mainGridLineColor = Color(0xff37434d);
}

class ChargingCurve extends StatefulWidget {
  final UserEV ev;

  const ChargingCurve({super.key, required this.ev});

  @override
  State<ChargingCurve> createState() => _ChargingCurveState();
}

class _ChargingCurveState extends State<ChargingCurve> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        // to refresh Now line on chart
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ev.schedule.end.isBefore(DateTime.now())) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.battery_charging_full, color: Colors.green),
              Text(
                'Charging Curve',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 32,
              left: 18,
              top: 32,
              bottom: 16,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.w600, fontSize: 12);
    final hour =
        widget.ev.schedule.start.add(Duration(hours: value.toInt() - 1)).hour;

    return SideTitleWidget(meta: meta, child: Text('$hour:00', style: style));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);
    String text;
    if (value % 20 == 0) {
      text = '${value.toInt()}%';
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    List<Color> gradientColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.tertiary,
    ];
    final chargingData =
        widget.ev.schedule.scheduleData
            .split(',')
            .map((e) => double.tryParse(e) ?? 0.0)
            .toList();

    final cumulativeChargingCurve = <double>[];

    // add items to make the graph start one hour before schedule.start
    cumulativeChargingCurve.add(widget.ev.schedule.startCharge);
    cumulativeChargingCurve.add(widget.ev.schedule.startCharge);

    double sum = widget.ev.schedule.startCharge;
    for (final value in chargingData) {
      sum += value;
      cumulativeChargingCurve.add(sum);
    }
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipRoundedRadius: 8,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final time =
                  "${widget.ev.schedule.start.add(Duration(hours: spot.x.toInt() - 1)).hour}:00";

              final percentage = '${spot.y.toStringAsFixed(0)}%';
              return LineTooltipItem(
                '$time\n$percentage',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 20,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).dividerColor.withAlpha(100),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: _calcInterval(chargingData),
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 20,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(
          color: Theme.of(context).dividerColor.withAlpha(100),
        ),
      ),
      minX: 0,
      maxX: cumulativeChargingCurve.length.toDouble() - 1,
      minY: -0.001,
      maxY: 100.001,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            cumulativeChargingCurve.length,
            (index) => FlSpot(
              index.toDouble(),
              cumulativeChargingCurve[index] /
                  widget.ev.carModel.batteryCapacity *
                  100,
            ),
          ),
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 4,
          isStrokeCapRound: false,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  gradientColors
                      .map((color) => color.withValues(alpha: 0.3))
                      .toList(),
            ),
          ),
        ),
      ],
      extraLinesData: ExtraLinesData(
        verticalLines: [
          VerticalLine(
            x: _getNowX(cumulativeChargingCurve),
            color: Colors.grey,
            dashArray: [5],
            label: VerticalLineLabel(
              show: true,
              labelResolver: (p0) => "Now",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  double _calcInterval(List<double> chargingData) {
    double chartWidth = MediaQuery.of(context).size.width - 50;
    double approxLabelWidth = 60;
    int maxLabels = (chartWidth / approxLabelWidth).floor();
    double interval = (chargingData.length / maxLabels).ceilToDouble();
    return interval < 1 ? 1 : interval;
  }

  // used to get the x-coordinate for the vertical line at the current time
  double _getNowX(List<double> cumulativeChargingCurve) {
    final totalDuration =
        widget.ev.schedule.end.difference(widget.ev.schedule.start).inSeconds +
        3600 * 2;
    final currentDuration =
        DateTime.now().difference(widget.ev.schedule.start).inSeconds + 3600;

    final progress = currentDuration / totalDuration;
    final currentX = progress * cumulativeChargingCurve.length;
    return currentX;
  }
}
