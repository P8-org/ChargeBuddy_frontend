import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const contentColorCyan = Color(0xff23b6e6);
  static const contentColorBlue = Color(0xff02d39a);
  static const mainGridLineColor = Color(0xff37434d);
}

class ChargingCurve extends StatefulWidget {
  final List<FlSpot> chargingData;
  final double currentX;
  const ChargingCurve({
    super.key,
    required this.chargingData,
    required this.currentX,
  });

  @override
  State<ChargingCurve> createState() => _ChargingCurveState();
}

class _ChargingCurveState extends State<ChargingCurve> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  @override
  Widget build(BuildContext context) {
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
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 32,
              left: 18,
              top: 0,
              bottom: 32,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.w600, fontSize: 12);
    final hour = DateTime.now().add(Duration(hours: value.toInt())).hour;

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
                  "${DateTime.now().add(Duration(hours: spot.x.toInt())).hour}:00";

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
            interval: _calcInterval(),
            getTitlesWidget: bottomTitleWidgets,
            maxIncluded: false,
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
      maxX: widget.chargingData.length.toDouble() - 1,
      minY: -0.001,
      maxY: 100.001,
      lineBarsData: [
        LineChartBarData(
          spots: widget.chargingData,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 5,
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
            x: widget.currentX,
            color: Colors.grey,
            dashArray: [5],
            label: VerticalLineLabel(show: true, labelResolver: (p0) => "Now"),
          ),
        ],
      ),
    );
  }

  double _calcInterval() {
    double chartWidth = MediaQuery.of(context).size.width - 50;
    double approxLabelWidth = 50;
    int maxLabels = (chartWidth / approxLabelWidth).floor();
    double interval = (widget.chargingData.length / maxLabels).ceilToDouble();
    return interval < 1 ? 1 : interval;
  }
}
