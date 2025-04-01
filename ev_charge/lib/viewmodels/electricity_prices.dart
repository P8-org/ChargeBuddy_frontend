import 'package:flutter/material.dart';

class ElectricityPrices {
  final int hour;
  final double price;
  final Color barColor;

  ElectricityPrices({
    required this.hour,
    required this.price,
    this.barColor = Colors.blue,
  });

  factory ElectricityPrices.fromJson(Map<String, dynamic> json) {
    return ElectricityPrices(
      hour: DateTime.parse(json['HourDK']).hour,
      price: (json['SpotPriceDKK'] as num).toDouble(),
    );
  }
}

List<ElectricityPrices> generateElectricityPrices() {
  List<ElectricityPrices> prices = [];
  for (int i = 0; i < 24; i++) {
    prices.add(
      ElectricityPrices(
        hour: i,
        price: i.toDouble(),
        barColor: Colors.blue,
      ),
    );
  }
  return prices;
}
