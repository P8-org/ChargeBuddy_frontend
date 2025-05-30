import 'package:flutter/material.dart';

class BatteryLevelCircle extends StatelessWidget {
  const BatteryLevelCircle({
    super.key,
    required this.value,
    required this.height,
    required this.width,
    required this.strokeWidth,
    this.center,
    this.limitValue,
  });

  final double value;
  final Widget? center;
  final double height;
  final double width;
  final double strokeWidth;
  final double? limitValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            value: limitValue ?? 0,
            strokeWidth: strokeWidth,
            // ignore: deprecated_member_use
            year2023: false,
            trackGap: 0,
            color: Theme.of(context).dividerColor.withAlpha(50),
            backgroundColor: Theme.of(context).dividerColor.withAlpha(50),
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: strokeWidth,
            // ignore: deprecated_member_use
            year2023: false,
            trackGap: 0,
            backgroundColor: Colors.transparent,
            color:
                HSVColor.lerp(
                  HSVColor.fromColor(Colors.red),
                  HSVColor.fromColor(Colors.green),
                  value,
                )!.toColor(),
          ),
        ),
        if (center != null) center!,
      ],
    );
  }
}
