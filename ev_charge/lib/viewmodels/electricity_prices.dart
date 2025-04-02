import 'package:flutter/material.dart';

class ElectricityPrices {
  final int hour;
  final double price;
  final Color barColor;

  ElectricityPrices({
    required this.hour,
    required this.price,
    this.barColor = Colors.green,
  });

  factory ElectricityPrices.fromJson(Map<String, dynamic> json) {
    return ElectricityPrices(
      hour: DateTime.parse(json['HourDK']).hour,
      price: (json['SpotPriceDKK'] as num).toDouble(),
    );
  }
}

