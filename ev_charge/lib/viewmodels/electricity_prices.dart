import 'package:flutter/material.dart';

class ElectricityPrices {
  final int hour;
  final double price;
  final Color barColor;

  static const double tax = 0.951;
  static const double convertToKwh = 1000.0;

  ElectricityPrices({
    required this.hour,
    required this.price,
    this.barColor = Colors.green,
  });

  factory ElectricityPrices.fromJson(Map<String, dynamic> json) {
    return ElectricityPrices(
      hour: DateTime.parse(json['HourDK']).hour,
      price: (json['SpotPriceDKK'] as num).toDouble() / convertToKwh + tax,
    );
  }
}
