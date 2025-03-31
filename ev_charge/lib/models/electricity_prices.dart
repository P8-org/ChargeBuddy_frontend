import 'package:flutter/material.dart';

class ElectricityPrices {
  final String hour;
  final double price;
  final Color barColor;

  ElectricityPrices({
    required this.hour,
    required this.price,
    required this.barColor,
  });
}

List<ElectricityPrices> generateElectricityPrices() {
  List<ElectricityPrices> prices = [];
  for (int i = 0; i <= 24; i++) {
    prices.add(ElectricityPrices(
      hour: '$i - ${i + 1}',
      price: (10 + i).toDouble(),
      barColor: Colors.blue,
    ));
  }
  return prices;
}
