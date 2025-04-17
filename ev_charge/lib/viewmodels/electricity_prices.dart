import 'package:flutter/material.dart';

class ElectricityPrices {
  final int hour;
  final double price;
  final Color barColor;

  static const double tax = 0.951;

  ElectricityPrices({
    required this.hour,
    required this.price,
    this.barColor = Colors.green,
  });

  factory ElectricityPrices.fromJson(Map<String, dynamic> json) {
    return ElectricityPrices(
      hour: DateTime.parse(json['time']).hour,
      price: (json['price'] as num).toDouble() + tax,
    );
  }
}
